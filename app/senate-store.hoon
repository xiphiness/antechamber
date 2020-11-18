/-  eth-watcher, *senate-store,
    claims-sur=eth-contracts-claims,
    *group,
    *invite-store,
    contact-view
/+  dbug,  claims-lib=eth-contracts-claims,
    default-agent,
    group-store,
    grpl=group,
    resource
=+  claims-2=eth-contracts-claims
|%
+$  card  card:agent:gall
:: +$  versioned-state
::
++  refresh-rate  ~m5
++  timeout-time  ~m6
++  node-url  'https://rinkeby.infura.io/v3/77c3d733140f4c12a77699e24cb30c27'
++  claims-address  0x4e75.404f.7cda.acc5.8138.9913.a220.34e9.e311.4dd4
++  first-block  7.555.525
--
::
%-  agent:dbug
^-  agent:gall
=|  state-0
=*  state  -
=<
  |_  bol=bowl:gall
  +*  this  .
      def   ~(. (default-agent this %|) bol)
      senate-core  +>
      sc    ~(. senate-core bol)
  ::
  ++  on-init
    ^-  (quip card _this)
    [~ this]
  ::
  ++  on-save  !>(state)
  ::
  ++  on-load
    |=  old=vase
    [~ this]
    :: =+  old-state=!<(state-0 old)
    :: [~ this(state old-state)]
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  ?=(%noun mark)
    =/  =noun  !<(noun vase)
    |-  ^-  [cards=(list card) =_this]
    ?+  noun  ~|([dap.bol %unknown-poke noun] !!)
      ::   [%add-ship =ship]
      :: =^  cards  state  (add-ships:sc ~[ship.noun])
      :: `this
        [%create-group group-name=term title=@t desc=@t]
      =+  noun
      =^  cards  state  (handle-create-group:sc /ship/[(scot %p our.bol)]/[group-name] title desc)
      [cards this]
        %reconnect
      :_  this
      :~  leave-eth-watcher:sc
          watch-eth-watcher:sc
      ==
    ::
        %reset
      `this(state *_state)
    ::
        %reload
      :-  cards:$(noun %reconnect)
      this:$(noun %reset)
    ::
        %rewatch
      :_  this:$(noun %reset)
      :~  leave-eth-watcher:sc
          clear-eth-watcher:sc
          setup-eth-watcher:sc
          await-eth-watcher:sc
      ==
    ::
        %setup
    [setup-cards:sc this]
    ::
    ==
  ::
  ++  on-watch  on-watch:def
  ::
  ++  on-leave  on-leave:def
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    :: !!
    ?+  path  (on-peek:def path)
        [%y %delegates ~]
      =/  =arch
        :-  ~
        %-  malt
        %+  turn  ~(tap in all-ships:sc)
        |=  =ship
        ^-  [@ta ~]
        [(scot %p ship) ~]
      ``arch+!>(arch)
    ::
        [%x %is-delegate @tas ~]
      =/  =ship  (slav %p i.t.t.path)
      ?:  ?=(%czar (clan:title ship))  ``atom+!>(&)
      ``atom+!>((~(has in delegate-set:sc) ship))
        [%x %delegates-of @tas ~]
      =/  czar=ship  (slav %p i.t.t.path)
      =/  =arch
        :-  ~
        %-  malt
        %+  turn  ~(tap in (~(got by altids) czar))
        |=  =ship
        ^-  [@ta ~]
        [(scot %p ship) ~]
      ``arch+!>(arch)
    ==
  ::
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    ?+  -.sign  (on-agent:def wire sign)
        %kick
      ?.  =(/watcher wire)  [~ this]
      [[watch-eth-watcher:sc]~ this]
    ::
        %fact
      ?+  wire  (on-agent:def wire sign)
          [%watcher ~]
        ?.  ?=(%eth-watcher-diff p.cage.sign)
          (on-agent:def wire sign)
        =/  =diff:claims-sur  (decode-diff:claims-lib !<(diff:eth-watcher q.cage.sign))
        =^  cards  state  (process-claim-diff:sc diff)
        [cards this]
      ::
      ==
    ==
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    ?+  +<.sign-arvo  ~|([dap.bol %strange-arvo-sign +<.sign-arvo] !!)
        %wake
      ?:  =(/watch wire)
        [[watch-eth-watcher:sc]~ this]
      ~&  [dap.bol %strange-wake wire]
      [~ this]
    ==
  ::
  ++  on-fail  on-fail:def
  --
