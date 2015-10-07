From: Matus Marhefka <mmarhefk@redhat.com>
Date: Wed,  7 Oct 2015 15:08:17 +0200
Subject: [LTP] [PATCH v2] containers/share: added namespaces types argument
	for ns_exec
In-Reply-To: <1443775836-21843-1-git-send-email-mmarhefk@redhat.com>
References: <1443775836-21843-1-git-send-email-mmarhefk@redhat.com>
Message-ID: <1444223297-18882-1-git-send-email-mmarhefk@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In contrast with all other namespaces, joining the same user namespace
returns EINVAL. Because of that ns_exec now requires to specify the list
of types of namespaces in which to execute a program. The list of a comma
separated namespaces should be in the same order as list specified for
ns_create.

All testcases in containers/netns were modified to use namespaces types
argument when executing ns_create and ns_exec.

netns/netns_sysfs.sh:
* renamed "dummy0" to less common name "dummy_test0"
* /sys is now correctly mounted as private in a new namespace before
  testing to not affect main mount namespace
* added test case which checks that only localhost and dummy interfaces
  are seen in /sys/class/net/ after mounting sysfs in a new namespace

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 doc/namespaces-helper-tools.txt                    |  8 ++--
 testcases/kernel/containers/netns/netns_breakns.sh |  4 +-
 testcases/kernel/containers/netns/netns_comm.sh    | 10 ++--
 testcases/kernel/containers/netns/netns_helper.sh  | 38 ++++++++-------
 testcases/kernel/containers/netns/netns_sysfs.sh   | 44 +++++++++++++----
 testcases/kernel/containers/share/ns_common.h      | 55 ++++++++++++++++++++++
 testcases/kernel/containers/share/ns_create.c      | 46 +++++-------------
 testcases/kernel/containers/share/ns_exec.c        | 48 ++++++++++++-------
 testcases/kernel/containers/share/ns_ifmove.c      |  2 +-
 9 files changed, 166 insertions(+), 89 deletions(-)
 create mode 100644 testcases/kernel/containers/share/ns_common.h

diff --git a/doc/namespaces-helper-tools.txt b/doc/namespaces-helper-tools.txt
index 3dbe617..6990e01 100644
--- a/doc/namespaces-helper-tools.txt
+++ b/doc/namespaces-helper-tools.txt
@@ -14,6 +14,8 @@ located in ltp/testcases/kernel/containers/share directory and include:
 ** PID of the daemonized child process is printed on the stdout
 ** the new namespace(s) is(are) maintained by the daemonized child process
 ** namespace(s) can be removed by killing the daemonized process
+* setns_check
+** check for setns() availability, should be called before using ns_exec
 * ns_exec
 ** enters the namespace(s) of a process specified by a PID
 ** then executes the indicated program inside that namespace(s)
@@ -34,18 +36,18 @@ The following code shows how test cases can use the namespaces helper tools:
 -------------------------------------------------------------------------------
 # Creates a new network and ipc namespace and stores the PID of the daemonized
 # process inside that namespace into variable myns
-myns=$(ns_create net ipc)
+myns=$(ns_create net,ipc)
 
 ip link add veth0 type veth peer name veth1
 
 # Executes command 'ip a' inside the namespace specified by PID in myns variable
-ns_exec $myns ip a
+ns_exec $myns net,ipc ip a
 1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
 
 # Moves interface veth1 into the namespace specified by PID in myns variable
 ns_ifmove veth1 $myns
-ns_exec $myns ip a
+ns_exec $myns net,ipc ip a
 1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
 6: veth1: <BROADCAST> mtu 1500 qdisc noop state DOWN qlen 1000
diff --git a/testcases/kernel/containers/netns/netns_breakns.sh b/testcases/kernel/containers/netns/netns_breakns.sh
index ef49690..7073373 100755
--- a/testcases/kernel/containers/netns/netns_breakns.sh
+++ b/testcases/kernel/containers/netns/netns_breakns.sh
@@ -52,7 +52,7 @@ tst_resm TINFO "NS interaction: $1 | devices setup: $3"
 
 
 # TEST CASE #1
