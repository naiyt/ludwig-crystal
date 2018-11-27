- active = context.request.path == "/" ? "active" : ""
a class="nav-item #{active}" href="/" Home
- active = context.request.path == "/entries" ? "active" : ""
a class="nav-item #{active}" href="/entries" Entries
