load("render.star", "render")
load("http.star", "http")
load("html.star", "html")

URL = "https://layoffs.fyi"
FONT = "tom-thumb"
BG_RGB = "#111"
TITLE_RGB = "#55f"
LABEL_RGB = "#eee"
COUNT_RGB = "#f00"
TITLE = "LAYOFFS.FYI"
COMPANY_LABEL = "Companies"
EMPLOYEE_LABEL = "Nerds"
CSS_ID = "#numbers2024"
CSS_CLASS = ".big-number"

def main():
    """
    Prints layoffs.fyi totals

    Returns:
      Nothing
    """

    resp = http.get(URL)
    body = resp.body()
    sel = html(body)
    sel = sel.find(CSS_ID)
    sel = sel.find(CSS_CLASS)

    company_count = sel.eq(0).text()
    employee_count = sel.eq(1).text()

    return render.Root(
        child = render.Box(
            color = BG_RGB,
            child = render.Column(
                expanded = True,
                main_align = "space_evenly",
                children = [
                    render.Row(
                        children = [
                            render.Text(content = TITLE, font = FONT, color = TITLE_RGB),
                        ],
                    ),
                    render.Row(
                        main_align = "space_between",
                        children = [
                            render.Text(content = COMPANY_LABEL, font = FONT, color = LABEL_RGB),
                            render.Box(width = 10, height = 5, color = BG_RGB),
                            render.Text(content = "%s" % company_count, font = FONT, color = COUNT_RGB),
                        ],
                    ),
                    render.Row(
                        main_align = "space_between",
                        children = [
                            render.Text(content = EMPLOYEE_LABEL, font = FONT, color = LABEL_RGB),
                            render.Box(width = 19, height = 5, color = BG_RGB),
                            render.Text(content = "%s" % employee_count, font = FONT, color = COUNT_RGB),
                        ],
                    ),
                ],
            ),
        ),
    )
