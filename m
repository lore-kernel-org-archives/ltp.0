From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Dec 2017 18:45:43 +0100
Subject: [LTP] [RFC PATCH 1/2] build.sh: Add cross-compile build option
In-Reply-To: <20171212174544.12310-1-pvorel@suse.cz>
References: <20171212174544.12310-1-pvorel@suse.cz>
Message-ID: <20171212174544.12310-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It requires to set CROSS_COMPILE or CC variable.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 build.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/build.sh b/build.sh
index b0d0fb156..29da4d29e 100755
--- a/build.sh
+++ b/build.sh
@@ -26,10 +26,21 @@ build_32()
 
 build_native()
 {
-	echo "===== native in tree build into $PREFIX ====="
+	echo "===== native in-tree build into $PREFIX ====="
 	build_in_tree
 }
 
+build_cross()
+{
+	local host="${CROSS_COMPILE%-}"
+	[ -n "$host" ] || host="${CC%-gcc}"
+	[ -n "$host" ] || \
+		{ echo "Missing CROSS_COMPILE and CC variables. You need to set at least one" >&2; exit 1; }
+
+	echo "===== cross-compile ${host} in-tree build into $PREFIX ====="
+	build_in_tree "--host=$host" CROSS_COMPILE="${host}-"
+}
+
 build_out_tree()
 {
 	local tree="$PWD"
@@ -90,6 +101,7 @@ Options:
 
 BUILD TYPES:
 32      32-bit in-tree build
+cross   cross-compile in-tree build (requires to set CROSS_COMPILE or CC variable)
 native  native in-tree build
 out     out-of-tree build
 
@@ -100,6 +112,7 @@ EOF
 case "$1" in
 	-h|--help|help) usage; exit 0;;
 	32) build="build_32";;
+	cross) build="build_cross";;
 	out) build="build_out_tree";;
 	*) build="build_native";;
 esac
-- 
2.15.0

