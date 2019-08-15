-- Create
-- Using our api_operations_material view, look into the parameters field in each one.     
-- #+NAME: api_operations_parameters_material view

CREATE MATERIALIZED VIEW "public"."api_operations_parameters_material" AS 
  SELECT (param.entry ->> 'name'::text) AS name,
         (param.entry ->> 'in'::text) AS "in",
         -- for resource:
         -- if param is body in body, take its $ref from its schema
         -- otherwise, take its type
         replace(
           CASE
           WHEN ((param.entry ->> 'in'::text) = 'body'::text) 
            AND ((param.entry -> 'schema'::text) is not null)
             THEN ((param.entry -> 'schema'::text) ->> '$ref'::text)
           ELSE (param.entry ->> 'type'::text)
           END, '#/definitions/','') AS resource,
         (param.entry ->> 'description'::text) AS description,
         CASE
         WHEN ((param.entry ->> 'required'::text) = 'true') THEN true
         ELSE false
          END AS required,
         CASE
         WHEN ((param.entry ->> 'uniqueItems'::text) = 'true') THEN true
         ELSE false
         END AS unique_items,
         api_operations_material.raw_swagger_id,
         param.entry as entry,
         api_operations_material.operation_id
    FROM api_operations_material
         , jsonb_array_elements(api_operations_material.parameters) WITH ORDINALITY param(entry, index)
          WHERE api_operations_material.parameters IS NOT NULL;

-- Index
-- #+NAME: index the api_operations_material

CREATE UNIQUE INDEX                                  ON api_operations_parameters_material(raw_swagger_id, operation_id, name);
CREATE INDEX api_parameters_materialized_resource    ON api_operations_parameters_material            (resource);
CREATE INDEX api_parameters_materialized_entry       ON api_operations_parameters_material            (entry);