-$NS_EXEC $NS_HANDLE0 ip address add $IP1/$NETMASK dev veth1 2>/dev/null
+$NS_EXEC $NS_HANDLE0 $NS_TYPE ip address add $IP1/$NETMASK dev veth1 2>/dev/null
 if [ $? -ne 0 ]; then
 	tst_resm TPASS "controlling device over netlink"
 else
@@ -62,7 +62,7 @@ fi
 
 # TEST CASE #2
 tst_check_cmds ifconfig
-$NS_EXEC $NS_HANDLE0 ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK 2>/dev/null
+$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK 2>/dev/null
 if [ $? -ne 0 ]; then
 	tst_resm TPASS "controlling device over ioctl"
 else
diff --git a/testcases/kernel/containers/netns/netns_comm.sh b/testcases/kernel/containers/netns/netns_comm.sh
index ab4c64c..15991e2 100755
--- a/testcases/kernel/containers/netns/netns_comm.sh
+++ b/testcases/kernel/containers/netns/netns_comm.sh
@@ -55,7 +55,7 @@ tst_resm TINFO "NS interaction: $1 | devices setup: $3"
 
 
 # TEST CASE #1
-$NS_EXEC $NS_HANDLE0 $tping -q -c2 -I veth0 $IP1 1>/dev/null
+$NS_EXEC $NS_HANDLE0 $NS_TYPE $tping -q -c2 -I veth0 $IP1 1>/dev/null
 if [ $? -eq 0 ]; then
 	tst_resm TPASS "configuration and communication over veth0"
 else
@@ -64,7 +64,7 @@ fi
 
 
 # TEST CASE #2
-$NS_EXEC $NS_HANDLE1 $tping -q -c2 -I veth1 $IP0 1>/dev/null
+$NS_EXEC $NS_HANDLE1 $NS_TYPE $tping -q -c2 -I veth1 $IP0 1>/dev/null
 if [ $? -eq 0 ]; then
 	tst_resm TPASS "configuration and communication over veth1"
 else
@@ -79,15 +79,15 @@ ipv6) IP_LO="::1" ;;
 esac
 case "$3" in
 netlink)
-	$NS_EXEC $NS_HANDLE0 ip link set dev lo up || \
+	$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link set dev lo up || \
 		tst_brkm TBROK "enabling lo device failed"
 	;;
 ioctl)
-	$NS_EXEC $NS_HANDLE0 ifconfig lo up || \
+	$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig lo up || \
 		tst_brkm TBROK "enabling lo device failed"
 	;;
 esac
-$NS_EXEC $NS_HANDLE0 $tping -q -c2 -I lo $IP_LO 1>/dev/null
+$NS_EXEC $NS_HANDLE0 $NS_TYPE $tping -q -c2 -I lo $IP_LO 1>/dev/null
 if [ $? -eq 0 ]; then
 	tst_resm TPASS "configuration and communication over localhost"
 else
diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index ac08125..188211f 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -32,6 +32,10 @@ USE_IFCONFIG=0
 # netns_setup() function call.
 NS_EXEC=""
 
+# Set to "net" for ns_create/ns_exec as their options requires
+# to specify a namespace type. Empty for ip command.
+NS_TYPE=""
+
 # IP addresses of veth0 (IP0) and veth1 (IP1) devices (ipv4/ipv6 variant
 # is determined according to the IP_VERSION argument specified in netns_setup()
 # function call.
@@ -114,6 +118,7 @@ netns_setup()
 		if [ $? -eq 32 ]; then
 			tst_brkm TCONF "setns not supported"
 		fi
+		NS_TYPE="net"
 		netns_ns_exec_setup
 		TST_CLEANUP=netns_ns_exec_cleanup
 		;;
