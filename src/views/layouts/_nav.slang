- active = context.request.path == "/" ? "active" : ""
a class="nav-item #{active}" href="/" Home
- active = context.request.path == "/readings" ? "active" : ""
a class="nav-item #{active}" href="/readings" Readings