|_  bol=bowl:gall
++  grp  ~(. grpl bol)
:: many of the following copied from chat-view
++  send-invite
  |=  [group-path=path =ship]
  ^-  card
  =/  =invite
    :*  our.bol
        %contact-hook
        group-path
        ship  ''
    ==
  =/  act=invite-action  [%invite /contacts (shaf %msg-uid eny.bol) invite]
  [%pass / %agent [our.bol %invite-hook] %poke %invite-action !>(act)]
++  handle-create-group
  |=  [=path title=@t desc=@t]
  ^-  (quip card _state)
  ?^  (scry-group-path:grp path)  `state
  =/  rid=resource
    (de-path:resource path)
  ?>  =(our.bol entity.rid)
  ::  will always be managed
  =/  policy=create:policy  [%custom %senate-store /is-delegate]
  :_  state(groups (~(put in groups) rid))
  :-  (contact-view-poke %create name.rid policy title desc)
  %+  murn  ~(tap in all-ships)
  |=  =ship
  ^-  (unit card)
  ?:  =(ship our.bol)  ~
  `(send-invite path ship)

++  contact-view-remove
  |=  [rid=resource =ship]
  ^-  card
  %-  contact-view-poke
  [%remove (en-path:resource rid) ship]
++  contact-view-poke
  |=  act=contact-view-action:contact-view
  ^-  card
  [%pass / %agent [our.bol %contact-view] %poke %contact-view-action !>(act)]
++  group-poke
  |=  act=action:group-store
  ^-  card
  [%pass / %agent [our.bol %group-store] %poke %group-action !>(act)]
++  process-claim-diff
  |=  diff=diff:claims-sur
  ^-  (quip card _state)
  ?-  diff
    [%history *]
  %+  roll  loglist.diff
  |=  [=event-log:claims-sur cards=(list card) state=_state]
  =^  cards  state  (process-update event-data.event-log state)
  ~&  history+state
  :_  state
  (weld cards ^cards)
    [%log *]
  =^  cards  state  (process-update event-data.event-log.diff state)
  [cards state]
    [%disavow *]
  !!
  ==
