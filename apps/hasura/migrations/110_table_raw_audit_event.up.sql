-- Create
-- #+NAME: raw_audit_event

CREATE UNLOGGED TABLE raw_audit_event (
  -- id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  -- ingested_at timestamp DEFAULT CURRENT_TIMESTAMP,
  bucket text,
  job text,
  audit_id text NOT NULL,
  stage text NOT NULL,
  event_verb text NOT NULL,
  request_uri text NOT NULL,
  operation_id text,
  data jsonb NOT NULL
);

-- TODO Index
-- I am not sure why our create index and alter table lines are commented out.
-- the TODO is to enquire on why these lines are commented
-- #+NAME: index the raw_audit_event

-- CREATE INDEX idx_audit_event_primary          ON raw_audit_event (bucket, job, audit_id, stage);
-- ALTER TABLE raw_audit_event add primary key using index idx_audit_event_primary;
CREATE INDEX idx_audit_event_jsonb_ops        ON raw_audit_event USING GIN (data jsonb_ops);
CREATE INDEX idx_audit_event_jsonb_path_jobs  ON raw_audit_event USING GIN (data jsonb_path_ops);
