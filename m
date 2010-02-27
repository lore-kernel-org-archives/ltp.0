Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naufal11@gmail.com>) id 1NlMSI-00086u-Dd
	for ltp-list@lists.sourceforge.net; Sat, 27 Feb 2010 13:11:38 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NlMSE-0002j2-Nc
	for ltp-list@lists.sourceforge.net; Sat, 27 Feb 2010 13:11:38 +0000
Received: by pvf33 with SMTP id 33so299312pvf.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 27 Feb 2010 05:11:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002261213q24890454jac60233bd8f92ded@mail.gmail.com>
References: <d270b4400912250122y371c4d4dq6fa729b60e03f8a5@mail.gmail.com>
	<20100111162256.GB19010@saboteur.suse.cz>
	<20100128041619.GB16209@malik-laptop.in.ibm.com>
	<d270b4401002202353pec0431w4a2bb947544ff444@mail.gmail.com>
	<364299f41002261213q24890454jac60233bd8f92ded@mail.gmail.com>
Date: Sat, 27 Feb 2010 18:35:26 +0530
Message-ID: <d270b4401002270505n59e448eev69b6f7b263ecd61d@mail.gmail.com>
From: Mohamed Naufal <naufal11@gmail.com>
Subject: Re: [LTP] Testcase to validate the memory usage limit imposed by
	the topmost memory cgroup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

On 27 February 2010 01:43, Garrett Cooper <yanegomi@gmail.com> wrote:


[...]


Thank you for your comments. Here is the updated patch.

