From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Apr 2020 20:47:40 +0200
Subject: [LTP] [PATCH v5 2/2] net/route: Add netlink based route change
 tests
In-Reply-To: <638d88f6-d140-8982-1555-c83c5adb83e9@oracle.com>
References: <20200423131632.20525-1-pvorel@suse.cz>
 <20200423131632.20525-3-pvorel@suse.cz>
 <8b3ae56d-1c28-e43b-abea-963a32fff8f6@oracle.com>
 <20200429104129.GA685@dell5510>
 <638d88f6-d140-8982-1555-c83c5adb83e9@oracle.com>
Message-ID: <20200429184740.GA26302@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Perhaps brk_on_route_error() as it has tst_brk()?

> > 	char dst_str[INET6_ADDRSTRLEN], gw_str[INET6_ADDRSTRLEN];
> > 	tst_sock_addr(dst, sizeof(dst), dst_str, sizeof(dst_str));
> > 	if (gw)
> > 		tst_sock_addr(gw, sizeof(gw), gw_str, sizeof(gw_str));

> > 	tst_res(TINFO, "type: %s, iface: %d, dst: %s, gw: %s",
> > 		type == RTM_NEWROUTE ? "RTM_NEWROUTE" : "RTM_DELROUTE",
> > 		iface, dst_str, gw ? gw_str : "null");
> > 	tst_brk(TBROK, "failed due previous netlink errors");

> "failed due to the previous..."


> Also, what about passing the error message type and errno to this
> function, i.e. changing "TFAIL, TINFO, TBROK" to "TINFO, TFAIL"?

> static void brk_on_route_error(const char *msg, int errno, int iface, ...
> {
> ...
>         tst_res(TINFO, "...");
> 	tst_brk(TFAIL, "%s failed (errno=%d): %s", msg, errno, strerror(errno));

...
> Then:
> 		brk_on_route_error("mnl_socket_open", errno, iface, dst, gw, type);

Thanks for a suggestion, that's much better.

I've just removed errno as a parameter and used it directly, because gcc complained:

route-change-netlink.c:248:41: warning: passing argument 2 of ?brk_on_route_error? makes pointer from integer without a cast [-Wint-conversion]
  248 |   brk_on_route_error("mnl_socket_open", errno, iface,
      |                                         ^~~~~
      |                                         |
      |                                         int
In file included from ../../../../include/tst_test.h:17,
                 from route-change-netlink.c:7:
route-change-netlink.c:180:53: note: expected ?int * (*)()? but argument is of type ?int?
  180 | static void brk_on_route_error(const char *msg, int errno, int iface,

I'll send v6, which hopefully could be final version.

Kind regards,
Petr
