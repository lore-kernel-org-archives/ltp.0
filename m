From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 23 Jul 2018 16:38:28 +0200
Subject: [LTP] [PATCH] Add crypto to Makefile
Message-ID: <20180723143828.4420-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is missing from my original patch set for the pcrypt_aead01 test. It
appears that the executable is not installed without it.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 11aae96fe..5acc9b8bc 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -38,6 +38,7 @@ ifneq ($(UCLINUX),1)
 SUBDIRS			+= connectors \
 			   containers \
 			   controllers \
+			   crypto \
 			   device-drivers \
 			   firmware \
 			   fs \
-- 
2.16.3