@@ -180,22 +185,22 @@ netns_ns_exec_setup()
 {
 	NS_EXEC="ns_exec"
 
-	NS_HANDLE0=$(ns_create net)
+	NS_HANDLE0=$(ns_create $NS_TYPE)
 	if [ $? -eq 1 ]; then
 		tst_resm TINFO "$NS_HANDLE0"
 		tst_brkm TBROK "unable to create a new network namespace"
 	fi
 
-	NS_HANDLE1=$(ns_create net)
+	NS_HANDLE1=$(ns_create $NS_TYPE)
 	if [ $? -eq 1 ]; then
 		tst_resm TINFO "$NS_HANDLE1"
 		tst_brkm TBROK "unable to create a new network namespace"
 	fi
 
-	$NS_EXEC $NS_HANDLE0 ip link add veth0 type veth peer name veth1 || \
+	$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link add veth0 type veth peer name veth1 || \
 		tst_brkm TBROK "unable to create veth pair devices"
 
-	$NS_EXEC $NS_HANDLE0 ns_ifmove veth1 $NS_HANDLE1
+	$NS_EXEC $NS_HANDLE0 $NS_TYPE ns_ifmove veth1 $NS_HANDLE1
 	if [ $? -eq 0 ]; then
 		return;
 	fi
@@ -239,9 +244,6 @@ netns_ip_setup()
 # of them (IPv4/IPv6 variant is decided by netns_setup() function).
 netns_set_ip()
 {
-	local state
-	local counter
-
 	if [ -z "$NS_EXEC" ]; then
 		tst_brkm TBROK "netns_setup() function must be called first"
 	fi
@@ -253,32 +255,32 @@ netns_set_ip()
 	# there is no other host with the same address, the address is
 	# considered to be "tentative" (attempts to bind() to the address fail
 	# with EADDRNOTAVAIL) which may cause problems for tests using ipv6.
-	echo 0 | $NS_EXEC $NS_HANDLE0 \
+	echo 0 | $NS_EXEC $NS_HANDLE0 $NS_TYPE \
 		tee /proc/sys/net/ipv6/conf/veth0/accept_dad \
 		/proc/sys/net/ipv6/conf/veth0/accept_ra >/dev/null
-	echo 0 | $NS_EXEC $NS_HANDLE1 \
+	echo 0 | $NS_EXEC $NS_HANDLE1 $NS_TYPE \
 		tee /proc/sys/net/ipv6/conf/veth1/accept_dad \
 		/proc/sys/net/ipv6/conf/veth1/accept_ra >/dev/null
 
 	case $USE_IFCONFIG in
 	1)
-		$NS_EXEC $NS_HANDLE0 ifconfig veth0 $IFCONF_IN6_ARG $IP0/$NETMASK ||
+		$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth0 $IFCONF_IN6_ARG $IP0/$NETMASK ||
 			tst_brkm TBROK "adding address to veth0 failed"
-		$NS_EXEC $NS_HANDLE1 ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK ||
+		$NS_EXEC $NS_HANDLE1 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK ||
 			tst_brkm TBROK "adding address to veth1 failed"
-		$NS_EXEC $NS_HANDLE0 ifconfig veth0 up ||
+		$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth0 up ||
 			tst_brkm TBROK "enabling veth0 device failed"
-		$NS_EXEC $NS_HANDLE1 ifconfig veth1 up ||
+		$NS_EXEC $NS_HANDLE1 $NS_TYPE ifconfig veth1 up ||
 			tst_brkm TBROK "enabling veth1 device failed"
 		;;
 	*)
-		$NS_EXEC $NS_HANDLE0 ip address add $IP0/$NETMASK dev veth0 ||
+		$NS_EXEC $NS_HANDLE0 $NS_TYPE ip address add $IP0/$NETMASK dev veth0 ||
 			tst_brkm TBROK "adding address to veth0 failed"
-		$NS_EXEC $NS_HANDLE1 ip address add $IP1/$NETMASK dev veth1 ||
+		$NS_EXEC $NS_HANDLE1 $NS_TYPE ip address add $IP1/$NETMASK dev veth1 ||
 			tst_brkm TBROK "adding address to veth1 failed"