<patch>
diff -Naru ltpv/runtest/controllers ltpd/runtest/controllers
--- ltpv/runtest/controllers=A0=A0 =A02010-02-20 15:42:13.000000000 +0530
+++ ltpd/runtest/controllers=A0=A0 =A02010-02-27 17:51:10.358553399 +0530
@@ -3,5 +3,6 @@
=A0memcg_regression=A0=A0 =A0memcg_regression_test.sh
=A0memcg_function=A0=A0 =A0=A0=A0 =A0memcg_function_test.sh
=A0memcg_stress=A0=A0 =A0=A0=A0 =A0memcg_stress_test.sh
+memcg_control=A0=A0=A0=A0=A0=A0=A0=A0=A0 PAGESIZE=3D$(mem_process
-p);memcg_control_test.sh $PAGESIZE $PAGESIZE $((PAGESIZE * 2))
=A0cgroup_fj=A0=A0 =A0run_cgroup_test_fj.sh
=A0controllers=A0=A0 =A0test_controllers.sh
diff -Naru ltpv/testcases/kernel/controllers/memcg/control/Makefile
ltpd/testcases/kernel/controllers/memcg/control/Makefile
--- ltpv/testcases/kernel/controllers/memcg/control/Makefile
1970-01-01 05:30:00.000000000 +0530
+++ ltpd/testcases/kernel/controllers/memcg/control/Makefile
2010-02-27 17:51:10.359555806 +0530
@@ -0,0 +1,33 @@
+#
+#=A0=A0=A0 kernel/controllers/memcg/stress testcase suite Makefile.
+#
+#=A0=A0=A0 Copyright (C) 2009, Cisco Systems Inc.
+#
+#=A0=A0=A0 This program is free software; you can redistribute it and/or m=
odify
+#=A0=A0=A0 it under the terms of the GNU General Public License as publish=
ed by
+#=A0=A0=A0 the Free Software Foundation; either version 2 of the License, =
or
+#=A0=A0=A0 (at your option) any later version.
+#
+#=A0=A0=A0 This program is distributed in the hope that it will be useful,
+#=A0=A0=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of
+#=A0=A0=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See the
+#=A0=A0=A0 GNU General Public License for more details.
+#
+#=A0=A0=A0 You should have received a copy of the GNU General Public Licen=
se along
+#=A0=A0=A0 with this program; if not, write to the Free Software Foundatio=
n, Inc.,
+#=A0=A0=A0 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, September 2009
+#
+
+top_srcdir=A0=A0 =A0=A0=A0 =A0?=3D ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CPPFLAGS=A0=A0 =A0=A0=A0 =A0+=3D -I$(abs_srcdir)/../../libcontrollers
+
+INSTALL_TARGETS=A0=A0 =A0=A0=A0 =A0:=3D *.sh
+
+LDLIBS=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0+=3D -lm
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff -Naru ltpv/testcases/kernel/controllers/memcg/control/memcg_control_te=
st.sh
ltpd/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
--- ltpv/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
=A0 =A01970-01-01 05:30:00.000000000 +0530
+++ ltpd/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
=A0 =A02010-02-27 18:17:08.668300711 +0530
@@ -0,0 +1,166 @@
+#!/bin/sh
+
+##########################################################################=
######
+##
=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 Copyright (c) 2010 Mohamed Naufal Basheer
=A0=A0=A0=A0=A0=A0=A0 ##
+##
=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 This program is free software;=A0 you can redistribute it and/or
modify=A0=A0=A0 ##
+##=A0=A0 it under the terms of the GNU General Public License as
published by=A0=A0=A0=A0 ##
+##=A0=A0 the Free Software Foundation; either version 2 of the License,
or=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 (at your option) any later version.
=A0=A0=A0=A0=A0=A0=A0 ##
+##
=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 This program is distributed in the hope that it will be useful,
=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 but WITHOUT ANY WARRANTY;=A0 without even the implied warranty of
=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See
=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 the GNU General Public License for more details.
=A0=A0=A0=A0=A0=A0=A0 ##
+##
=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 You should have received a copy of the GNU General Public
License=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 along with this program;=A0 if not, write to the Free Software
=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307 USA=A0 ##
+##
=A0=A0=A0=A0=A0=A0=A0 ##
+##
=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 File:=A0=A0=A0 memcg_control_test.sh
=A0=A0=A0=A0=A0=A0=A0 ##
+##
=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 Purpose: Implement various memory controller tests
=A0=A0=A0=A0=A0=A0=A0 ##
+##
=A0=A0=A0=A0=A0=A0=A0 ##
+##=A0=A0 Author:=A0 Mohamed Naufal Basheer <naufal11@gmail.com>
=A0=A0=A0=A0=A0=A0=A0 ##
+##
=A0=A0=A0=A0=A0=A0=A0 ##
+##########################################################################=
######
+
+if [ "$(grep -w memory /proc/cgroups | cut -f4)" -ne "1" ]; then
+=A0=A0 =A0echo "WARNING:"
+=A0=A0 =A0echo "Either kernel does not support memory resource controller
or feature not enabled"
+=A0=A0 =A0echo "Skipping all memcg_control testcases...."
+=A0=A0 =A0exit 0
+fi
+
+export TCID=3D"memcg_control"
+export TST_TOTAL=3D1
+export TST_COUNT=3D0
+
+export TMP=3D${TMP:-/tmp}
+cd $TMP
+
+TOT_MEM_LIMIT=3D$1
+ACTIVE_MEM_LIMIT=3D$2
+PROC_MEM=3D$3
+
+TST_PATH=3D$PWD
+STATUS_PIPE=3D"$TMP/status_pipe"
+
+PASS=3D0
+FAIL=3D1
+
+# Check if the test process is killed on crossing boundary
+test_proc_kill()
+{
+=A0=A0 =A0pushd $TMP > /dev/null
+=A0=A0 =A0mem_process -m $PROC_MEM &
+=A0=A0 =A0popd > /dev/null
+=A0=A0 =A0sleep 1
+=A0=A0 =A0echo $! > tasks
+
+=A0=A0 =A0#Instruct the test process to start acquiring memory
+=A0=A0 =A0echo m > $STATUS_PIPE
+=A0=A0 =A0sleep 5
+
+=A0=A0 =A0#Check if killed
+=A0=A0 =A0ps -p $! > /dev/null 2> /dev/null
+=A0=A0 =A0if [ $? -eq 0 ]; then
+=A0=A0 =A0=A0=A0 =A0echo m > $STATUS_PIPE
+=A0=A0 =A0=A0=A0 =A0echo x > $STATUS_PIPE
+=A0=A0 =A0else
+=A0=A0 =A0=A0=A0 =A0: $((KILLED_CNT +=3D 1))
+=A0=A0 =A0fi
+}
+
+# Validate the memory usage limit imposed by the hierarchically topmost gr=
oup
+testcase_1()
+{
+=A0=A0 =A0TST_COUNT=3D1
+=A0=A0 =A0tst_resm TINFO "Test #1: Checking if the memory usage limit
imposed by the topmost group is enforced"
+
+=A0=A0 =A0echo "$ACTIVE_MEM_LIMIT" > $TST_PATH/mnt/$TST_NUM/memory.limit_i=
n_bytes
+=A0=A0 =A0echo "$TOT_MEM_LIMIT" > $TST_PATH/mnt/$TST_NUM/memory.memsw.limi=
t_in_bytes
+
+=A0=A0 =A0mkdir sub
+=A0=A0 =A0pushd sub > /dev/null
+
+=A0=A0 =A0KILLED_CNT=3D0
+=A0=A0 =A0test_proc_kill
+
+=A0=A0 =A0if [ $PROC_MEM -gt $TOT_MEM_LIMIT ] && [ $KILLED_CNT -eq 0 ]; th=
en
+=A0=A0 =A0=A0=A0 =A0result $FAIL "Test #1: failed"
+=A0=A0 =A0else
+=A0=A0 =A0=A0=A0 =A0result $PASS "Test #1: passed"
+=A0=A0 =A0fi
+
+=A0=A0 =A0popd > /dev/null
+=A0=A0 =A0rmdir sub
+}
+
+# Record the test results
+#
+# $1: Result of the test case, $PASS or $FAIL
+# $2: Output information
+result()
+{
+=A0=A0 =A0RES=3D$1
+=A0=A0 =A0INFO=3D$2
+
+=A0=A0 =A0if [ $RES -eq $PASS ]; then
+=A0=A0 =A0=A0=A0 =A0tst_resm TPASS "$INFO"
+=A0=A0 =A0else
+=A0=A0 =A0=A0=A0 =A0: $((FAILED_CNT +=3D 1))
+=A0=A0 =A0=A0=A0 =A0tst_resm TFAIL "$INFO"
+=A0=A0 =A0fi
+}
+
+cleanup()
+{
+=A0=A0 =A0if [ -e $TST_PATH/mnt ]; then
+=A0=A0 =A0=A0=A0 =A0umount $TST_PATH/mnt 2> /dev/null
+=A0=A0 =A0=A0=A0 =A0rm -rf $TST_PATH/mnt
+=A0=A0 =A0fi
+}
+
+do_mount()
+{
+=A0=A0 =A0cleanup
+
+=A0=A0 =A0mkdir $TST_PATH/mnt
+=A0=A0 =A0mount -t cgroup -o memory cgroup $TST_PATH/mnt 2> /dev/null
+=A0=A0 =A0if [ $? -ne 0 ]; then
+=A0=A0 =A0=A0=A0 =A0tst_brkm TBROK NULL "Mounting cgroup to temp dir faile=
d"
+=A0=A0 =A0=A0=A0 =A0rmdir $TST_PATH/mnt
+=A0=A0 =A0=A0=A0 =A0exit 1
+=A0=A0 =A0fi
+}
+
+do_mount
+
+echo 1 > mnt/memory.use_hierarchy 2> /dev/null
+
+FAILED_CNT=3D0
+
+TST_NUM=3D1
+while [ $TST_NUM -le $TST_TOTAL ]; do
+=A0=A0 =A0mkdir $TST_PATH/mnt/$TST_NUM
+=A0=A0 =A0pushd $TST_PATH/mnt/$TST_NUM > /dev/null
+
+=A0=A0 =A0testcase_$TST_NUM;
+
+=A0=A0 =A0popd > /dev/null
+=A0=A0 =A0rmdir $TST_PATH/mnt/$TST_NUM
+=A0=A0 =A0: $((TST_NUM +=3D 1))
+done
+
+cleanup
+
+if [ "$FAILED_CNT" -ne 0 ]; then
+=A0=A0 =A0tst_resm TFAIL "memcg_control: failed"
+=A0=A0 =A0exit 1
+else
+=A0=A0 =A0tst_resm TPASS "memcg_control: passed"
+=A0=A0 =A0exit 0
+fi
diff -Naru ltpv/testcases/kernel/controllers/memcg/control/mem_process.c
ltpd/testcases/kernel/controllers/memcg/control/mem_process.c
--- ltpv/testcases/kernel/controllers/memcg/control/mem_process.c
1970-01-01 05:30:00.000000000 +0530
+++ ltpd/testcases/kernel/controllers/memcg/control/mem_process.c
2010-02-27 18:22:43.246178794 +0530
@@ -0,0 +1,141 @@
+/*************************************************************************=
******/
+/*
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 Copyright (c) 2010 Mohamed Naufal Basheer
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 This program is free software;=A0 you can redistribute it and/or
modify=A0=A0=A0=A0=A0 */
+/*=A0 it under the terms of the GNU General Public License as published
by=A0=A0=A0=A0=A0=A0 */
+/*=A0 the Free Software Foundation; either version 2 of the License, or
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 (at your option) any later version.
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 This program is distributed in the hope that it will be useful,
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 but WITHOUT ANY WARRANTY;=A0 without even the implied warranty of
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 the GNU General Public License for more details.
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 You should have received a copy of the GNU General Public License
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 along with this program;=A0 if not, write to the Free Software
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307 USA=A0=A0=A0 */
+/*
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 File:=A0=A0=A0 mem_process.c
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 Purpose: act as a memory hog for the memcg_control tests
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*=A0 Author:=A0 Mohamed Naufal Basheer <naufal11@gmail.com >
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*
=A0=A0=A0=A0=A0=A0=A0=A0 */
+/*************************************************************************=
******/
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+/*
+ * Named pipe to act as a communication channel between
+ * shell script & this process
+ */
+#define STATUS_PIPE "status_pipe"
+
+int flag_exit;
+int flag_allocated;
+unsigned long memsize;
+
+/*
+ * process_options: process user specified options
+ */
+void process_options(int argc, char **argv)
+{
+=A0=A0 =A0int c;
+=A0=A0 =A0char *end;
+
+=A0=A0 =A0opterr =3D 0;
+=A0=A0 =A0while ((c =3D getopt(argc, argv, "pm:")) !=3D -1) {
+=A0=A0 =A0=A0=A0 =A0switch(c) {
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0case 'p':
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0printf("%d\n",getpagesize());
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0exit(0);
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0case 'm':
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0memsize =3D strtoul(optarg, &end, =
10);
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0if (*end)
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0errx(2, "Invalid -m usag=
e");
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0break;
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0default:
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0errx(2, "Invalid option specifed");
+=A0=A0=A0=A0=A0=A0=A0 =A0=A0 =A0}
+=A0=A0=A0 =A0=A0 =A0}
+
+=A0=A0 =A0if(memsize <=3D 0)
+=A0=A0 =A0=A0=A0 =A0errx(3, "Invalid usage");
+}
+
+/*
+ * touch_memory: force physical memory allocation
+ */
+void touch_memory(char *p)
+{
+=A0=A0 =A0int i;
+=A0=A0 =A0int pagesize =3D getpagesize();
+
+=A0=A0 =A0for (i =3D 0; i < memsize; i +=3D pagesize)
+=A0=A0 =A0=A0=A0 =A0p[i] =3D 0xef;
+}
+
+void mem_map()
+{
+=A0=A0 =A0static char *p;
+
+=A0=A0 =A0if (!flag_allocated) {
+=A0=A0 =A0=A0=A0 =A0p =3D mmap(NULL, memsize, PROT_READ | PROT_WRITE, MAP_=
SHARED |
MAP_ANONYMOUS, 0, 0);
+=A0=A0 =A0=A0=A0 =A0if(p =3D=3D MAP_FAILED)
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0errx(4, "mmap failed");
+=A0=A0 =A0=A0=A0 =A0touch_memory(p);
+=A0=A0 =A0}else {
+=A0=A0 =A0=A0=A0 =A0if (munmap(p, memsize) =3D=3D -1)
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0errx(5, "munmap failed");
+=A0=A0 =A0}
+=A0=A0 =A0flag_allocated ^=3D 1;
+}
+
+/*
+ * done: retrieve instructions from the named pipe
+ */
+char action()
+{
+=A0=A0 =A0char ch;
+=A0=A0 =A0int fd;
+
+=A0=A0 =A0fd =3D open(STATUS_PIPE, O_RDONLY);
+=A0=A0 =A0if (fd < 0)
+=A0=A0 =A0=A0=A0 =A0errx(6, "Error opening named pipe");
+
+=A0=A0 =A0if (read(fd, &ch, 1) < 0)
+=A0=A0 =A0=A0=A0 =A0errx(7, "Error reading named pipe");
+
+=A0=A0 =A0close(fd);
+
+=A0=A0 =A0return ch;
+}
+
+int main(int argc, char **argv)
+{
+=A0=A0 =A0int ret;
+=A0=A0 =A0char ch;
+
+=A0=A0 =A0process_options(argc, argv);
+
+=A0=A0 =A0ret =3D mkfifo(STATUS_PIPE, 0666);
+
+=A0=A0 =A0if (ret =3D=3D -1 && errno !=3D EEXIST)
+=A0=A0 =A0=A0=A0 =A0errx(1, "Error creating named pipe");
+
+=A0=A0 =A0do {
+=A0=A0 =A0=A0=A0 =A0ch =3D action();
+
+=A0=A0 =A0=A0=A0 =A0if (ch =3D=3D 'm')
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0mem_map();
+=A0=A0 =A0}while(ch !=3D 'x');
+
+=A0=A0 =A0remove(STATUS_PIPE);
+
+=A0=A0 =A0return 0;
+}
diff -Naru ltpv/testcases/kernel/controllers/memcg/README
ltpd/testcases/kernel/controllers/memcg/README
--- ltpv/testcases/kernel/controllers/memcg/README=A0=A0 =A02010-02-20
15:42:13.000000000 +0530
+++ ltpd/testcases/kernel/controllers/memcg/README=A0=A0 =A02010-02-27
17:51:10.361554968 +0530
@@ -15,6 +15,16 @@

=A0FILES DESCRIPTION:

+control/memcg_control_test.sh
+--------------------
+This script runs the testcases of control test.
+
+control/mem_process.c
+--------------------
+The program allocates memory specified using the '-m' option when 'm'
is received
+through the named pipe "status_pipe" and frees it on receiving 'm' again.
+It exits on receiving 'x'. It gets the page size on specifying the '-p' op=
tion.
+
=A0functional/memcgroup_function_test.sh
=A0--------------------
=A0This script runs all the 38 testcases of basis operation.
</patch>

Naufal

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
