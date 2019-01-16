From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Wed, 16 Jan 2019 10:57:36 +0800
Subject: [LTP] [PATCH v3 1/6] ima/ima_boot_aggregate: Fix the definition of
	event log
In-Reply-To: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
Message-ID: <1547607461-11233-2-git-send-email-zhang.jia@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According to [1], the structure of event log should be packed,
and certain fields should be 32-bit unsigned integer. Fortunately,
keeping natural alignment seems to make everything working as
expected all the time.

[1] page 17,18 @https://trustedcomputinggroup.org/wp-content/uploads/TCG_EFI_Protocol_1_22_Final-v05.pdf

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index f6e7be0..d85d222 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -53,10 +53,10 @@ int main(int argc, char *argv[])
 	struct {
 		struct {
 			u_int32_t pcr;
-			int type;
-			unsigned char digest[SHA_DIGEST_LENGTH];
-			u_int16_t len;
-		} header;
+			u_int32_t type;
+			u_int8_t digest[SHA_DIGEST_LENGTH];
+			u_int32_t len;
+		} header __attribute__ ((packed));
 		char *data;
 	} event;
 	struct {
-- 
1.8.3.1

