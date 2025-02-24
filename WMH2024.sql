USE Portfolio;


SET DATEFORMAT dmy;  -- Forces SQL Server to interpret dates as DD/MM/YYYY

SELECT * FROM WusakileHospital2024;

-- New Permanent table
CREATE TABLE WMH2024 (
    ProclinNumber VARCHAR(255), Guarantor VARCHAR(100), GuarantorName VARCHAR(100), Gender VARCHAR(8), AdmissionDate DATE, 
	AdmissionTime TIME, DischargeDate DATE, DischargeTime TIME, TotalMinutesSpent INT, TimeSpent_HHMM VARCHAR(255), 
	HistFileNo VARCHAR(255), AccountType VARCHAR(255), MedicalSchemeName VARCHAR(255), MedicalSchemeNo VARCHAR(255), 
	PatientType VARCHAR(255), Ward VARCHAR(255), Bed VARCHAR(255), PrimaryDiagnosisCode VARCHAR(255), 
	PrimaryDiagnosisDesc VARCHAR(255),	AdmissionReason1 VARCHAR(255), AdmissionReasonDesc1 VARCHAR(255), 
	AdmissionOperator VARCHAR(255), DischargeOperator VARCHAR(255), AdmissionDoctor VARCHAR(255));

-- Inserting data with proper conversion
INSERT INTO WMH2024
	SELECT
		PatientNumber AS ProclinNumber, Guarantor, GuarantorName, Gender, 
	
		DATEDIFF(YEAR, TRY_CAST(DOB AS DATE), GETDATE()) - 
		CASE 
			WHEN MONTH(TRY_CAST(DOB AS DATE)) > MONTH(GETDATE()) 
				 OR (MONTH(TRY_CAST(DOB AS DATE)) = MONTH(GETDATE()) AND DAY(TRY_CAST(DOB AS DATE)) > DAY(GETDATE())) 
			THEN 1 
			ELSE 0 
		END AS Age,

		TRY_CAST(DOB AS DATE) AS DateOfBirth,
		TRY_CAST(AdmissionDate AS DATE) AS AdmissionDate, 
		STUFF(AdmissionTme, 3, 0, ':') AS AdmissionTime, 
		TRY_CAST(DischargeDate AS DATE) AS DischargeDate, 
		STUFF(DischargeTime, 3, 0, ':') AS DischargeTime,

		-- Convert VARCHAR time to TIME format
		DATEDIFF(MINUTE, 
			STUFF(AdmissionTme, 3, 0, ':'),
			STUFF(DischargeTime, 3, 0, ':')
		) AS TotalMinutesSpent,

		-- Convert total minutes into HH:MM format
		FORMAT(
			DATEADD(MINUTE, 
				DATEDIFF(MINUTE, STUFF(AdmissionTme, 3, 0, ':'), STUFF(DischargeTime, 3, 0, ':')), '00:00:00'), 
			'HH:mm'
		) AS TimeSpent_HHMM,
		HistFileNo,	AccountType, MedicalSchemeName,	MedicalSchemeNo, PatientType, Ward,	Bed, 
		PrimaryDiagnosisCode, PrimaryDiagnosisDesc,	AdmissionReason1, AdmissionReasonDesc1, 
		DischargeDiagnosis1, DischargeDiagnosis2, Operator AS AdmissionOperator, DischargeOperator, AdmissionDoctor
	FROM WusakileHospital2024;

SELECT * FROM WMH2024 ORDER BY AdmissionDate;


---Annual total number of IN and OUT patients, visits, admissions, discharge total male and female seen in 2024

GO
CREATE VIEW View_WMH_Annual_2024 AS
	SELECT
		COUNT(DISTINCT AdmissionDoctor) AS TotalDoctors,
		COUNT(ProclinNumber) AS TotalPatient,
		SUM(CASE WHEN AdmissionDate = DischargeDate THEN 1 ELSE 0 END) AS TotalOutPatient,
		SUM(CASE WHEN AdmissionDate <> DischargeDate THEN 1 ELSE 0 END) AS TotalInPatient,
		SUM(CASE WHEN Gender = 'Male' OR Gender = 'male' THEN 1 ELSE 0 END) AS TotalMales,
		SUM(CASE WHEN Gender = 'Female' OR Gender = 'female' THEN 1 ELSE 0 END) AS TotalFemales,
		CONCAT('1:', CAST(NULLIF(COUNT(*) / NULLIF(COUNT(DISTINCT AdmissionDoctor), 0), 0) AS INT)) AS DoctorToPatientRatio
	FROM WMH2024;
