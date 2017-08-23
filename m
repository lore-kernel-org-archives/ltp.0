From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Aug 2017 15:49:14 +0200
Subject: [LTP] [RFC PATCH v8 08/11] network/stress: Fix and cleanup
 route IPv4 tests
In-Reply-To: <b8de35cc-d40f-5f9d-187d-c482c8943d41@oracle.com>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-9-pvorel@suse.cz>
 <786265f7-ec89-e641-8fda-15f6844fb347@oracle.com>
 <20170822212240.cj4rhya5s2mvlpgh@dell5510>
 <b8de35cc-d40f-5f9d-187d-c482c8943d41@oracle.com>
Message-ID: <20170823134912.7bm6vmttjeopme36@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >>> Tests using route_test_change() use background traffic instead of ns-udpsender
> >>> but I fixed it that it uses route. Is it too much overhead? The reason is I'd
> >> How do you use it to make a background traffic if you change route on
> >> every loop iteration?
> >>> like to get rid of all ugly scripts and binaries in
> >>> testcases/network/stress/ns-tools, including ns-udpsender.c.
> >> ns-udpsender can send a single UDP datagram over the new route without
> >> waiting for answer but unfortunately we don't know for sure whether it
> >> actually sent datagram and/or destination received it.
> > What would you suggest? I chose netstress as it's kind of client & server application. Do
> > we want to write something from scratch?
> > I don't like also the infinite loop in send_udp_datagram (I've caused one crash in local
> > network in previous tests by sending too many packets).

> I would convert to match the previous version for now, e.g.route-change-dst.
Sorry, do you to use ns-udpsender just in route-change-dst (as it's the only one which
kill netstress each time in loop by calling netstress_cleanup() ) or in all route tests
which are using it?

> do_test()
> {
>         local new_rtaddrcnt
>         local if=$(tst_iface)
>         local inet="inet$TST_IPV6"

>         tst_resm TINFO "change IPv$ipver route $NS_TIMES times"

>         local udp_size=1472
>         local mask=24
>         if [ "$TST_IPV6" ]; then
>             udp_size=1452
>             mask=64
>         fi

>         cnt=1
>         while [ $cnt -le $NS_TIMES ]; do

>             new_rt="$(tst_ipaddr_un $cnt)/$mask"
>             addr="$(tst_ipaddr_un $cnt 1)"

>             ROD ip route add $new_rt dev $if
>             ROD ip ne replace $addr lladdr $(tst_hwaddr rhost) nud
> permanent dev $if

>             # Load the route with one UDP datagram
>             ROD ns-udpsender -f $ipver -D $addr -p $cnt -o -s $udp_size

>             ROD ip neigh del $addr lladdr $(tst_hwaddr rhost)dev $if
>             ROD ip route del $new_rt dev $if

>             cnt=$(($cnt + 1))
>         done

>         tst_resm TPASS "Test is finished correctly"
> }

> For background traffic it's better to have 'netstress' running.
I see you probably don't like manipulate_route (the name is ugly - too long and I have to
admit that direct commands are more readable). If you want, I can replace it into direct
commands (as you mentioned some time ago). I just don't like many 'case' commands and
code repeating.


Kind regards,
Petr
