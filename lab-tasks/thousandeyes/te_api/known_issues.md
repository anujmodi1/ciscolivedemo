There is an issue in the GUI, whereby when you login and generate the oath token,
it can happen, on occassion, that the gui generates a token that is associated with a different group.

When this happens, and you run the api call to get all the agents (both cloud and enterprise),
then, it just shows cloud and not enterprise.

The work around is to logout of gui, log backin, revoke token, issue new token.