-		$NS_EXEC $NS_HANDLE0 ip link set veth0 up ||
+		$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link set veth0 up ||
 			tst_brkm TBROK "enabling veth0 device failed"
-		$NS_EXEC $NS_HANDLE1 ip link set veth1 up ||
+		$NS_EXEC $NS_HANDLE1 $NS_TYPE ip link set veth1 up ||
 			tst_brkm TBROK "enabling veth1 device failed"
 		;;
 	esac
@@ -291,7 +293,7 @@ netns_ns_exec_cleanup()
 	fi
 
 	# removes veth0 device (which also removes the paired veth1 device)
-	$NS_EXEC $NS_HANDLE0 ip link delete veth0
+	$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link delete veth0
 
 	kill -9 $NS_HANDLE0 2>/dev/null
 	kill -9 $NS_HANDLE1 2>/dev/null
diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
index 06de00f..7dea52b 100755
--- a/testcases/kernel/containers/netns/netns_sysfs.sh
+++ b/testcases/kernel/containers/netns/netns_sysfs.sh
@@ -23,7 +23,9 @@
 #==============================================================================
 
 TCID="netns_sysfs"
-TST_TOTAL=2
+TST_TOTAL=3
+NS_TYPE="net,mnt"
+DUMMYDEV="dummy_test0"
 . test.sh
 
 setns_check
@@ -34,12 +36,12 @@ fi
 cleanup()
 {
 	tst_rmdir
-	ip link del dummy0 2>/dev/null
+	ip link del $DUMMYDEV 2>/dev/null
 	kill -9 $NS_HANDLE 2>/dev/null
 }
 
 tst_tmpdir
-NS_HANDLE=$(ns_create net mnt)
+NS_HANDLE=$(ns_create $NS_TYPE)
 if [ $? -eq 1 ]; then
 	tst_resm TINFO "$NS_HANDLE"
 	tst_brkm TBROK "unable to create a new network namespace"
@@ -47,18 +49,41 @@ fi
 TST_CLEANUP=cleanup
 ls /sys/class/net >sysfs_before
 
-
-ns_exec $NS_HANDLE ip link add dummy0 type dummy || \
+ns_exec $NS_HANDLE $NS_TYPE mount --make-rprivate /sys
+ns_exec $NS_HANDLE $NS_TYPE ip link add $DUMMYDEV type dummy || \
 	tst_brkm TBROK "failed to add a new dummy device"
-ns_exec $NS_HANDLE mount -t sysfs none /sys 2>/dev/null
+ns_exec $NS_HANDLE $NS_TYPE mount -t sysfs none /sys 2>/dev/null
+
 
-ns_exec $NS_HANDLE test -d /sys/class/net/dummy0
+# TEST CASE #1
+ns_exec $NS_HANDLE $NS_TYPE test -d /sys/class/net/$DUMMYDEV
 if [ $? -eq 0 ]; then
-	tst_resm TPASS "sysfs in new namespace has dummy0 interface"
+	tst_resm TPASS "sysfs in new namespace has $DUMMYDEV interface"
+else
+	tst_resm TFAIL "sysfs in new namespace does not have $DUMMYDEV interface"
+fi
+
+
+# TEST CASE #2
+res=0
+for d in $(ns_exec $NS_HANDLE $NS_TYPE ls /sys/class/net/); do
+	case "$d" in
+		lo|$DUMMYDEV)
+			;;
+		*)
+			tst_resm TINFO "sysfs in new namespace should not contain: $d"
+			res=1
+			;;
+	esac
+done
+if [ $res -eq 0 ]; then
+	tst_resm TPASS "sysfs in new namespace has only lo and $DUMMYDEV interfaces"
 else
-	tst_resm TFAIL "sysfs in new namespace does not have dummy0 interface"
+	tst_resm TFAIL "sysfs in new namespace has more than lo and $DUMMYDEV interfaces"
 fi
 
+
+# TEST CASE #3
 ls /sys/class/net >sysfs_after
 diff sysfs_before sysfs_after
 if [ $? -eq 0 ]; then
