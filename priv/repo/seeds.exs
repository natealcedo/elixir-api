# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MyApp.Repo.insert!(%MyApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias MyApp.Auth

{:ok, _user} =
  Auth.create_user(%{
    email: "ndaljr@gmail.com",
    password: "sdfsdfsdf"
  })

{:ok, _user} =
  Auth.create_user(%{
    email: "writer",
    password: "qweqweqwe"
  })

{:ok, _user} =
  Auth.create_user(%{
    email: "reader",
    password: "qweqweqwe"
  })

{:ok, _user} =
  Auth.create_user(%{
    email: "rubbish",
    password: "qweqweqwe"
  })
