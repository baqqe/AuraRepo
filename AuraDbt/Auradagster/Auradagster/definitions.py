from dagster import Definitions
from dagster_dbt import DbtCliResource
from .assets import AuraDbt_dbt_assets
from .project import AuraDbt_project
from .schedules import schedules

defs = Definitions(
    assets=[AuraDbt_dbt_assets],
    schedules=schedules,
    resources={
        "dbt": DbtCliResource(project_dir=AuraDbt_project),
    },
)