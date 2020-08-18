From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Tue, 18 Aug 2020 18:04:21 +0800
Subject: [LTP] [PATCHv2 1/2] lib/tst_kvercmp: Add support to get distname
 for different OS in tst_kvcmp_distname
In-Reply-To: <20200818100422.27775-1-po-hsu.lin@canonical.com>
References: <20200818100422.27775-1-po-hsu.lin@canonical.com>
Message-ID: <20200818100422.27775-2-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The kver on Ubuntu will be something like these:
* 4.4.0-187-generic
* 5.4.0-1021-kvm
* 4.15.0-1093-azure

So it's better to parse OS name from ID= in /etc/os-release, instead
of doing this from checking kver substring like what we did for RHEL
and Oracle Linux here.

From the document [1] this string will alway be in lowercase. Example:
"ID=fedora" or "ID=debian". Thus it needs to be converted to uppercase
to make it consistent with other return values in tst_kvcmp_distname().

Note that if ID was not set, it will default to "ID=linux". Thus we
can expect to get LINUX on some distros.

[1] https://www.freedesktop.org/software/systemd/man/os-release.html

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 lib/tst_kvercmp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index dc3bb669b..af6c6de69 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#include <ctype.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
@@ -25,6 +26,8 @@
 #include <sys/utsname.h>
 #include "test.h"
 
+#define OSRELEASE_PATH "/etc/os-release"
+
 static char *parse_digit(const char *str, int *d)
 {
 	unsigned long v;
@@ -127,6 +130,8 @@ int tst_kvexcmp(const char *tst_exv, const char *cur_ver)
 
 const char *tst_kvcmp_distname(const char *kver)
 {
+	static char distname[64];
+	char *tok;
 	if (strstr(kver, ".el5uek"))
 		return "OL5UEK";
 
@@ -139,6 +144,17 @@ const char *tst_kvcmp_distname(const char *kver)
 	if (strstr(kver, ".el6"))
 		return "RHEL6";
 
+	// Special case for other releases with the presencse of /etc/os-release
+	if (access(OSRELEASE_PATH, F_OK) != -1) {
+		SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
+		tok = strtok(distname,"\0");
+		while (*tok) {
+			*tok = toupper((unsigned char) *tok);
+			tok++;
+		}
+		return distname;
+	}
+
 	return NULL;
 }
 
-- 
2.25.1

