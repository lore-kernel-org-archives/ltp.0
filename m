From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 3 Apr 2020 18:59:22 +0200
Subject: [LTP] [RFC PATCH v3 2/2] net/route: Add netlink based route
 change gw/dest tests
In-Reply-To: <20200403165432.19358-3-pvorel@suse.cz>
References: <20200403165432.19358-1-pvorel@suse.cz>
 <20200403165432.19358-3-pvorel@suse.cz>
Message-ID: <20200403165922.GA20326@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> +++ b/runtest/net_stress.route
> @@ -2,11 +2,15 @@
>  route4-change-dst route-change-dst.sh
>  route4-change-gw route-change-gw.sh
>  route4-change-if route-change-if.sh
> +route4-change-netlink-dst route-change-netlink.sh
> +route4-change-netlink-gw route-change-netlink.sh -g
>  route4-redirect route4-redirect
>  route4-rmmod route4-rmmod

>  route6-change-dst route-change-dst.sh -6
>  route6-change-gw route-change-gw.sh -6
>  route6-change-if route-change-if.sh -6
> +route6-change-netlink-dst route-change-netlink.sh
> +route6-change-netlink-gw route-change-netlink.sh -g
>  route6-redirect route6-redirect
>  route6-rmmod route6-rmmod

I haven't updated the runtest file (route-change-netlink.sh =>
route-change-netlink-dst.sh and route-change-netlink-gw.sh)

Kind regards,
Petr

diff --git runtest/net_stress.route runtest/net_stress.route
index cfe31df02..0a8cfec39 100644
--- runtest/net_stress.route
+++ runtest/net_stress.route
@@ -2,15 +2,15 @@
 route4-change-dst route-change-dst.sh
 route4-change-gw route-change-gw.sh
 route4-change-if route-change-if.sh
-route4-change-netlink-dst route-change-netlink.sh
-route4-change-netlink-gw route-change-netlink.sh -g
+route4-change-netlink-dst route-change-netlink-dst.sh
+route4-change-netlink-gw route-change-netlink-gw.sh -g
 route4-redirect route4-redirect
 route4-rmmod route4-rmmod
 
 route6-change-dst route-change-dst.sh -6
 route6-change-gw route-change-gw.sh -6
 route6-change-if route-change-if.sh -6
-route6-change-netlink-dst route-change-netlink.sh
-route6-change-netlink-gw route-change-netlink.sh -g
+route6-change-netlink-dst route-change-netlink-dst.sh
+route6-change-netlink-gw route-change-netlink-gw.sh -g
 route6-redirect route6-redirect
 route6-rmmod route6-rmmod
