== Oddities

* Happens to be on Postgres, could just as easily by MySQL
* Will work better if rake demo:populate_db is run first

== Foolish assumptions

* That the current constituency names/boundaries will remain the same between elections (which is fairly unlikely)
* That no-one will cheat and respond to the survey twice (coding a cookie fix would have taken too long for the purposes of this exercise - and for testing - this is being claimed as a "Feature")

== If only there'd been more time...

* It doesn't look very nice. And pushing text around with <br> tags is a pretty rubbish tactic.
* As is not having any real navigation. Sorry.
* Handling 404s within the app would have been a good idea.
* As would detailed specs - started writing them then realised it was eating too much time :(
* A fuller list of parties (or better still - some semblance of a per-constituency candidate list) would have been more useful but a shorthand of the Big 3 or "other" will have to do.
* I wanted to do survey result graphics! Spent too much time fiddling around with backend setups and library files (and abandoned specs). Oh well.
