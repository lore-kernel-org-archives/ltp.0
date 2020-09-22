From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 22 Sep 2020 13:19:07 +0200
Subject: [LTP] [PATCH v2] Fix top_srcdir handling in numa/sound test
 Makefiles
Message-ID: <20200922111907.30889-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Dropped unrelated change to SPDX licence format

 testcases/kernel/numa/Makefile  | 2 +-
 testcases/kernel/sound/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/numa/Makefile b/testcases/kernel/numa/Makefile
index 48494e456..00ba27360 100644
--- a/testcases/kernel/numa/Makefile
+++ b/testcases/kernel/numa/Makefile
@@ -16,7 +16,7 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 
-top_srcdir		:= ../../..
+top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/sound/Makefile b/testcases/kernel/sound/Makefile
index 022e69197..5c728ef36 100644
--- a/testcases/kernel/sound/Makefile
+++ b/testcases/kernel/sound/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-top_srcdir		:= ../../..
+top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-- 
2.28.0

