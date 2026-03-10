load("render.star", "render")

FONT = "tom-thumb"
BG_RGB = "#111"
TITLE_RGB = "#55f"
LABEL_RGB = "#eee"
COUNT_RGB = "#f00"
TITLE = "LAYOFFS.FYI"
COMPANY_LABEL = "Companies"
EMPLOYEE_LABEL = "Nerds"

def main(config):
    employee_count = config.get("employee_count", "N/A")
    company_count = config.get("company_count", "N/A")

    return render.Root(
        child = render.Column(
            children = [
                render.Row(
                    children = [
                        render.Box(
                            child = render.Text(content = TITLE, font = FONT, color = TITLE_RGB, offset = -1),
                            height = 7,
                            width = 47,
                        ),
                    ],
                ),
                render.Row(
                    children = [
                        render.Box(
                            # color = "#a33",
                            child = render.Text(content = COMPANY_LABEL, font = FONT, color = LABEL_RGB, offset = 0),
                            height = 8,
                            width = 39,
                        ),
                        render.Box(
                            # color = "#a99",
                            child = render.Text(content = "%s" % company_count, font = FONT, color = COUNT_RGB, offset = -1),
                            height = 7,
                            width = 25,
                        ),
                    ],
                ),
                render.Row(
                    children = [
                        render.Box(
                            # color = "#a33",
                            child = render.Text(content = EMPLOYEE_LABEL, font = FONT, color = LABEL_RGB, offset = -1),
                            height = 7,
                            width = 23,
                        ),
                        render.Box(
                            # color = "#a99",
                            child = render.Text(content = "%s" % employee_count, font = FONT, color = COUNT_RGB, offset = -1),
                            height = 7,
                            width = 41,
                        ),
                    ],
                ),
            ],
        ),
    )
