From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Apr 2018 21:54:58 +0200
Subject: [LTP] [RFC PATCH v3 05/10] ima/ima_boot_aggregate: Increase
	MAX_EVENT_SIZE to 1MB
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Message-ID: <20180419195503.7194-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is needed as according IMA developers there are BIOS events larger
than 4k [1]. Actual size for TPM 1.2 is undefined, TPM 2.0 specifies:
"For software parsing the event log, the parser can choose an arbitrary
maximum size, but this specification recommends a maximum value for the
TCG_PCR_EVENT2.eventSize field of 1MB." [2].

So lets follow the specification and allocate 1MB.

[1] http://lists.linux.it/pipermail/ltp/2018-January/006970.html
[2] http://lists.linux.it/pipermail/ltp/2018-January/007002.html

Suggested-by: George Wilson <gcwilson@us.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/src/ima_boot_aggregate.c      | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index f7ae77cb1..862cc07ba 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -21,6 +21,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
 
 #include "config.h"
 #include "test.h"
@@ -30,7 +31,7 @@ char *TCID = "ima_boot_aggregate";
 #if HAVE_LIBCRYPTO
 #include <openssl/sha.h>
 
-#define MAX_EVENT_SIZE 500
+#define MAX_EVENT_SIZE (1024*1024)
 #define EVENT_HEADER_SIZE 32
 #define MAX_EVENT_DATA_SIZE (MAX_EVENT_SIZE - EVENT_HEADER_SIZE)
 #define NUM_PCRS 8		/*  PCR registers 0-7 in boot aggregate */
@@ -56,7 +57,7 @@ int main(int argc, char *argv[])
 			unsigned char digest[SHA_DIGEST_LENGTH];
 			u_int16_t len;
 		} header;
-		unsigned char data[MAX_EVENT_DATA_SIZE];
+		char *data;
 	} event;
 	struct {
 		unsigned char digest[SHA_DIGEST_LENGTH];
@@ -80,6 +81,12 @@ int main(int argc, char *argv[])
 	for (i = 0; i < NUM_PCRS; i++)
 		memset(&pcr[i].digest, 0, SHA_DIGEST_LENGTH);
 
+	event.data = (char *) malloc(MAX_EVENT_DATA_SIZE);
+	if (!event.data) {
+		printf("Cannot allocate memory\n");
+		return 1;
+	}
+
 	/* Extend the pseudo PCRs with the event digest */
 	while (fread(&event, sizeof(event.header), 1, fp)) {
 		if (debug) {
@@ -90,13 +97,16 @@ int main(int argc, char *argv[])
 		SHA1_Update(&c, pcr[event.header.pcr].digest, 20);
 		SHA1_Update(&c, event.header.digest, 20);
 		SHA1_Final(pcr[event.header.pcr].digest, &c);
+#if MAX_EVENT_DATA_SIZE < USHRT_MAX
 		if (event.header.len > MAX_EVENT_DATA_SIZE) {
-			printf("Error event too long");
+			printf("Error event too long\n");
 			break;
 		}
+#endif
 		fread(event.data, event.header.len, 1, fp);
 	}
 	fclose(fp);
+	free(event.data);
 
 	/* Extend the boot aggregate with the pseudo PCR digest values */
 	memset(&boot_aggregate, 0, SHA_DIGEST_LENGTH);
-- 
2.16.3

