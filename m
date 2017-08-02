From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed,  2 Aug 2017 16:24:22 +0200
Subject: [LTP] [PATCH] cve-2016-4997: Provide fallback for xt_entry structs
Message-ID: <20170802142422.5392-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Old systems (i.e SLE10) do not have xt_entry_match and/or xt_entry_target.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 configure.ac                  |  1 +
 m4/ltp-x_tables.m4            | 24 ++++++++++++++++++++++++
 testcases/cve/cve-2016-4997.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 m4/ltp-x_tables.m4

diff --git a/configure.ac b/configure.ac
index 223241c78..23e583dd8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -193,5 +193,6 @@ LTP_CHECK_SYNC_ADD_AND_FETCH
 LTP_CHECK_BUILTIN_CLEAR_CACHE
 LTP_CHECK_MMSGHDR
 LTP_CHECK_UNAME_DOMAINNAME
+LTP_CHECK_X_TABLES
 
 AC_OUTPUT
diff --git a/m4/ltp-x_tables.m4 b/m4/ltp-x_tables.m4
new file mode 100644
index 000000000..cd6a600c7
--- /dev/null
+++ b/m4/ltp-x_tables.m4
@@ -0,0 +1,24 @@
+dnl Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+AC_DEFUN([LTP_CHECK_X_TABLES],[
+AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
+#include <sys/types.h>
+#include <netinet/in.h>
+#include <net/if.h>
+#include <limits.h>
+#include <linux/netfilter_ipv4/ip_tables.h>
+])
+])
diff --git a/testcases/cve/cve-2016-4997.c b/testcases/cve/cve-2016-4997.c
index a413b561e..2d99865b7 100644
--- a/testcases/cve/cve-2016-4997.c
+++ b/testcases/cve/cve-2016-4997.c
@@ -27,6 +27,7 @@
  * a user namespace.
  */
 
+#include <stdint.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
@@ -45,6 +46,42 @@
 		     + sizeof(struct xt_entry_target))
 #define PADDING (OFFSET_OVERWRITE - NEXT_OFFSET)
 
+#ifndef HAVE_STRUCT_XT_ENTRY_MATCH
+struct xt_entry_match {
+	union {
+		struct {
+			uint16_t match_size;
+			char name[29];
+			uint8_t revision;
+		} user;
+		struct {
+			uint16_t match_size;
+			void *match;
+		} kernel;
+		uint16_t match_size;
+	} u;
+	unsigned char data[0];
+};
+#endif
+
+#ifndef HAVE_STRUCT_XT_ENTRY_TARGET
+struct xt_entry_target {
+	union {
+		struct {
+			uint16_t target_size;
+			char name[29];
+			uint8_t revision;
+		} user;
+		struct {
+			uint16_t target_size;
+			void *target;
+		} kernel;
+		uint16_t target_size;
+	} u;
+	unsigned char data[0];
+};
+#endif
+
 struct payload {
 	struct ipt_replace repl;
 	struct ipt_entry ent;
-- 
2.13.3