GO

SELECT CONCAT('1:', CAST(NULLIF(COUNT(*) / NULLIF(COUNT(DISTINCT AdmissionDoctor), 0), 0) AS INT)) AS DoctorToPatientRatio FROM WMH2024;


---Doctor or Incharge workload count:
SELECT DISTINCT
	AdmissionDoctor AS Doctor_Or_Incharge,
	SUM(CASE WHEN AdmissionDate = DischargeDate THEN 1 ELSE 0 END) AS TotalOutPatientSeen,
	SUM(CASE WHEN AdmissionDate <> DischargeDate THEN 1 ELSE 0 END) AS TotalInPatientSeen,
	COUNT(*) AS TotalPatient
FROM WMH2024
GROUP BY AdmissionDoctor
ORDER BY TotalPatient DESC;


---Monthy visits
GO
CREATE VIEW View_WMH_Montly_2024 AS
	SELECT
		FORMAT(DATETRUNC(MONTH, AdmissionDate), 'yyyy-MM') AS PerMonth,
		COUNT(DISTINCT AdmissionDoctor) AS TotalDoctors,
		COUNT(*) AS TotalPatients,
		SUM(CASE WHEN AdmissionDate = DischargeDate THEN 1 ELSE 0 END) AS TotalOutPatient,
		SUM(CASE WHEN AdmissionDate <> DischargeDate THEN 1 ELSE 0 END) AS TotalInPatient,
		SUM(CASE WHEN Gender = 'Male' OR Gender = 'male' THEN 1 ELSE 0 END) AS TotalMales,
		SUM(CASE WHEN Gender = 'Female' OR Gender = 'female' THEN 1 ELSE 0 END) AS TotalFemales,
		CONCAT('1:', CAST(NULLIF(COUNT(*) / NULLIF(COUNT(DISTINCT AdmissionDoctor), 0), 0) AS INT)) AS DoctorToPatientRatio
	FROM WMH2024
	GROUP BY DATETRUNC(MONTH, AdmissionDate);
GO


---Average length of stay (ALOS)

SELECT 
    AVG(DATEDIFF(DAY, DischargeDate, AdmissionDate)) AS OutPatientAvgLengthOfStay
FROM WMH2024
WHERE AdmissionDate <> DischargeDate;



---Daily visits
GO
CREATE VIEW View_WMH_Daily_2024 AS
	SELECT 
		AdmissionDate,
		COUNT(DISTINCT AdmissionDoctor) AS TotalDoctors,
		COUNT(*) AS TotalPatients,
		SUM(CASE WHEN AdmissionDate = DischargeDate THEN 1 ELSE 0 END) AS TotalOutPatient,
		SUM(CASE WHEN AdmissionDate <> DischargeDate THEN 1 ELSE 0 END) AS TotalInPatient,
		SUM(CASE WHEN Gender = 'Male' OR Gender = 'male' THEN 1 ELSE 0 END) AS TotalMales,
		SUM(CASE WHEN Gender = 'Female' OR Gender = 'female' THEN 1 ELSE 0 END) AS TotalFemales,
		CONCAT('1:', CAST(NULLIF(COUNT(*) / NULLIF(COUNT(DISTINCT AdmissionDoctor), 0), 0) AS INT)) AS DoctorToPatientRatio
	FROM WMH2024
	GROUP BY AdmissionDate;
GO


---Scheme Traffic by count
GO
CREATE VIEW SchemeViewCount_2024 AS
	SELECT DISTINCT
		MedicalSchemeCode,
		MedicalSchemeName,
		SUM(CASE WHEN AdmissionDate = DischargeDate THEN 1 ELSE 0 END) AS TotalOutPatient,
		SUM(CASE WHEN AdmissionDate <> DischargeDate THEN 1 ELSE 0 END) AS TotalInPatient,
		COUNT(*) AS Total
	FROM WusakileHospital2024
	GROUP BY MedicalSchemeCode, MedicalSchemeName
	ORDER BY Total DESC;
GO


---Guarantor with highest visits 
SELECT 
    Guarantor, GuarantorName,
    COUNT(DISTINCT ProclinNumber) AS NumbersOfVisits -- Unique ProclinNumbers per Guarantor
