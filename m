From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 May 2020 17:06:29 +0200
Subject: [LTP] [PATCH v6 3/3] route: Increase default loop values
In-Reply-To: <c408ffc1-9ba6-ac01-0de9-1726ee72d4a4@oracle.com>
References: <20200429192340.14252-1-pvorel@suse.cz>
 <20200429192340.14252-4-pvorel@suse.cz>
 <c408ffc1-9ba6-ac01-0de9-1726ee72d4a4@oracle.com>
Message-ID: <20200506150629.GA678@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> The changes are fine.
Thanks for your ack.

> Perhaps for further improvements, ROUTE_CHANGE_NETLINK is limited by
> "NUM_LOOPS_MAX 65535", it looks unnecessary.
Sure, I'll remove this. It fails if -c is bigger than INT_MAX, thus suggest:

+++ testcases/network/stress/route/route-change-netlink.c
@@ -20,8 +20,6 @@
 #include "tst_safe_net.h"
 #include "tst_safe_stdio.h"
 
-#define NUM_LOOPS_MAX 65535
-
 #define IP_ADDR_DELIM ','
 #define STR(x) #x
 #define CHR2STR(x) STR(x)
@@ -117,8 +115,8 @@ static void setup(void)
 	if (tst_parse_int(p_opt, &port, 1, 65535))
 		tst_brk(TBROK, "invalid rhost port '%s'", p_opt);
 
-	if (tst_parse_int(c_opt, &num_loops, 1, NUM_LOOPS_MAX)) {
-		num_loops = NUM_LOOPS_MAX;
+	if (tst_parse_int(c_opt, &num_loops, 1, INT_MAX)) {
+		num_loops = INT_MAX;
 		tst_res(TWARN, "invalid number of loops (-c %s), using: %d",
 			c_opt, num_loops);
 	}
---

Or I can use long and LONG_MAX, but IMHO int is OK :)

> Can we limit the setup only and iterate (adding and deleting) from
> the beginning or use -i option with -c?
I'm sorry, I don't understand you. Isn't it INT_MAX enough?

Kind regards,
Petr
