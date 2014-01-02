## Oddities

* Happens to be on Postgres, could just as easily by MySQL
* Will work better if <code>rake demo:populate_db</code> is run first

## Foolish assumptions

* That the current constituency names/boundaries will remain the same between elections (which is fairly unlikely)
* That no-one will cheat and respond to the survey more than once (saving the cookie would be the obvious quick fix but for the purposes of being able to playtest the app, I'm claiming this as a "Feature")

## If only there'd been more time...

* It doesn't look very nice. And pushing text around with BR tags is a pretty rubbish tactic.
* As is not having any real navigation. Sorry.
* Handling 404s within the app would have been a good idea.
* As would detailed specs - started writing them then realised it was eating too much time :(
* A fuller list of parties (or better still - some semblance of a per-constituency candidate list) would have been more useful but a shorthand of the Big 3 or "other" will have to do.
* I wanted to do survey result graphics! Spent too much time fiddling around with backend setups and library files (and abandoned specs). Oh well.
