From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 30 Jan 2019 12:28:25 +0100
Subject: [LTP] [PATCH 2/3] lib/tst_kernel.c: Use <sys/personality.h>
In-Reply-To: <20190130112826.7157-1-petr.vorel@gmail.com>
References: <20190130112826.7157-1-petr.vorel@gmail.com>
Message-ID: <20190130112826.7157-3-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

personality() has been defined in <sys/personality.h> since glibc 2.3
(long enough to be used).

This fixes build on Android.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 lib/tst_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index a7fd38b4d..73ab9f1b1 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -15,7 +15,7 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/personality.h>
+#include <sys/personality.h>
 #include <sys/utsname.h>
 #include "test.h"
 #include "tst_kernel.h"
-- 
2.20.1

