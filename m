From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 3 Apr 2020 19:02:54 +0200
Subject: [LTP] [RFC PATCH v3 2/2] net/route: Add netlink based route
 change gw/dest tests
In-Reply-To: <20200403165432.19358-3-pvorel@suse.cz>
References: <20200403165432.19358-1-pvorel@suse.cz>
 <20200403165432.19358-3-pvorel@suse.cz>
Message-ID: <20200403170254.GA21083@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> * use libmnl and new C API
> * reuse code in tst_net.h (added in previous commit)

Sorry, these 2 are also outdated:
> * add shell wrapper route-change-netlink.sh (set environment with
>   tst_net.sh instead of using deprecated helpers in testcases/network/stress/ns-tools/)
2 wrappers.

> * add tst_ipaddr_un() into C API, unlike shell API this implementation
>   does not support -c tst_ipaddr_un [-cCOUNTER] [TYPE] syntax.
That was removed in this version.

Kind regards,
Petr
