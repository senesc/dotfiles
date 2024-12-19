return {
	"kiyoon/jupynium.nvim",
	build = "~/.local/venv/bin/pip install .",
	opts = {
		default_notebook_URL = "localhost:8888/nbclassic",
		python_host = "~/.local/venv/bin/python",
	}
}