++  process-update
  |=  [update=event-update:claims-sur _state]
  ^-  (quip card _state)
  =*  state  +<+
  ?-  update
      [%claim-added *]
    ?.  =('alt-id' (crip protocol.update))
      `state
    =/  claimer=ship  `@p`by.update
    =/  claimee=ship  `@p`(scan claim.update dem)
    ~&  added+[claimer+claimer claimee+claimee]
    =/  czar=(unit ?(%claimer %claimee))
    ?.  ?=(%czar (clan:title claimer))
      ?.  ?=(%czar (clan:title claimee))  ~  :: irrelvant claim
      (some %claimee)
    (some %claimer)
    ?~  czar  `state
    =/  claimer-claims=(set ship)  (fall (~(get by claims) claimer) *(set ship))
    =.  claims
    %+  ~(put by claims)  claimer
    %-  ~(put in claimer-claims)  claimee
    =/  claimee-claims=(set ship)  (fall (~(get by claims) claimee) *(set ship))
    :: ~&  [has+(~(has in claimee-claims) claimer) in+claimee-claims]
    ?.  (~(has in claimee-claims) claimer)  `state
    ?-  u.czar
        %claimer
      =/  claimer-altids=(set ship)  (fall (~(get by altids) claimer) *(set ship))
      =.  altids
      %+  ~(put by altids)  claimer
      %-  ~(put in claimer-altids)  claimee
      :_  state
      %+  turn  ~(tap in groups)
      |=  rid=resource
      [(send-invite (en-path:resource rid) claimee)]
        %claimee
      =.  altids
      =/  claimee-altids=(set ship)  (fall (~(get by altids) claimee) *(set ship))
      %+  ~(put by altids)  claimee
      %-  ~(put in claimee-altids)  claimer
      :_  state
      %+  turn  ~(tap in groups)
      |=  rid=resource
      [(send-invite (en-path:resource rid) claimer)]
    ==
      [%claim-removed *]
    ?.  =('alt-id' (crip protocol.update))
      [~ state]
    =/  claimer=ship  `@p`by.update
    =/  claimee=ship  `@p`(scan claim.update dem)
    ~&  removed+[claimer+claimer claimee+claimee]
    =/  czar=(unit ?(%claimer %claimee))
    ?.  ?=(%czar (clan:title claimer))
      ?.  ?=(%czar (clan:title claimee))  ~
      (some %claimee)
    (some %claimer)
    ?~  czar  `state
    =/  claimer-claims=(set ship)  (fall (~(get by claims) claimer) *(set ship))
    =.  claims
    %+  ~(put by claims)  claimer
    %-  ~(del in claimer-claims)  claimee
    ?-  u.czar
        %claimer
      =/  claimer-altids=(set ship)  (fall (~(get by altids) claimer) *(set ship))
      ?~  (~(has in claimer-altids) claimee)  `state
      =.  altids
      %+  ~(put by altids)  claimer
      %-  ~(del in claimer-altids)  claimee
      :_  state
      %+  turn  ~(tap in groups)
      |=  rid=resource
      ^-  card
      (contact-view-remove rid claimee)
        %claimee
      =/  claimee-altids=(set ship)  (fall (~(get by altids) claimee) *(set ship))
      ?~  (~(has in claimee-altids) claimee)  `state
      =.  altids
      %+  ~(put by altids)  claimee
      %-  ~(del in claimee-altids)  claimer
      :_  state
      %+  turn  ~(tap in groups)
      |=  rid=resource
      ^-  card
      (contact-view-remove rid claimer)
    ==
  ==
++  is-delegate
  |=  =ship
  ?:  ?=(%czar (clan:title ship))  &
  %+  lien  ~(tap in (~(got by altids) ship))
  |=  altid=^ship
  ?&  (~(has in (~(got by altids) altid)) altid)
      :: unneeded since we crash if neither claimer or claimee is czar
      ?=(%czar (clan:title ship))
  ==
++  all-ships
  ^-  (set ship)
  (~(uni in delegate-set) galaxy-set)
::
++  delegate-set
  ^-  (set ship)
  %+  roll  ~(val by altids)
  |=  [a=(set ship) b=(set ship)]
  (~(uni in a) b)
::
++  galaxy-set  `(set ship)`(silt (gulf 0 255))
::
++  setup-cards
  ^-  (list card)
  :~  setup-eth-watcher
      ::  we punt on subscribing to the eth-watcher for a little while.
      ::  this way we get a %history diff containing all past events,
      ::  instead of so many individual %log diffs that we bail meme.
      ::  (to repro, replace this with `watch-eth-watcher`)
      ::
      await-eth-watcher
  ==
::
++  wait
  |=  [=wire =@dr]
  ^-  card
  [%pass wire %arvo %b %wait (add now.bol dr)]
::
++  to-eth-watcher
  |=  [=wire =task:agent:gall]
  ^-  card
  [%pass wire %agent [our.bol %eth-watcher] task]
::
++  setup-eth-watcher
  =,  azimuth
  %+  to-eth-watcher  /setup
  :+  %poke   %eth-watcher-poke
  !>  ^-  poke:eth-watcher
  :+  %watch  /[dap.bol]
  :*  node-url
      &
      refresh-rate
      timeout-time
      first-block
      ~[claims-address]
      ~
  ==

::  see also comment in +setup-cards
++  await-eth-watcher  (wait /watch ~m1)
::
++  watch-eth-watcher
  ~&  %watch-eth-watcher
  %+  to-eth-watcher  /watcher
  [%watch /logs/[dap.bol]]
::
++  leave-eth-watcher
  %+  to-eth-watcher  /watcher
  [%leave ~]
::
++  clear-eth-watcher
  %+  to-eth-watcher  /clear
  :+  %poke  %eth-watcher-poke
  !>  ^-  poke:eth-watcher
  [%clear /logs/[dap.bol]]
::
--
