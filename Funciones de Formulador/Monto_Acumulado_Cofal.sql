DECLARE @ElementGroupId NVARCHAR = ''
DECLARE @ElementId NVARCHAR
DECLARE @ElementType INT

DECLARE ElementGroup_Cursor CURSOR FOR
SELECT ElementId, ElementType
FROM PayRollElementPerGroup
WHERE ElementGroupId = @ElementGroupId

OPEN ElementGroup_Cursor

FETCH NEXT FROM ElementGroup_Cursor INTO @ElementId, @ElementType

WHILE @@FETCH_STATUS = 0
BEGIN


    FETCH NEXT FROM ElementGroup_Cursor INTO @ElementId, @ElementType
END

CLOSE ElementGroup_Cursor
DEALLOCATE ElementGroup_Cursor