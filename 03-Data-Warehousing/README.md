# Data Warehousing

Four ways to run a Python notebook against BigQuery in Google Cloud. Each notebook bills queries to your own project and reads only public data.

| Notebook | Where it runs | Good for |
|---|---|---|
| `01-Colab-BigQuery.ipynb` | Free Colab (colab.research.google.com) | The quickest start: free, no setup beyond signing in; you name your project for each query |
| `02-BigQuery-Studio-BigFrames.ipynb` | BigQuery Studio notebook | Working next to your tables in BigQuery; shows BigQuery DataFrames (pandas-style code that runs in BigQuery) |
| `03-Workbench-BigQuery.ipynb` | Agent Platform Workbench (formerly Vertex AI Workbench) | A JupyterLab VM you control: pick the machine, install anything, keep files on its disk |
| `04-Colab-Enterprise-BigQuery.ipynb` | Colab Enterprise | Colab with nothing to manage; the runtime starts on demand and shuts down when idle |

Colab Enterprise and BigQuery Studio notebooks are the same product with two entry points. A notebook you create in one shows up in the other.

Use region `us-east1` (zone `us-east1-b` for Workbench). `us-central1` often runs out of machines.

**Costs:** Free Colab's runtime costs nothing; your queries still bill to your project. Workbench bills for its VM until you stop it. Colab Enterprise runtimes bill while connected and shut down after idling. Stop or delete what you aren't using.

`Assignment-1.ipynb` covers classes 3 and 4. You can run it in any of the four.

`03-Workbench-BigQuery.ipynb` is adapted from a Google tutorial.
