-- Copyright (C) 2016-2019 Dmitry Marakasov <amdmi3@amdmi3.ru>
--
-- This file is part of repology
--
-- repology is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- repology is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with repology.  If not, see <http://www.gnu.org/licenses/>.

--------------------------------------------------------------------------------
-- Update binding tables: per-category
--------------------------------------------------------------------------------
DELETE FROM category_metapackages;

INSERT INTO category_metapackages (
	category,
	effname,
	"unique"
)
SELECT
	category,
	effname,
	max(num_families) = 1
FROM packages INNER JOIN metapackages USING(effname)
WHERE category IS NOT NULL AND num_repos_nonshadow > 0
GROUP BY effname, category;

ANALYZE category_metapackages;
