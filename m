From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Apr 2020 17:27:09 +0200
Subject: [LTP] [RFC PATCH v3 2/2] net/route: Add netlink based route
 change gw/dest tests
In-Reply-To: <bd634f12-b4f2-18ad-c2f3-ab5e42a0c973@oracle.com>
References: <20200403165432.19358-1-pvorel@suse.cz>
 <20200403165432.19358-3-pvorel@suse.cz>
 <06e299d0-0663-a868-f8cc-1f9002d9d43f@oracle.com>
 <20200409183714.GA915479@x230>
 <bd634f12-b4f2-18ad-c2f3-ab5e42a0c973@oracle.com>
Message-ID: <20200410152709.GA2245028@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Then, for now we can pass arbitrary port, no need for tst_get_unused_port(),
> e.g. 65535.
Right, it really does not matter to check that port.


> >>> +	EXPECT_PASS route-change-netlink -c $NS_TIMES -d $(tst_iface) $ip_flag -p $port $ROUTE_CHANGE_NETLINK_PARAMS

> >> EXPECT_PASS doesn't handle TCONF when libmnl-devel is missing.

> > Thanks, I'll fix it.

> > tst_test.c:865: CONF: libmnl library and headers are required
> > route-change-netlink-gw 1 TFAIL: route-change-netlink -c 10 -d ltp_ns_veth2 -p 40645 -g 10.23.1.7^10.23.1.6^10.23.1.5^10.23.1.4^10.23.1.3^ -l 10.23.1.1 -r 10.23.0.1 failed unexpectedly

> > I propose to handle this in EXPECT_PASS() (send a separate RFC patch for it).

> Not sure if it would work for non-ltp binaries...
True. Do you think there would be more usage for something like
EXPECT_PASS_LTP(), where I'd handle 32 as TCONF, 3 as TFAIL, 4 as TWARN?
I can handle it just in the test.

BTW there is this error handling already in tst_netload() for netstress.c, so
there could be function which returns $res according to exit code and
EXPECT_PASS_LTP() which uses it.

Kind regards,
Petr
