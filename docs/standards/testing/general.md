# Testing standard

- Tests must validate externally observable behavior and important mapping rules.
- External systems are mocked/faked at connector boundaries for normal automated tests.
- Mapping tests use synthetic/anonymized source records.
- A bug fix should include a regression test when practical.
- Integration tests that need real protected environments are separate from normal PR validation and must not require production credentials.
