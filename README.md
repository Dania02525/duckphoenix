# Duckphoenix

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Instructions

You may set up data in by visiting [`localhost:4000/resources`](http://localhost:4000/resources)
and adding JSON in string format and specifying the PLURAL form of the resource.

You can do all restful actions on any route, with the /api prefix, and the api will respond
appropriately.  Posting and putting to routes creates real records using the data, which can then be fetched
with get requests as if they existed in real routes and in their own tables in the database.

Example:

1. post some data to /api/widgets, duckphoenix responds back with data and id of new record
2. get api/widgets, duckphoenix responds back with list of widget resources, including the above
3. get api/widgets/1, duckphoenix responds back with the data and id of the previously created widget
4. put api/widgets/1, duckphoenix updates the widget
5. delete api/widgets/1, duckphoenix deletes the widget record

Basically, just post to any arbitrary resource route and the api will respond as if it is a real
route backed by a database table.  You can also post to things like /api/widgets/1/gadgets and the api
will respond as if the gadgets route was hit.

Thanks to [`Duckrails`](https://github.com/iridakos/duckrails) project for inspiration!
