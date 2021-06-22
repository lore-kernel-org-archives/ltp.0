From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 22 Jun 2021 12:35:11 +0100
Subject: [LTP] [PATCH 5/8] ksmg01: Fix uninitialized var error
In-Reply-To: <20210622113514.22284-1-rpalethorpe@suse.com>
References: <20210622113514.22284-1-rpalethorpe@suse.com>
Message-ID: <20210622113514.22284-6-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The compiler is confused by tst_brk which it thinks will
return. Setting first_seqno silences the error.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/logging/kmsg/kmsg01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index 34c6073c6..bf2de5741 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -384,7 +384,7 @@ static void test_messages_overwritten(void)
 {
 	int i, fd;
 	char msg[MAX_MSGSIZE];
-	unsigned long first_seqno, seqno;
+	unsigned long first_seqno = 0, seqno;
 	char filler_str[] = "<7>"MSG_PREFIX"FILLER MESSAGE TO OVERWRITE OTHERS\n";
 
 	/* Keep injecting messages until we overwrite first one.
-- 
2.31.1

