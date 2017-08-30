From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Aug 2017 16:58:04 +0200
Subject: [LTP] [PATCH] [COMMITTED] tracing/dynamic_debug01: Fix Makefile
Message-ID: <20170830145804.24468-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I should have checked that the top_srcdir is set correctly and that the
make && make install works, sorry.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/tracing/dynamic_debug/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/tracing/dynamic_debug/Makefile b/testcases/kernel/tracing/dynamic_debug/Makefile
index 2a6e53a11..d38138ed6 100644
--- a/testcases/kernel/tracing/dynamic_debug/Makefile
+++ b/testcases/kernel/tracing/dynamic_debug/Makefile
@@ -17,7 +17,7 @@
 #    with this program; if not, see <http://www.gnu.org/licenses/>.
 #
 
-top_srcdir		?= ../../..
+top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-- 
2.13.0