@@ -67,4 +92,5 @@ else
 	tst_resm TFAIL "sysfs affected by a separate namespace"
 fi
 
+
 tst_exit
diff --git a/testcases/kernel/containers/share/ns_common.h b/testcases/kernel/containers/share/ns_common.h
new file mode 100644
index 0000000..69e51ce
--- /dev/null
+++ b/testcases/kernel/containers/share/ns_common.h
@@ -0,0 +1,55 @@
+/* Copyright (c) 2015 Red Hat, Inc.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of version 2 the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ ***********************************************************************/
+
+#ifndef __NS_COMMON_H__
+#define __NS_COMMON_H__
+#include <sched.h>
+#include "lapi/namespaces_constants.h"
+
+#define PROC_PATH "/proc"
+#define NS_TOTAL 6
+
+
+struct param {
+	const char *name;
+	int flag;
+};
+
+struct param params[] = {
+	{"ipc",  CLONE_NEWIPC},
+	{"mnt",  CLONE_NEWNS},
+	{"net",  CLONE_NEWNET},
+	{"pid",  CLONE_NEWPID},
+	{"user", CLONE_NEWUSER},
+	{"uts",  CLONE_NEWUTS},
+	{NULL,   0}
+};
+
+
+struct param *get_param(const char *name)
+{
+	int i;
+
+	for (i = 0; params[i].name; i++) {
+		if (!strcasecmp(params[i].name, name))
+			return params + i;
+	}
+
+	return NULL;
+}
+
+
+#endif
diff --git a/testcases/kernel/containers/share/ns_create.c b/testcases/kernel/containers/share/ns_create.c
index 5f5a5ad..1d0339e 100644
--- a/testcases/kernel/containers/share/ns_create.c
+++ b/testcases/kernel/containers/share/ns_create.c
@@ -29,40 +29,15 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <string.h>
 #include <strings.h>
 #include <errno.h>
 #include "test.h"
 #include "lapi/namespaces_constants.h"
+#include "ns_common.h"
 
 char *TCID = "ns_create";
 
-struct param {
-	const char *name;
-	int flag;
-};
-
-struct param params[] = {
-	{"ipc",  CLONE_NEWIPC},
-	{"mnt",  CLONE_NEWNS},
-	{"net",  CLONE_NEWNET},
-	{"pid",  CLONE_NEWPID},
-	{"user", CLONE_NEWUSER},
-	{"uts",  CLONE_NEWUTS},
-	{NULL,   0}
-};
-
-
-struct param *get_param(const char *name)
-{
-	int i;
-
-	for (i = 0; params[i].name; i++) {
-		if (!strcasecmp(params[i].name, name))
-			return params + i;
-	}
-
-	return NULL;
-}
 
 void print_help(void)
 {
@@ -71,8 +46,9 @@ void print_help(void)
 	printf("usage: ns_create <%s", params[0].name);
 
 	for (i = 1; params[i].name; i++)
-		printf("|%s", params[i].name);
-	printf(">\n");
+		printf("|,%s", params[i].name);
+	printf(">\nThe only argument is a comma separated list "
+	       "of namespaces to create.\nExample: ns_create net,ipc\n");
 }
 
 static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED)
