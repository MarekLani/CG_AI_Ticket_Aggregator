# Data flows

## Initial Helpdesk read flow

```text
VW_RM_POZIAD
  -> Helpdesk connector query/projection
  -> Helpdesk source DTO
  -> explicit mapper
  -> normalized WorkItem
  -> API response
  -> React list
```

Initial mapping candidate:

| WorkItem concept | Helpdesk field |
|---|---|
| externalId | `I_POZIAD` |
| title | `N_POZIAD` |
| description | `POPIS` |
| sourceType | `N_POZIAD_TYP` |
| productName | `NAZOV_PRODUKT` |
| productCode | `KOD_PRODUKT` |
| sourcePriority | `N_PRIORITY` |
| sourceStatus | `N_STAVY_AKT` |
| createdAt | `D_ZADANIE` |
| dueAt | `D_REALIZACIE_DO` |
| completedAt | `D_UKONCENIE` |
| assignee | `RIESITEL` |
| customer | `NAZOV_ZAK` |
| reporter | `ZADAVATEL` |

This table describes only the agreed initial projection. It does not define semantic mappings such as `sourceStatus -> Open/InProgress/Done`.

## Future connectors

Planner and GitHub must map into the same source-neutral model without introducing source-specific fields into generic UI contracts unless an explicit requirement justifies it.
