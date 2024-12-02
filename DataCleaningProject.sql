/*
CLEANING DATA IN SQL QUERIES
*/

SELECT * 
FROM NashvilleHousing


------------------------------------------------------------------------------------------------------------------------------------------------------------

-- STANDARDIZE THE DATE FORMAT

SELECT SaleDate, Convert(Date, SaleDate) 
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ALTER COLUMN SaleDate DATE;

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- POPULATE PROPERTY ADDRESS DATA

SELECT * 
FROM NashvilleHousing
WHERE PropertyAddress is NULL 
order by ParcelId


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a 
JOIN NashvilleHousing b 
ON a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID 
WHERE a.PropertyAddress is NULL 

UPDATE a 
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a 
JOIN NashvilleHousing b 
ON a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID 
WHERE a.PropertyAddress is NULL 

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BREAKING OUT ADDRESS INTO SEPARATE COLUMNS (ADDRESS, CITY, STATE) 

SELECT PropertyAddress 
FROM NashvilleHousing

SELECT SUBSTRING(PROPERTYADDRESS, 1, CHARINDEX(',', PROPERTYADDRESS) - 1) AS ADDRESS, 
SUBSTRING(PropertyAddress, CHARINDEX(',', PROPERTYADDRESS) + 1, LEN(PropertyAddress)) AS CITY
FROM [NashvilleHousing ]

ALTER TABLE NashvilleHousing 
ADD PropertySplitAddress NVARCHAR(255)

UPDATE NashvilleHousing 
SET PropertySplitAddress = SUBSTRING(PROPERTYADDRESS, 1, CHARINDEX(',', PROPERTYADDRESS) - 1)

ALTER TABLE NashvilleHousing 
ADD PropertySplitCity NVARCHAR(255)

UPDATE NashvilleHousing 
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PROPERTYADDRESS) + 1, LEN(PropertyAddress))

SELECT OWNERADDRESS 
FROM NashvilleHousing

SELECT 
PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 3),
PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 2),
PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 1)
FROM NashvilleHousing

ALTER TABLE NashvilleHousing 
ADD OwnerSplitAddress NVARCHAR(255)

UPDATE NashvilleHousing 
SET OwnerSplitAddress = PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 3)

ALTER TABLE NashvilleHousing 
ADD OwnerSplitCity NVARCHAR(255)

UPDATE NashvilleHousing 
SET OwnerSplitCity = PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 2)

ALTER TABLE NashvilleHousing 
ADD OwnerSplitState NVARCHAR(255)

UPDATE NashvilleHousing 
SET OwnerSplitState = PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 1)

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CHANGE Y AND N TO YES AND NO IN 'SOLD AS VACANT' FIELD 

SELECT DISTINCT(SOLDASVACANT), COUNT(SOLDASVACANT)
FROM [NashvilleHousing ]
GROUP BY SOLDASVACANT 
ORDER BY 2

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' 
    WHEN SoldAsVacant = 'N' THEN 'No' 
    ELSE SoldAsVacant 
END
FROM [NashvilleHousing ]


UPDATE NashvilleHousing 
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' 
    WHEN SoldAsVacant = 'N' THEN 'No' 
    ELSE SoldAsVacant 
    END

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- REMOVE DUPLICATES 

WITH RowNumCte AS(
SELECT *, 
    ROW_NUMBER() OVER (
        PARTITION BY ParcelID, 
            PropertyAddress, 
            SalePrice, 
            SaleDate, 
            LegalReference
            ORDER BY 
                UniqueID 
        ) as row_num
FROM [NashvilleHousing ] 
-- ORDER BY ParcelID
) 
DELETE 
FROM RowNumCte
WHERE row_num > 1 
-- ORDER BY PropertyAddress


------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DELETE UNUSED COLUMNS 

SELECT * 
from [NashvilleHousing ]

ALTER TABLE NashvilleHousing 
DROP COLUMN OwnerAddress, PropertyAddress, TaxDistrict


