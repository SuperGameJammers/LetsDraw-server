## Dump to CSV for machine learning feeding

```COPY drawings TO '/Users/zu/drawings.csv' DELIMITER ',' CSV HEADER;```

```COPY subjects TO '/Users/zu/subjects.csv' DELIMITER ',' CSV HEADER;```

```COPY scores TO '/Users/zu/scores.csv' DELIMITER ',' CSV HEADER;```

## Succint endpoint docs
### In doubt, ask Zura

```
ROUTE: /subjects
METHODS: GET, POST
```

```
ROUTE: /drawings
METHODS: GET, POST
```

```
ROUTE: /subjects/:subject_id/drawings
METHODS: GET
```

```
ROUTE: /drawings/:drawing_id/scores
METHODS: GET
```
