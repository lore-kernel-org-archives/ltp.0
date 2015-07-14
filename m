Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1ZEzF7-00078q-3W
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 12:23:25 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEzF0-0005fU-Dy
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 12:23:25 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 7B71D8E392
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Jul 2015 12:23:12 +0000 (UTC)
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.89.68])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t6ECNA6K003401
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Jul 2015 08:23:11 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Tue, 14 Jul 2015 14:22:51 +0200
Message-Id: <1436876572-28759-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 1/2] added helper tools for creating and working with
	namespaces
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This patch introduces helper tools for creating and working
with namespaces (ltp/testcases/kernel/containers/share):

* ns_create:
    Creates a child process in the new specified namespace(s),
    child is then daemonized and is running in the background.
    PID of the daemonized child process is printed on the stdout.
    As the new namespace(s) is(are) maintained by the daemonized
    child process it(they) can be removed by killing this process.
* ns_exec:
    Enters the namespace(s) of a process specified by a PID and
    then executes the indicated program inside that namespace(s).
* ns_ifmove:
    Moves a network interface to the namespace of a process
    specified by a PID.

Example usage:
==============
$ myns=$(ns_create net,ipc)

$ ip link add veth0 type veth peer name veth1
$ ns_exec $myns ip a
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

$ ns_ifmove veth1 $myns
$ ns_exec $myns ip a
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
6: veth1: <BROADCAST> mtu 1500 qdisc noop state DOWN qlen 1000
    link/ether 6a:0a:45:ed:6e:d0 brd ff:ff:ff:ff:ff:ff

$ ip link del veth0
$ kill -9 $myns
==============

The only requirement from kernel side is the support of "setns"
syscall. There is no need to have util-linux (unshare, nsenter)
installed. This way test cases utilizing namespaces can be
executed even on older kernels which do not provide required
tools for working with namespaces.

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 testcases/kernel/containers/share/.gitignore  |   3 +
 testcases/kernel/containers/share/Makefile    |  22 ++++
 testcases/kernel/containers/share/ns_create.c | 100 ++++++++++++++++
 testcases/kernel/containers/share/ns_exec.c   | 157 ++++++++++++++++++++++++++
 testcases/kernel/containers/share/ns_ifmove.c | 123 ++++++++++++++++++++
 testcases/kernel/containers/share/ns_utils.h  |  42 +++++++
 6 files changed, 447 insertions(+)
 create mode 100644 testcases/kernel/containers/share/.gitignore
 create mode 100644 testcases/kernel/containers/share/Makefile
 create mode 100644 testcases/kernel/containers/share/ns_create.c
 create mode 100644 testcases/kernel/containers/share/ns_exec.c
 create mode 100644 testcases/kernel/containers/share/ns_ifmove.c
 create mode 100644 testcases/kernel/containers/share/ns_utils.h