FROM WMH2024
GROUP BY Guarantor, GuarantorName, TimeSpent_HHMM
ORDER BY NumbersOfVisits DESC;


---Bed Occupancy Rate Annual and Monthly
DECLARE @TotalHospitalBeds INT = 79;  -- Total inpatient beds in the hospital

SELECT 
    SUM(DATEDIFF(DAY, AdmissionDate, DischargeDate) + 1) AS TotalBedDaysUsed,
    COUNT(*) AS TotalAdmissions,
    CAST(
        (SUM(DATEDIFF(DAY, AdmissionDate, DischargeDate) + 1) * 100.0) / NULLIF((@TotalHospitalBeds * 365), 0)
        AS DECIMAL(10,2)) AS AnnualBedOccupancyRate
FROM WMH2024
WHERE YEAR(AdmissionDate) = 2024
AND AdmissionDate < DischargeDate;


---Monthly Occupancy Rate %
GO
DECLARE @TotalHospitalBeds INT = 79;

SELECT 
    FORMAT(AdmissionDate, 'yyyy-MM') AS PerMonth,
    SUM(DATEDIFF(DAY, AdmissionDate, DischargeDate) + 1) AS TotalBedDaysUsed,
    COUNT(*) AS TotalAdmissions,
    CAST(
        (SUM(DATEDIFF(DAY, AdmissionDate, DischargeDate) + 1) * 100.0) / 
        NULLIF((@TotalHospitalBeds * 30), 0)  
        AS DECIMAL(10,2)
    ) AS MonthlyBedOccupancyRate
FROM WMH2024
WHERE YEAR(AdmissionDate) = 2024
AND AdmissionDate < DischargeDate  -- Only include inpatients
GROUP BY FORMAT(AdmissionDate, 'yyyy-MM')
ORDER BY PerMonth;

GO

  
---Common diagnosis BY COUNT and patient type

SELECT 
    COALESCE(NULLIF(PrimaryDiagnosisCode, ''), 'Unspecified') AS PrimaryDiagnosisCode,
    COALESCE(NULLIF(PrimaryDiagnosisDesc, ''), 'Unspecified') AS PrimaryDiagnosisDesc,
    COUNT(*) AS TotalDiagnosis,
    SUM(CASE WHEN AdmissionDate = DischargeDate THEN 1 ELSE 0 END) AS OutPatientCount,
    SUM(CASE WHEN AdmissionDate <> DischargeDate THEN 1 ELSE 0 END) AS InPatientCount
FROM WMH2024
GROUP BY COALESCE(NULLIF(PrimaryDiagnosisCode, ''), 'Unspecified'),
         COALESCE(NULLIF(PrimaryDiagnosisDesc, ''), 'Unspecified')
ORDER BY TotalDiagnosis DESC;


---Ward Traffic Count

SELECT  
    COALESCE(NULLIF(Ward, ''), 'UNSPECIFIED') AS Ward,
	COUNT(*) AS Traffic
FROM WMH2024
WHERE AdmissionDate <> DischargeDate
GROUP BY Ward
ORDER BY COUNT(*) DESC;


---Annual operator workload
SELECT 
    COALESCE(NULLIF(AdmissionOperator, ''), 'UNSPECIFIED') AS AdmissionOperator,
	COUNT(*) AS PatientsHandles
FROM WMH2024
GROUP BY AdmissionOperator
ORDER BY COUNT(*) DESC;


Select * from WMH2024 where Age >= 90;


----Age greater than 95
Select PatientNumber, Guarantor,  DATEDIFF(YEAR, DOB, GETDATE()) AS Age from WusakileHospital2024
where DATEDIFF(YEAR, DOB, GETDATE()) = 34;

---Average Age <= 95
SELECT AVG(DATEDIFF(YEAR, DOB, GETDATE())) AS AvgAge
FROM WusakileHospital2024
WHERE DATEDIFF(YEAR, DOB, GETDATE()) <= 95;

---New DOB
UPDATE WusakileHospital2024
SET DOB = DATEADD(YEAR, -(
    SELECT AVG(DATEDIFF(YEAR, DOB, GETDATE()))
    FROM WusakileHospital2024
    WHERE DATEDIFF(YEAR, DOB, GETDATE()) <= 95
), GETDATE())
WHERE DATEDIFF(YEAR, DOB, GETDATE()) > 95;

