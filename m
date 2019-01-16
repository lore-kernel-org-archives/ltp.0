From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Wed, 16 Jan 2019 10:57:38 +0800
Subject: [LTP] [PATCH v3 3/6] ima/ima_boot_aggregate: Fix extending PCRs
	beyond PCR 0-7
In-Reply-To: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
Message-ID: <1547607461-11233-4-git-send-email-zhang.jia@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The boot aggragate calculation should never touch PCRs beyond PCR 0-7,
even a PCR extension really manipulates out-of-domain PCRs.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/integrity/ima/src/ima_boot_aggregate.c       | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index 67be6a7..98893b9 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -93,11 +93,16 @@ int main(int argc, char *argv[])
 			printf("%03u ", event.header.pcr);
 			display_sha1_digest(event.header.digest);
 		}
-		SHA1_Init(&c);
-		SHA1_Update(&c, pcr[event.header.pcr].digest,
-			    SHA_DIGEST_LENGTH);
-		SHA1_Update(&c, event.header.digest, SHA_DIGEST_LENGTH);
-		SHA1_Final(pcr[event.header.pcr].digest, &c);
+
+		if (event.header.pcr < NUM_PCRS) {
+			SHA1_Init(&c);
+			SHA1_Update(&c, pcr[event.header.pcr].digest,
+				    SHA_DIGEST_LENGTH);
+			SHA1_Update(&c, event.header.digest,
+				    SHA_DIGEST_LENGTH);
+			SHA1_Final(pcr[event.header.pcr].digest, &c);
+		}
+
 #if MAX_EVENT_DATA_SIZE < USHRT_MAX
 		if (event.header.len > MAX_EVENT_DATA_SIZE) {
 			printf("Error event too long\n");
-- 
1.8.3.1

