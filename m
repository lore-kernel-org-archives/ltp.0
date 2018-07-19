From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Jul 2018 14:53:58 +0200
Subject: [LTP] [RFC PATCH 2/2] netstress: Update help for -m behavior
In-Reply-To: <20180719125358.948-1-pvorel@suse.cz>
References: <20180719125358.948-1-pvorel@suse.cz>
Message-ID: <20180719125358.948-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For udp, udp_lite and DCCP on client is timeout set 100.
For udp and udp_lite on server on low timeout it reaches "recv failed"
error (due no listen in udp and udp_lite).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I documented the current state, but I it looks to me that udp and
udp_lite on server is a bug. Or wanted behaviour?


Kind regards,
Petr
---
 testcases/network/netstress/netstress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 48fb0aabd..62301ca9f 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -999,7 +999,7 @@ static struct tst_option options[] = {
 	{"r:", &rarg, "-r x     Number of client requests"},
 	{"n:", &narg, "-n x     Client message size"},
 	{"N:", &Narg, "-N x     Server message size"},
-	{"m:", &Targ, "-m x     Reply timeout in microsec."},
+	{"m:", &Targ, "-m x     Reply timeout in microsec (only for tcp and sctp, also affects server on udp and udp_lite)."},
 	{"d:", &rpath, "-d x     x is a path to file where result is saved"},
 	{"A:", &Aarg, "-A x     x max payload length (generated randomly)\n"},
 
-- 
2.18.0

