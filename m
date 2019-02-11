From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 11 Feb 2019 21:07:45 +0300
Subject: [LTP] [PATCH 2/4] netstress: allow setting MSG_ZEROCOPY for other
	protocols
In-Reply-To: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
References: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1549908467-15609-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 2cdc91a..63d02c9 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -942,13 +942,14 @@ static void setup(void)
 		}
 	}
 
+	if (zcopy)
+		send_flags |= MSG_ZEROCOPY;
+
 	switch (proto_type) {
 	case TYPE_TCP:
 		tst_res(TINFO, "TCP %s is using %s TCP API.",
 			(client_mode) ? "client" : "server",
 			(fastopen_api) ? "Fastopen" : "old");
-		if (zcopy)
-			send_flags |= MSG_ZEROCOPY;
 		check_tfo_value();
 	break;
 	case TYPE_UDP:
-- 
1.7.1

