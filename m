From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 Dec 2018 13:35:14 +0100
Subject: [LTP] [PATCH v2 4/6] ver_linux: Print AppArmor and SELinux status
In-Reply-To: <20181207123516.30867-1-pvorel@suse.cz>
References: <20181207123516.30867-1-pvorel@suse.cz>
Message-ID: <20181207123516.30867-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ add some helper functions

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ver_linux | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/ver_linux b/ver_linux
index 897571703..5994c0e0f 100755
--- a/ver_linux
+++ b/ver_linux
@@ -3,8 +3,35 @@
 # typical as you use for compilation/istallation. I use
 # /bin /sbin /usr/bin /usr/sbin /usr/local/bin, but it may
 # differ on your system.
-#
+
 PATH=/sbin:/usr/sbin:/bin:/usr/bin:$PATH
+
+tst_cmd_available()
+{
+	if type command > /dev/null 2>&1; then
+		command -v $1 > /dev/null 2>&1 || return 1
+	else
+		which $1 > /dev/null 2>&1
+		if [ $? -eq 0 ]; then
+			return 0
+		else
+			return 1
+		fi
+	fi
+}
+
+tst_cmd_run()
+{
+	local cmd="$1"
+	shift
+	tst_cmd_available $cmd && eval "$cmd $@"
+}
+
+is_enabled()
+{
+	[ -f "$1" ] && [ "$(cat $1)" = "Y" -o "$(cat $1)" = "1" ]
+}
+
 echo 'If some fields are empty or look unusual you may have an old version.'
 echo 'Compare to the current minimal requirements in Documentation/Changes.'
 
@@ -101,8 +128,19 @@ free
 
 echo
 echo 'cpuinfo:'
-if which lscpu > /dev/null 2>&1; then
-	lscpu
+tst_cmd_run lscpu || cat /proc/cpuinfo
+
+echo
+if is_enabled /sys/module/apparmor/parameters/enabled; then
+	echo 'AppArmor enabled'
+	tst_cmd_run aa-status
 else
-	cat /proc/cpuinfo
+	echo 'AppArmor disabled'
+fi
+
+echo
+
+if ! tst_cmd_run sestatus; then
+	printf 'SELinux mode: '
+	tst_cmd_run getenforce || echo 'unknown'
 fi
-- 
2.19.2