diff --git a/testcases/kernel/containers/share/.gitignore b/testcases/kernel/containers/share/.gitignore
new file mode 100644
index 0000000..0d5ecf0
--- /dev/null
+++ b/testcases/kernel/containers/share/.gitignore
@@ -0,0 +1,3 @@
+/ns_ifmove
+/ns_create
+/ns_exec
diff --git a/testcases/kernel/containers/share/Makefile b/testcases/kernel/containers/share/Makefile
new file mode 100644
index 0000000..962d688
--- /dev/null
+++ b/testcases/kernel/containers/share/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2015 Red Hat, Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of version 2 the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+##############################################################################
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(abs_srcdir)/../Makefile.inc
+
+LDLIBS                  := -lltp
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/share/ns_create.c b/testcases/kernel/containers/share/ns_create.c
new file mode 100644
index 0000000..8e18fab
--- /dev/null
+++ b/testcases/kernel/containers/share/ns_create.c
@@ -0,0 +1,100 @@
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
+ * Written by Matus Marhefka <mmarhefk@redhat.com>
+ *
+ ***********************************************************************
+ * File: ns_create.c
+ *
+ * Creates a child process in the new specified namespace(s), child is then
+ * daemonized and is running in the background. PID of the daemonized child
+ * process is printed on the stdout. As the new namespace(s) is(are) maintained
+ * by the daemonized child process it(they) can be removed by killing this
+ * process.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include "test.h"
+#include "ns_utils.h"
+
+char *TCID = "ns_create";
+
+
+static int child_fn(void *arg)
+{
+	int i;
+
+	if (chdir("/") == -1) {
+		tst_resm(TINFO | TERRNO, "chdir");
+		exit(1);
+	}
+
+	/* close all inherrited file descriptors */
+	for (i = 0; i < sysconf(_SC_OPEN_MAX); i++)
+		close(i);
+
+	pause();
+	return 0;
+}
+
+/*
+ * ./ns_create <comma separated namespaces list>
+ * where full list is: ipc,mnt,net,pid,user,uts.
+ */
+int main(int argc, char *argv[])
+{
+	int pid, flags;
+
+	if (argc != 2) {
+		tst_resm(TINFO, "%s  <comma separated namespaces list> "
+				"(full list: ipc,mnt,net,pid,user,uts "
+				"-- do not use whitespaces in list)", argv[0]);
+		return 1;
+	}
+
+	flags = 0;
+	if (strstr(argv[1], "ipc") != NULL)
+		flags |= CLONE_NEWIPC;
+	if (strstr(argv[1], "mnt") != NULL)
+		flags |= CLONE_NEWNS;
+	if (strstr(argv[1], "net") != NULL)
+		flags |= CLONE_NEWNET;
+	if (strstr(argv[1], "pid") != NULL)
+		flags |= CLONE_NEWPID;
+	if (strstr(argv[1], "user") != NULL)
+		flags |= CLONE_NEWUSER;
+	if (strstr(argv[1], "uts") != NULL)
+		flags |= CLONE_NEWUTS;
+	if (flags == 0) {
+		tst_resm(TINFO, "unknown namespace: %s", argv[1]);
+		return 1;
+	}
+
+	pid = ltp_clone_quick(flags | SIGCHLD, (void *)child_fn, NULL);
+	if (pid == -1) {
+		tst_resm(TINFO | TERRNO, "ltp_clone_quick");
+		return 1;
+	}
+
+	printf("%d", pid);
+	return 0;
+}
diff --git a/testcases/kernel/containers/share/ns_exec.c b/testcases/kernel/containers/share/ns_exec.c
new file mode 100644
index 0000000..8c350d3
--- /dev/null
+++ b/testcases/kernel/containers/share/ns_exec.c
@@ -0,0 +1,157 @@
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
+ * Written by Matus Marhefka <mmarhefk@redhat.com>
+ *
+ ***********************************************************************
+ * File: ns_exec.c
+ *
+ * Enters the namespace(s) of a process specified by a PID and then executes
+ * the indicated program inside that namespace(s).
+ *
+ */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include "test.h"
+#include "linux_syscall_numbers.h"
+#include "ns_utils.h"
+
+#define PROC_PATH "/proc"
+#define NS_TOTAL 6
+
+char *TCID = "ns_exec";
+int ns_fd[NS_TOTAL];
+int ns_fd_index;
+
+struct argst {
+	char **argv;
+	int argc;
+};
+
+
+static int open_ns_fd(const char *pid, const char *ns)
+{
+	int fd;
+	char file_buf[30];
+
+	sprintf(file_buf, "%s/%s/ns/%s", PROC_PATH, pid, ns);
+
+	fd = open(file_buf, O_RDONLY);
+	if (fd > 0) {
+		ns_fd[ns_fd_index] = fd;
+		++ns_fd_index;
+	} else if (fd == -1 && errno != ENOENT) {
+		tst_resm(TINFO | TERRNO, "open");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void close_ns_fd(void)
+{
+	int i;
+
+	for (i = 0; i < ns_fd_index; i++)
+		close(ns_fd[i]);
+}
+
+static int child_fn(void *arg)
+{
+	struct argst *args = arg;
+	int i;
+
+	for (i = 1; i < args->argc-1; i++)
+		args->argv[i] = args->argv[i+1];
+	args->argv[i] = NULL;
+
+	execvp(args->argv[1], args->argv+1);
+	tst_resm(TINFO | TERRNO, "execvp");
+	return 1;
+}
+
+/*
+ * ./ns_exec <NS_PID> <PROGRAM> [ARGS]
+ */
+int main(int argc, char *argv[])
+{
+	int i, rv, pid;
+	struct argst args;
+
+	rv = syscall(__NR_setns, -1, 0);
+	if (rv == -1 && errno == ENOSYS) {
+		tst_resm(TINFO, "setns is not supported in the kernel");
+		return 1;
+	}
+
+	if (argc < 3) {
+		tst_resm(TINFO, "%s <NS_PID> <PROGRAM> [ARGS]\n", argv[0]);
+		return 1;
+	}
+
+	rv = 0;
+	memset(ns_fd, 0, sizeof(ns_fd));
+	rv |= open_ns_fd(argv[1], "ipc");
+	rv |= open_ns_fd(argv[1], "mnt");
+	rv |= open_ns_fd(argv[1], "net");
+	rv |= open_ns_fd(argv[1], "pid");
+	rv |= open_ns_fd(argv[1], "user");
+	rv |= open_ns_fd(argv[1], "uts");
+	if (rv != 0)
+		return 1;
+
+	if (ns_fd_index == 0) {
+		tst_resm(TINFO, "no namespace entries in /proc/%s/ns/",
+			 argv[1]);
+		close_ns_fd();
+		return 1;
+	}
+
+	for (i = 0; i < ns_fd_index; i++) {
+		if (syscall(__NR_setns, ns_fd[i], 0) == -1) {
+			tst_resm(TINFO | TERRNO, "setns");
+			close_ns_fd();
+			return 1;
+		}
+	}
+
+	args.argv = argv;
+	args.argc = argc;
+	pid = ltp_clone_quick(SIGCHLD, (void *)child_fn, (void *)&args);
+	if (pid == -1) {
+		tst_resm(TINFO | TERRNO, "ltp_clone_quick");
+		close_ns_fd();
+		return 1;
+	}
+
+	if (waitpid(pid, &rv, 0) == -1) {
+		tst_resm(TINFO | TERRNO, "waitpid");
+		return 1;
+	}
+
+	close_ns_fd();
+
+	if (WIFEXITED(rv))
+		return WEXITSTATUS(rv);
+
+	return 0;
+}
diff --git a/testcases/kernel/containers/share/ns_ifmove.c b/testcases/kernel/containers/share/ns_ifmove.c
new file mode 100644
index 0000000..728863b
--- /dev/null
+++ b/testcases/kernel/containers/share/ns_ifmove.c
@@ -0,0 +1,123 @@
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
+ * Written by Matus Marhefka <mmarhefk@redhat.com>
+ *
+ ***********************************************************************
+ * File: ns_ifmove.c
+ *
+ * Moves a network interface to the namespace of a process specified by a PID.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <asm/types.h>
+#include <sys/socket.h>
+#include <linux/rtnetlink.h>
+#include <sys/ioctl.h>
+#include <linux/if.h>
+#include <net/ethernet.h>
+#include <arpa/inet.h>
+#include "test.h"
+
+char *TCID = "ns_linkset";
+
+struct {
+	struct nlmsghdr nh;
+	struct ifinfomsg ifi;
+	char attrbuf[512];
+} req;
+
+
+int get_intf_index_from_name(const char *intf_name)
+{
+	struct ifreq ifr;
+	int sock_fd;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, intf_name, sizeof(ifr.ifr_name) - 1);
+	ifr.ifr_name[sizeof(ifr.ifr_name)-1] = '\0';
+
+	sock_fd = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	if (sock_fd == -1) {
+		tst_resm(TINFO | TERRNO, "socket");
+		return -1;
+	}
+
+	/* gets interface index */
+	if (ioctl(sock_fd, SIOCGIFINDEX, &ifr) == -1) {
+		close(sock_fd);
+		tst_resm(TINFO | TERRNO, "ioctl");
+		return -1;
+	}
+
+	close(sock_fd);
+	return ifr.ifr_ifindex;
+}
+
+/*
+ * ./ns_ifmove <INTERFACE_NAME> <NAMESPACE_PID>
+ */
+int main(int argc, char **argv)
+{
+	struct rtattr *rta;
+	int intf_index, pid, rtnetlink_socket;
+
+	if (argc != 3) {
+		tst_resm(TINFO, "%s <INTERFACE_NAME> <NAMESPACE_PID>\n",
+			 argv[0]);
+		return 1;
+	}
+
+	intf_index = get_intf_index_from_name(argv[1]);
+	if (intf_index == -1) {
+		tst_resm(TINFO , "unable to get interface index");
+		return 1;
+	}
+
+	pid = atoi(argv[2]);
+
+	rtnetlink_socket = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
+	if (rtnetlink_socket == -1) {
+		tst_resm(TINFO | TERRNO, "socket");
+		return 1;
+	}
+
+	memset(&req, 0, sizeof(req));
+	req.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req.nh.nlmsg_flags = NLM_F_REQUEST;
+	req.nh.nlmsg_type = RTM_NEWLINK;
+	req.ifi.ifi_family = AF_UNSPEC;
+	req.ifi.ifi_index = intf_index;
+	req.ifi.ifi_change = 0xffffffff;
+	rta = (struct rtattr *)(((char *) &req) +
+		NLMSG_ALIGN(req.nh.nlmsg_len));
+	rta->rta_type = IFLA_NET_NS_PID;
+	rta->rta_len = RTA_LENGTH(sizeof(int));
+	req.nh.nlmsg_len = NLMSG_ALIGN(req.nh.nlmsg_len) +
+		RTA_LENGTH(sizeof(pid));
+	memcpy(RTA_DATA(rta), &pid, sizeof(pid));
+
+	if (send(rtnetlink_socket, &req, req.nh.nlmsg_len, 0) == -1) {
+		tst_resm(TINFO | TERRNO, "send");
+		return 1;
+	}
+
+	close(rtnetlink_socket);
+	return 0;
+}
diff --git a/testcases/kernel/containers/share/ns_utils.h b/testcases/kernel/containers/share/ns_utils.h
new file mode 100644
index 0000000..fe11a6b
--- /dev/null
+++ b/testcases/kernel/containers/share/ns_utils.h
@@ -0,0 +1,42 @@
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
+ ***********************************************************************
+ * File: ns_utils.h
+ *
+ */
+
+#ifndef NS_UTILS_H
+#define NS_UTILS_H
+
+#ifndef CLONE_NEWIPC
+#  define CLONE_NEWIPC	0x08000000
+#endif
+#ifndef CLONE_NEWNS
+#  define CLONE_NEWNS	0x00020000
+#endif
+#ifndef CLONE_NEWNET
+#  define CLONE_NEWNET	0x40000000
+#endif
+#ifndef CLONE_NEWPID
+#  define CLONE_NEWPID	0x20000000
+#endif
+#ifndef CLONE_NEWUSER
+#  define CLONE_NEWUSER	0x10000000
+#endif
+#ifndef CLONE_NEWUTS
+#  define CLONE_NEWUTS	0x04000000
+#endif
+
+
+#endif
-- 
1.8.3.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
