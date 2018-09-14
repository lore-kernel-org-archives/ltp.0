From: Kenneth Magic <kmagic@google.com>
Date: Fri, 14 Sep 2018 11:40:21 -0700
Subject: [LTP] [PATCH] Correct the kernel_bits value in x86 PER_LINUX32.
Message-ID: <CABHszYso3QWR7yi8b2ZBrJLpVQALWCSnaEHNk0+pL_cOuP_DUg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Android runs all 32bit programs in a PER_LIINUX32 personality
even under a 64 bit kernel, causing the machine to show up as
"i686". Check for and correct this case so tests use the correct
kernel_bits value.

Signed-off-by: Kenneth Magic <kmagic@google.com>
---
 lib/tst_kernel.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 42d64cbdc..8edafb8ff 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -15,21 +15,28 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */

+#include <linux/personality.h>
 #include <sys/utsname.h>
 #include "test.h"
 #include "tst_kernel.h"

-int tst_kernel_bits(void)
+static int get_kernel_bits_from_uname(struct utsname *buf)
 {
- struct utsname buf;
- int kernel_bits;
-
- if (uname(&buf)) {
+ if (uname(buf)) {
  tst_brkm(TBROK | TERRNO, NULL, "uname()");
  return -1;
  }

- kernel_bits = strstr(buf.machine, "64") ? 64 : 32;
+ return strstr(buf->machine, "64") ? 64 : 32;
+}
+
+int tst_kernel_bits(void)
+{
+ struct utsname buf;
+ int kernel_bits = get_kernel_bits_from_uname(&buf);
+
+ if (kernel_bits == -1)
+ return -1;

  /*
  * ARM64 (aarch64) defines 32-bit compatibility modes as
@@ -40,6 +47,34 @@ int tst_kernel_bits(void)
  || !strcmp(buf.machine, "s390x"))
  kernel_bits = 64;

+#ifdef __ANDROID__
+ /* Android's bionic libc sets the PER_LINUX32 personality for all 32-bit
+ * programs. This will cause buf.machine to report as i686 even though
+ * the kernel itself is 64-bit.
+ */
+ if (!strcmp(buf.machine, "i686") &&
+ (personality(0xffffffff) & PER_MASK) == PER_LINUX32) {
+ /* Set the personality back to the default. */
+ if (personality(PER_LINUX) == -1) {
+ tst_brkm(TBROK | TERRNO, NULL, "personality()");
+ return -1;
+ }
+
+ /* Redo the uname check without the PER_LINUX32 personality to
+ * determine the actual kernel bits value.
+ */
+ kernel_bits = get_kernel_bits_from_uname(&buf);
+ if (kernel_bits == -1)
+ return -1;
+
+ /* Set the personality back to PER_LINUX32. */
+ if (personality(PER_LINUX32) == -1) {
+ tst_brkm(TBROK | TERRNO, NULL, "personality()");
+ return -1;
+ }
+ }
+#endif  /* __ANDROID__ */
+
  tst_resm(TINFO, "uname.machine=%s kernel is %ibit",
           buf.machine, kernel_bits);

-- 
2.19.0.397.gdd90340f6a-goog
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180914/48e093ea/attachment-0001.html>
