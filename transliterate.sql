CREATE OR ALTER FUNCTION transliterate (
	@original NVARCHAR(1024)
) RETURNS VARCHAR(2048) AS
BEGIN

  DECLARE @translit VARCHAR(2048);
  DECLARE @len      INT;
  DECLARE @pos      INT;
  DECLARE @letter   NCHAR(1);
  DECLARE @add_j	BIT;
  DECLARE @add_z	BIT;

  SET @len = LEN(@original);
  SET @pos = 1;
  SET @translit = '';

  WHILE (@pos <= @len) BEGIN
	SET @add_j = 0;
	SET @add_z = 0;
	
    SET @letter = SUBSTRING(@original, @pos, 1);
	
	SET @add_j = IIF(@letter = N'đ', 1, @add_j);
	SET @add_j = IIF(@letter = N'ђ', 1, @add_j);
	SET @add_j = IIF(@letter = N'љ', 1, @add_j);
	SET @add_j = IIF(@letter = N'њ', 1, @add_j);

	SET @add_z = IIF(@letter = N'џ', 1, @add_z);

	SET @letter = IIF(@letter = N'а', 'a', @letter);
	SET @letter = IIF(@letter = N'б', 'b', @letter);
	SET @letter = IIF(@letter = N'в', 'v', @letter);
	SET @letter = IIF(@letter = N'г', 'g', @letter);
	SET @letter = IIF(@letter = N'д', 'd', @letter);
	SET @letter = IIF(@letter = N'ђ', 'd', @letter);
	SET @letter = IIF(@letter = N'е', 'e', @letter);
	SET @letter = IIF(@letter = N'ж', 'z', @letter);
	SET @letter = IIF(@letter = N'з', 'z', @letter);
	SET @letter = IIF(@letter = N'и', 'i', @letter);
	SET @letter = IIF(@letter = N'ј', 'j', @letter);
	SET @letter = IIF(@letter = N'к', 'k', @letter);
	SET @letter = IIF(@letter = N'л', 'l', @letter);
	SET @letter = IIF(@letter = N'љ', 'l', @letter);
	SET @letter = IIF(@letter = N'м', 'm', @letter);
	SET @letter = IIF(@letter = N'н', 'n', @letter);
	SET @letter = IIF(@letter = N'њ', 'n', @letter);
	SET @letter = IIF(@letter = N'о', 'o', @letter);
	SET @letter = IIF(@letter = N'п', 'p', @letter);
	SET @letter = IIF(@letter = N'р', 'r', @letter);
	SET @letter = IIF(@letter = N'с', 's', @letter);
	SET @letter = IIF(@letter = N'т', 't', @letter);
	SET @letter = IIF(@letter = N'ћ', 'c', @letter);
	SET @letter = IIF(@letter = N'у', 'u', @letter);
	SET @letter = IIF(@letter = N'ф', 'f', @letter);
	SET @letter = IIF(@letter = N'х', 'h', @letter);
	SET @letter = IIF(@letter = N'ц', 'c', @letter);
	SET @letter = IIF(@letter = N'ч', 'c', @letter);
	SET @letter = IIF(@letter = N'џ', 'd', @letter);
	SET @letter = IIF(@letter = N'ш', 's', @letter);

	SET @letter = IIF(@letter = N'š', 's', @letter);
	SET @letter = IIF(@letter = N'č', 'c', @letter);
	SET @letter = IIF(@letter = N'ć', 'c', @letter);
	SET @letter = IIF(@letter = N'ž', 'z', @letter);
	SET @letter = IIF(@letter = N'đ', 'd', @letter);

	SET @translit = CONCAT(@translit, @letter);
	
	IF @add_j = 1 BEGIN SET @translit = CONCAT(@translit, 'j') END;
	IF @add_z = 1 BEGIN SET @translit = CONCAT(@translit, 'z') END;

	SET @pos = @pos + 1;
  END;

  RETURN @translit;

  END;