@@ -98,12 +74,12 @@ static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED)
 }
 
 /*
- * ./ns_create <ipc|mnt|net|pid|user|uts>
- * where all possible namespaces are: ipc, mnt, net, pid, user, uts.
+ * ./ns_create <ipc,mnt,net,pid,user,uts>
  */
 int main(int argc, char *argv[])
 {
-	int pid, flags, i;
+	int pid, flags;
+	char *token;
 
 	if (argc < 2) {
 		print_help();
@@ -111,11 +87,11 @@ int main(int argc, char *argv[])
 	}
 
 	flags = 0;
-	for (i = 1; argv[i]; i++) {
-		struct param *p = get_param(argv[i]);
+	while ((token = strsep(&argv[1], ","))) {
+		struct param *p = get_param(token);
 
 		if (!p) {
-			tst_resm(TINFO, "Unknown parameter: %s", argv[i]);
+			tst_resm(TINFO, "Unknown namespace: %s", token);
 			print_help();
 			return 1;
 		}
diff --git a/testcases/kernel/containers/share/ns_exec.c b/testcases/kernel/containers/share/ns_exec.c
index e2f068c..ddf1382 100644
--- a/testcases/kernel/containers/share/ns_exec.c
+++ b/testcases/kernel/containers/share/ns_exec.c
@@ -32,15 +32,27 @@
 #include "test.h"
 #include "linux_syscall_numbers.h"
 #include "lapi/namespaces_constants.h"
-
-#define PROC_PATH "/proc"
-#define NS_TOTAL 6
+#include "ns_common.h"
 
 char *TCID = "ns_exec";
 int ns_fd[NS_TOTAL];
 int ns_fds;
 
 
+void print_help(void)
+{
+	int i;
+
+	printf("usage: ns_exec <NS_PID> <%s", params[0].name);
+
+	for (i = 1; params[i].name; i++)
+		printf("|,%s", params[i].name);
+	printf("> <PROGRAM> [ARGS]\nSecond argument indicates the types"
+	       " of a namespaces maintained by NS_PID\nand is specified"
+	       " as a comma separated list.\nExample: ns_exec 1234 net,ipc"
+	       " ip a\n");
+}
+
 static int open_ns_fd(const char *pid, const char *ns)
 {
 	int fd;
@@ -73,17 +85,18 @@ static int child_fn(void *arg)
 {
 	char **args = (char **)arg;
 
-	execvp(args[2], args+2);
+	execvp(args[3], args+3);
 	tst_resm(TINFO | TERRNO, "execvp");
 	return 1;
 }
 
 /*
- * ./ns_exec <NS_PID> <PROGRAM> [ARGS]
+ * ./ns_exec <NS_PID> <ipc,mnt,net,pid,user,uts> <PROGRAM> [ARGS]
  */
 int main(int argc, char *argv[])
 {
 	int i, rv, pid;
+	char *token;
 
 	rv = syscall(__NR_setns, -1, 0);
 	if (rv == -1 && errno == ENOSYS) {
@@ -91,25 +104,28 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	if (argc < 3) {
-		tst_resm(TINFO, "%s <NS_PID> <PROGRAM> [ARGS]\n", argv[0]);
+	if (argc < 4) {
+		print_help();
 		return 1;
 	}
 
-	rv = 0;
 	memset(ns_fd, 0, sizeof(ns_fd));
-	rv |= open_ns_fd(argv[1], "ipc");
-	rv |= open_ns_fd(argv[1], "mnt");
-	rv |= open_ns_fd(argv[1], "net");
-	rv |= open_ns_fd(argv[1], "pid");
-	rv |= open_ns_fd(argv[1], "uts");
-	if (rv != 0)
-		return 1;
+	while ((token = strsep(&argv[2], ","))) {
+		struct param *p = get_param(token);
+
+		if (!p) {
+			tst_resm(TINFO, "Unknown namespace: %s", token);
+			print_help();
+			return 1;
+		}
+
+		if (open_ns_fd(argv[1], token) != 0)
+			return 1;
+	}
 
 	if (ns_fds == 0) {
 		tst_resm(TINFO, "no namespace entries in /proc/%s/ns/",
 			 argv[1]);
-		close_ns_fd();
 		return 1;
 	}
 
diff --git a/testcases/kernel/containers/share/ns_ifmove.c b/testcases/kernel/containers/share/ns_ifmove.c
index 33f8763..f2a1b0f 100644
--- a/testcases/kernel/containers/share/ns_ifmove.c
+++ b/testcases/kernel/containers/share/ns_ifmove.c
@@ -35,7 +35,7 @@
 
 #include "config.h"
 
-char *TCID = "ns_linkset";
+char *TCID = "ns_ifmove";
 
 #if HAVE_DECL_IFLA_NET_NS_PID
 
-- 
2.4.3

