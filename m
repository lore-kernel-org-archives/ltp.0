From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Jul 2018 14:53:57 +0200
Subject: [LTP] [PATCH 1/2] netstress: TCONF on wrong -T parameter
Message-ID: <20180719125358.948-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Helps to find typo errors.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/netstress/netstress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 17e401eb0..48fb0aabd 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -837,6 +837,8 @@ static void set_protocol_type(void)
 		proto_type = TYPE_DCCP;
 	else if (!strcmp(type, "sctp"))
 		proto_type = TYPE_SCTP;
+	else
+		tst_brk(TCONF, "wrong proto_type: '%s'", type);
 }
 
 static void setup(void)
-- 
2.18.0

