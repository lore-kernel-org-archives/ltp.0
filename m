Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1RnndH-0003DL-E8
	for ltp-list@lists.sourceforge.net; Thu, 19 Jan 2012 08:46:07 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RnndA-0001bI-CK
	for ltp-list@lists.sourceforge.net; Thu, 19 Jan 2012 08:46:07 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id EE00417013C
	for <ltp-list@lists.sourceforge.net>;
	Thu, 19 Jan 2012 16:45:54 +0800 (CST)
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q0J8jrpw007360
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Jan 2012 16:45:53 +0800
Message-ID: <4F17D842.5060903@cn.fujitsu.com>
Date: Thu, 19 Jan 2012 16:45:54 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F17D4D0.9090200@cn.fujitsu.com>
In-Reply-To: <4F17D4D0.9090200@cn.fujitsu.com>
Content-Type: multipart/mixed; boundary="------------050205040209060005020509"
Subject: Re: [LTP] [PATCH v3 1/8] A library used to test memcg
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--------------050205040209060005020509
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8


Sorry for forgetting attached the patch.

-- 
Best Regards,
Peng


Peng Haitao said the following on 2012-1-19 16:31:
> 
> This library includes a set of functions used to test memcg.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  .../controllers/memcg/functional/memcg_lib.sh      |  412 ++++++++++++++++++++
>  1 files changed, 412 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> 
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> new file mode 100644
> index 0000000..6af1cc2
> --- /dev/null
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -0,0 +1,412 @@
> +#! /bin/sh
> +
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) 2012 FUJITSU LIMITED                                         ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +## Author: Peng Haitao <penght@cn.fujitsu.com>                                ##
> +##                                                                            ##
> +################################################################################
> +
> +if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
> +        echo "WARNING:";
> +        echo "Either Kernel does not support for memory resource controller or feature not enabled";
> +        echo "Skipping all memcgroup testcases....";
> +        exit 0
> +fi
> +
> +cd $LTPROOT/testcases/bin
> +
> +TEST_PATH=$PWD
> +PAGESIZE=`./memcg_getpagesize`
> +HUGEPAGESIZE=`grep Hugepagesize /proc/meminfo | awk '{ print $2 }'`
> +[ -z $HUGEPAGESIZE ] && HUGEPAGESIZE=0
> +HUGEPAGESIZE=$(( $HUGEPAGESIZE * 1024 ))
> +PASS=0
> +FAIL=1
> +
> +cur_id=0
> +failed=0
> +
> +# Record the test result of a test case
> +# $1 - The result of the test case, $PASS or $FAIL
> +# $2 - The output information
> +result()
> +{
> +	local pass=$1
> +	local info="$2"
> +
> +	if [ $pass -eq $PASS ]; then
> +		tst_resm TPASS "$info"
> +	else
> +		tst_resm TFAIL "$info"
> +		: $(( failed += 1 ))
> +	fi
> +}
> +
> +# Check size in memcg
> +# $1 - Item name
> +# $2 - Expected size
> +check_mem_stat()
> +{
> +	if [ -e $1 ]; then
> +		item_size=`cat $1`
> +	else
> +		item_size=`grep -w $1 memory.stat | cut -d " " -f 2`
> +	fi
> +
> +	if [ "$2" = "$item_size" ]; then
> +		pass=$PASS
> +	else
> +		pass=$FAIL
> +	fi
> +
> +	result $pass "$1=$item_size/$2"
> +}
> +
> +warmup()
> +{
> +	pid=$1
> +
> +	echo "Warming up for test: $cur_id, pid: $pid"
> +	kill -s USR1 $pid 2> /dev/null
> +	sleep 1
> +	kill -s USR1 $pid 2> /dev/null
> +	sleep 1
> +
> +	kill -0 $pid
> +	if [ $? -ne 0 ]; then
> +		result $FAIL "cur_id=$cur_id"
> +		return 1
> +	else
> +		echo "Process is still here after warm up: $pid"
> +	fi
> +
> +	return 0
> +}
> +
> +# Run test cases which checks memory.stat after make
> +# some memory allocation
> +# $1 - the parameters of 'process', such as --shm
> +# $2 - the -s parameter of 'process', such as 4096
> +# $3 - item name in memory.stat
> +# $4 - the expected size
> +# $5 - check after free ?
> +test_mem_stat()
> +{
> +	echo "Running $TEST_PATH/memcg_process $1 -s $2"
> +	$TEST_PATH/memcg_process $1 -s $2 &
> +	sleep 1
> +
> +	warmup $!
> +	if [ $? -ne 0 ]; then
> +		return
> +	fi
> +
> +	echo $! > tasks
> +	kill -s USR1 $! 2> /dev/null
> +	sleep 1
> +
> +	check_mem_stat $3 $4
> +
> +	kill -s USR1 $! 2> /dev/null
> +	sleep 1
> +	if [ $5 -eq 1 ]; then
> +		check_mem_stat $3 0
> +	fi
> +
> +	kill -s INT $! 2> /dev/null
> +}
> +
> +# Run test cases which checks memory.max_usage_in_bytes after make
> +# some memory allocation
> +# $1 - the parameters of 'process', such as --shm
> +# $2 - the -s parameter of 'process', such as 4096
> +# $3 - item name
> +# $4 - the expected size
> +# $5 - check after free ?
> +test_max_usage_in_bytes()
> +{
> +	echo "Running $TEST_PATH/memcg_process $1 -s $2"
> +	$TEST_PATH/memcg_process $1 -s $2 &
> +	sleep 1
> +
> +	warmup $!
> +	if [ $? -ne 0 ]; then
> +		return
> +	fi
> +
> +	echo $! > tasks
> +	kill -s USR1 $! 2> /dev/null
> +	sleep 1
> +
> +	kill -s USR1 $! 2> /dev/null
> +	sleep 1
> +
> +	check_mem_stat $3 $4
> +
> +	if [ $5 -eq 1 ]; then
> +		echo 0 > $3
> +		check_mem_stat $3 0
> +	fi
> +
> +	kill -s INT $! 2> /dev/null
> +}
> +
> +# make some memory allocation
> +# $1 - the parameters of 'process', such as --shm
> +# $2 - the -s parameter of 'process', such as 4096
> +malloc_free_memory()
> +{
> +	echo "Running $TEST_PATH/memcg_process $1 -s $2"
> +	$TEST_PATH/memcg_process $1 -s $2 &
> +	sleep 1
> +
> +	echo $! > tasks
> +	kill -s USR1 $! 2> /dev/null
> +	sleep 1
> +
> +	kill -s USR1 $! 2> /dev/null
> +	sleep 1
> +
> +	kill -s INT $! 2> /dev/null
> +}
> +
> +# Test if failcnt > 0, which means page reclamation occured
> +# $1 - item name in memcg
> +test_failcnt()
> +{
> +	failcnt=`cat $1`
> +	if [ $failcnt -gt 0 ]; then
> +		pass=$PASS
> +	else
> +		pass=$FAIL
> +	fi
> +
> +	result $pass "$1=$failcnt"
> +}
> +
> +# Test process will be killed due to exceed memory limit
> +# $1 - the value of memory.limit_in_bytes
> +# $2 - the parameters of 'process', such as --shm
> +# $3 - the -s parameter of 'process', such as 4096
> +# $4 - use mem+swap limitation
> +test_proc_kill()
> +{
> +	echo $1 > memory.limit_in_bytes
> +	if [ $4 -eq 1 ]; then
> +		if [ -e memory.memsw.limit_in_bytes ]; then
> +			echo $1 > memory.memsw.limit_in_bytes
> +		else
> +			tst_resm TCONF "mem+swap is not enabled"
> +			return
> +		fi
> +	fi
> +
> +	$TEST_PATH/memcg_process $2 -s $3 &
> +	pid=$!
> +	sleep 1
> +	echo $pid > tasks
> +
> +	kill -s USR1 $pid 2> /dev/null
> +	sleep 1
> +
> +	ps -p $pid > /dev/null 2> /dev/null
> +	if [ $? -ne 0 ]; then
> +		wait $pid
> +		if [ $? -eq 1 ]; then
> +			result $FAIL "process $pid is killed by error"
> +		else
> +			result $PASS "process $pid is killed"
> +		fi
> +	else
> +		kill -s INT $pid 2> /dev/null
> +		result $FAIL "process $pid is not killed"
> +	fi
> +}
> +
> +# Test limit_in_bytes will be aligned to PAGESIZE
> +# $1 - user input value
> +# $2 - expected value
> +# $3 - use mem+swap limitation
> +test_limit_in_bytes()
> +{
> +	echo $1 > memory.limit_in_bytes
> +	if [ $3 -eq 1 ]; then
> +		if [ -e memory.memsw.limit_in_bytes ]; then
> +			echo $1 > memory.memsw.limit_in_bytes
> +			limit=`cat memory.memsw.limit_in_bytes`
> +		else
> +			tst_resm TCONF "mem+swap is not enabled"
> +			return
> +		fi
> +	else
> +		limit=`cat memory.limit_in_bytes`
> +	fi
> +
> +	if [ $limit -eq $2 ]; then
> +		result $PASS "input=$1, limit_in_bytes=$limit"
> +	else
> +		result $FAIL "input=$1, limit_in_bytes=$limit"
> +	fi
> +}
> +
> +# Test memory controller doesn't charge hugepage
> +# $1 - the value of /proc/sys/vm/nr_hugepages
> +# $2 - the parameters of 'process', --mmap-file or --shm
> +# $3 - the -s parameter of 'process', such as $HUGEPAGESIZE
> +# $4 - 0: expected failure, 1: expected success
> +test_hugepage()
> +{
> +	TMP_FILE=$TEST_PATH/tmp
> +	nr_hugepages=`cat /proc/sys/vm/nr_hugepages`
> +
> +	mkdir /hugetlb
> +	mount -t hugetlbfs none /hugetlb
> +
> +	echo $1 > /proc/sys/vm/nr_hugepages
> +
> +	$TEST_PATH/memcg_process $2 --hugepage -s $3 > $TMP_FILE 2>&1 &
> +	sleep 1
> +
> +	kill -s USR1 $! 2> /dev/null
> +	sleep 1
> +
> +	check_mem_stat "rss" 0
> +
> +	echo "TMP_FILE:"
> +	cat $TMP_FILE
> +
> +	if [ $4 -eq 0 ]; then
> +		test -s $TMP_FILE
> +		if [ $? -eq 0 ]; then
> +			result $PASS "allocate hugepage failed as expected"
> +		else
> +			kill -s USR1 $! 2> /dev/null
> +			kill -s INT $! 2> /dev/null
> +			result $FAIL "allocate hugepage shoud fail"
> +		fi
> +	else
> +		test ! -s $TMP_FILE
> +		if [ $? -eq 0 ]; then
> +			kill -s USR1 $! 2> /dev/null
> +			kill -s INT $! 2> /dev/null
> +			result $PASS "allocate hugepage succeeded"
> +		else
> +			result $FAIL "allocate hugepage failed"
> +		fi
> +	fi
> +
> +	sleep 1
> +	rm -rf $TMP_FILE
> +	umount /hugetlb
> +	rmdir /hugetlb
> +	echo $nr_hugepages > /proc/sys/vm/nr_hugepages
> +}
> +
> +# Test the memory charge won't move to subgroup
> +# $1 - memory.limit_in_bytes in parent group
> +# $2 - memory.limit_in_bytes in sub group
> +test_subgroup()
> +{
> +	mkdir subgroup
> +	echo $1 > memory.limit_in_bytes
> +	echo $2 > subgroup/memory.limit_in_bytes
> +
> +	echo "Running $TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE"
> +	$TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE &
> +	sleep 1
> +
> +	warmup $!
> +	if [ $? -ne 0 ]; then
> +		return
> +	fi
> +
> +	echo $! > tasks
> +	kill -s USR1 $! 2> /dev/null
> +	sleep 1
> +	check_mem_stat "rss" $PAGESIZE
> +
> +	cd subgroup
> +	echo $! > tasks
> +	check_mem_stat "rss" 0
> +
> +	# cleanup
> +	cd ..
> +	echo $! > tasks
> +	kill -s INT $! 2> /dev/null
> +	sleep 1
> +	rmdir subgroup
> +}
> +
> +# Run test cases which test memory.move_charge_at_immigrate 
> +# $1 - the parameters of 'process', such as --shm
> +# $2 - the -s parameter of 'process', such as 4096
> +# $3 - some positive value, such as 1
> +# $4 - the expected size
> +# $5 - the expected size
> +test_move_charge()
> +{
> +	mkdir subgroup_a
> +
> +	$TEST_PATH/memcg_process $1 -s $2 &
> +	sleep 1
> +	warmup $!
> +	if [ $? -ne 0 ]; then
> +		rmdir subgroup_a
> +		return
> +	fi
> +
> +	echo $! > subgroup_a/tasks
> +	kill -s USR1 $!
> +	sleep 1
> +
> +	mkdir subgroup_b
> +	echo $3 > subgroup_b/memory.move_charge_at_immigrate
> +	echo $! > subgroup_b/tasks
> +
> +	cd subgroup_b
> +	check_mem_stat memory.usage_in_bytes $4
> +	cd ../subgroup_a
> +	check_mem_stat memory.usage_in_bytes $5
> +
> +	cd ..
> +	echo $! > tasks
> +	kill -s USR1 $!
> +	kill -s INT $!
> +	sleep 1
> +	rmdir subgroup_a subgroup_b
> +}
> +
> +cleanup()
> +{
> +	killall -9 memcg_process 2>/dev/null
> +	if [ -e /dev/memcg ]; then
> +		umount /dev/memcg 2>/dev/null
> +		rmdir /dev/memcg 2>/dev/null
> +	fi
> +}
> +
> +
> +do_mount()
> +{
> +	cleanup
> +
> +	mkdir /dev/memcg 2> /dev/null
> +	mount -t cgroup -omemory memcg /dev/memcg
> +}
> +


--------------050205040209060005020509
Content-Type: text/plain;
 name="0001-A-library-used-to-test-memcg.patch"
Content-Disposition: attachment;
	filename="0001-A-library-used-to-test-memcg.patch"
Content-Transfer-Encoding: quoted-printable

This library includes a set of functions used to test memcg.=0A=0ASigned-of=
f-by: Peng Haitao <penght@cn.fujitsu.com>=0A---=0A .../controllers/memcg/fu=
nctional/memcg=5Flib.sh      |  412 ++++++++++++++++++++=0A 1 files changed=
, 412 insertions(+), 0 deletions(-)=0A create mode 100644 testcases/kernel/=
controllers/memcg/functional/memcg=5Flib.sh=0A=0Adiff --git a/testcases/ker=
nel/controllers/memcg/functional/memcg=5Flib.sh b/testcases/kernel/controll=
ers/memcg/functional/memcg=5Flib.sh=0Anew file mode 100644=0Aindex 0000000.=
.6af1cc2=0A--- /dev/null=0A+++ b/testcases/kernel/controllers/memcg/functio=
nal/memcg=5Flib.sh=0A@@ -0,0 +1,412 @@=0A+#! /bin/sh=0A+=0A+###############=
#################################################################=0A+##    =
                                                                        ##=
=0A+## Copyright (c) 2012 FUJITSU LIMITED                                  =
       ##=0A+##                                                            =
                ##=0A+## This program is free software;  you can redistribu=
te it and#or modify      ##=0A+## it under the terms of the GNU General Pub=
lic License as published by       ##=0A+## the Free Software Foundation; ei=
ther version 2 of the License, or          ##=0A+## (at your option) any la=
ter version.                                        ##=0A+##               =
                                                             ##=0A+## This =
program is distributed in the hope that it will be useful, but        ##=0A=
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY ##=0A+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Publ=
ic License   ##=0A+## for more details.                                    =
                      ##=0A+##                                             =
                               ##=0A+## You should have received a copy of =
the GNU General Public License          ##=0A+## along with this program;  =
if not, write to the Free Software               ##=0A+## Foundation, Inc.,=
 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##=0A+##         =
                                                                   ##=0A+##=
 Author: Peng Haitao <penght@cn.fujitsu.com>                               =
 ##=0A+##                                                                  =
          ##=0A+###########################################################=
#####################=0A+=0A+if [ "x$(grep -w memory /proc/cgroups | cut -f=
4)" !=3D "x1" ]; then=0A+        echo "WARNING:";=0A+        echo "Either K=
ernel does not support for memory resource controller or feature not enable=
d";=0A+        echo "Skipping all memcgroup testcases....";=0A+        exit=
 0=0A+fi=0A+=0A+cd $LTPROOT/testcases/bin=0A+=0A+TEST=5FPATH=3D$PWD=0A+PAGE=
SIZE=3D`./memcg=5Fgetpagesize`=0A+HUGEPAGESIZE=3D`grep Hugepagesize /proc/m=
eminfo | awk '{ print $2 }'`=0A+[ -z $HUGEPAGESIZE ] && HUGEPAGESIZE=3D0=0A=
+HUGEPAGESIZE=3D$(( $HUGEPAGESIZE * 1024 ))=0A+PASS=3D0=0A+FAIL=3D1=0A+=0A+=
cur=5Fid=3D0=0A+failed=3D0=0A+=0A+# Record the test result of a test case=
=0A+# $1 - The result of the test case, $PASS or $FAIL=0A+# $2 - The output=
 information=0A+result()=0A+{=0A+	local pass=3D$1=0A+	local info=3D"$2"=0A+=
=0A+	if [ $pass -eq $PASS ]; then=0A+		tst=5Fresm TPASS "$info"=0A+	else=0A=
+		tst=5Fresm TFAIL "$info"=0A+		: $(( failed +=3D 1 ))=0A+	fi=0A+}=0A+=0A+=
# Check size in memcg=0A+# $1 - Item name=0A+# $2 - Expected size=0A+check=
=5Fmem=5Fstat()=0A+{=0A+	if [ -e $1 ]; then=0A+		item=5Fsize=3D`cat $1`=0A+=
	else=0A+		item=5Fsize=3D`grep -w $1 memory.stat | cut -d " " -f 2`=0A+	fi=
=0A+=0A+	if [ "$2" =3D "$item=5Fsize" ]; then=0A+		pass=3D$PASS=0A+	else=0A=
+		pass=3D$FAIL=0A+	fi=0A+=0A+	result $pass "$1=3D$item=5Fsize/$2"=0A+}=0A+=
=0A+warmup()=0A+{=0A+	pid=3D$1=0A+=0A+	echo "Warming up for test: $cur=5Fid=
, pid: $pid"=0A+	kill -s USR1 $pid 2> /dev/null=0A+	sleep 1=0A+	kill -s USR=
1 $pid 2> /dev/null=0A+	sleep 1=0A+=0A+	kill -0 $pid=0A+	if [ $? -ne 0 ]; t=
hen=0A+		result $FAIL "cur=5Fid=3D$cur=5Fid"=0A+		return 1=0A+	else=0A+		ec=
ho "Process is still here after warm up: $pid"=0A+	fi=0A+=0A+	return 0=0A+}=
=0A+=0A+# Run test cases which checks memory.stat after make=0A+# some memo=
ry allocation=0A+# $1 - the parameters of 'process', such as --shm=0A+# $2 =
- the -s parameter of 'process', such as 4096=0A+# $3 - item name in memory=
.stat=0A+# $4 - the expected size=0A+# $5 - check after free ?=0A+test=5Fme=
m=5Fstat()=0A+{=0A+	echo "Running $TEST=5FPATH/memcg=5Fprocess $1 -s $2"=0A=
+	$TEST=5FPATH/memcg=5Fprocess $1 -s $2 &=0A+	sleep 1=0A+=0A+	warmup $!=0A+=
	if [ $? -ne 0 ]; then=0A+		return=0A+	fi=0A+=0A+	echo $! > tasks=0A+	kill =
-s USR1 $! 2> /dev/null=0A+	sleep 1=0A+=0A+	check=5Fmem=5Fstat $3 $4=0A+=0A=
+	kill -s USR1 $! 2> /dev/null=0A+	sleep 1=0A+	if [ $5 -eq 1 ]; then=0A+		c=
heck=5Fmem=5Fstat $3 0=0A+	fi=0A+=0A+	kill -s INT $! 2> /dev/null=0A+}=0A+=
=0A+# Run test cases which checks memory.max=5Fusage=5Fin=5Fbytes after mak=
e=0A+# some memory allocation=0A+# $1 - the parameters of 'process', such a=
s --shm=0A+# $2 - the -s parameter of 'process', such as 4096=0A+# $3 - ite=
m name=0A+# $4 - the expected size=0A+# $5 - check after free ?=0A+test=5Fm=
ax=5Fusage=5Fin=5Fbytes()=0A+{=0A+	echo "Running $TEST=5FPATH/memcg=5Fproce=
ss $1 -s $2"=0A+	$TEST=5FPATH/memcg=5Fprocess $1 -s $2 &=0A+	sleep 1=0A+=0A=
+	warmup $!=0A+	if [ $? -ne 0 ]; then=0A+		return=0A+	fi=0A+=0A+	echo $! > =
tasks=0A+	kill -s USR1 $! 2> /dev/null=0A+	sleep 1=0A+=0A+	kill -s USR1 $! =
2> /dev/null=0A+	sleep 1=0A+=0A+	check=5Fmem=5Fstat $3 $4=0A+=0A+	if [ $5 -=
eq 1 ]; then=0A+		echo 0 > $3=0A+		check=5Fmem=5Fstat $3 0=0A+	fi=0A+=0A+	k=
ill -s INT $! 2> /dev/null=0A+}=0A+=0A+# make some memory allocation=0A+# $=
1 - the parameters of 'process', such as --shm=0A+# $2 - the -s parameter o=
f 'process', such as 4096=0A+malloc=5Ffree=5Fmemory()=0A+{=0A+	echo "Runnin=
g $TEST=5FPATH/memcg=5Fprocess $1 -s $2"=0A+	$TEST=5FPATH/memcg=5Fprocess $=
1 -s $2 &=0A+	sleep 1=0A+=0A+	echo $! > tasks=0A+	kill -s USR1 $! 2> /dev/n=
ull=0A+	sleep 1=0A+=0A+	kill -s USR1 $! 2> /dev/null=0A+	sleep 1=0A+=0A+	ki=
ll -s INT $! 2> /dev/null=0A+}=0A+=0A+# Test if failcnt > 0, which means pa=
ge reclamation occured=0A+# $1 - item name in memcg=0A+test=5Ffailcnt()=0A+=
{=0A+	failcnt=3D`cat $1`=0A+	if [ $failcnt -gt 0 ]; then=0A+		pass=3D$PASS=
=0A+	else=0A+		pass=3D$FAIL=0A+	fi=0A+=0A+	result $pass "$1=3D$failcnt"=0A+=
}=0A+=0A+# Test process will be killed due to exceed memory limit=0A+# $1 -=
 the value of memory.limit=5Fin=5Fbytes=0A+# $2 - the parameters of 'proces=
s', such as --shm=0A+# $3 - the -s parameter of 'process', such as 4096=0A+=
# $4 - use mem+swap limitation=0A+test=5Fproc=5Fkill()=0A+{=0A+	echo $1 > m=
emory.limit=5Fin=5Fbytes=0A+	if [ $4 -eq 1 ]; then=0A+		if [ -e memory.mems=
w.limit=5Fin=5Fbytes ]; then=0A+			echo $1 > memory.memsw.limit=5Fin=5Fbyte=
s=0A+		else=0A+			tst=5Fresm TCONF "mem+swap is not enabled"=0A+			return=
=0A+		fi=0A+	fi=0A+=0A+	$TEST=5FPATH/memcg=5Fprocess $2 -s $3 &=0A+	pid=3D$=
!=0A+	sleep 1=0A+	echo $pid > tasks=0A+=0A+	kill -s USR1 $pid 2> /dev/null=
=0A+	sleep 1=0A+=0A+	ps -p $pid > /dev/null 2> /dev/null=0A+	if [ $? -ne 0 =
]; then=0A+		wait $pid=0A+		if [ $? -eq 1 ]; then=0A+			result $FAIL "proce=
ss $pid is killed by error"=0A+		else=0A+			result $PASS "process $pid is k=
illed"=0A+		fi=0A+	else=0A+		kill -s INT $pid 2> /dev/null=0A+		result $FAI=
L "process $pid is not killed"=0A+	fi=0A+}=0A+=0A+# Test limit=5Fin=5Fbytes=
 will be aligned to PAGESIZE=0A+# $1 - user input value=0A+# $2 - expected =
value=0A+# $3 - use mem+swap limitation=0A+test=5Flimit=5Fin=5Fbytes()=0A+{=
=0A+	echo $1 > memory.limit=5Fin=5Fbytes=0A+	if [ $3 -eq 1 ]; then=0A+		if =
[ -e memory.memsw.limit=5Fin=5Fbytes ]; then=0A+			echo $1 > memory.memsw.l=
imit=5Fin=5Fbytes=0A+			limit=3D`cat memory.memsw.limit=5Fin=5Fbytes`=0A+		=
else=0A+			tst=5Fresm TCONF "mem+swap is not enabled"=0A+			return=0A+		fi=
=0A+	else=0A+		limit=3D`cat memory.limit=5Fin=5Fbytes`=0A+	fi=0A+=0A+	if [ =
$limit -eq $2 ]; then=0A+		result $PASS "input=3D$1, limit=5Fin=5Fbytes=3D$=
limit"=0A+	else=0A+		result $FAIL "input=3D$1, limit=5Fin=5Fbytes=3D$limit"=
=0A+	fi=0A+}=0A+=0A+# Test memory controller doesn't charge hugepage=0A+# $=
1 - the value of /proc/sys/vm/nr=5Fhugepages=0A+# $2 - the parameters of 'p=
rocess', --mmap-file or --shm=0A+# $3 - the -s parameter of 'process', such=
 as $HUGEPAGESIZE=0A+# $4 - 0: expected failure, 1: expected success=0A+tes=
t=5Fhugepage()=0A+{=0A+	TMP=5FFILE=3D$TEST=5FPATH/tmp=0A+	nr=5Fhugepages=3D=
`cat /proc/sys/vm/nr=5Fhugepages`=0A+=0A+	mkdir /hugetlb=0A+	mount -t huget=
lbfs none /hugetlb=0A+=0A+	echo $1 > /proc/sys/vm/nr=5Fhugepages=0A+=0A+	$T=
EST=5FPATH/memcg=5Fprocess $2 --hugepage -s $3 > $TMP=5FFILE 2>&1 &=0A+	sle=
ep 1=0A+=0A+	kill -s USR1 $! 2> /dev/null=0A+	sleep 1=0A+=0A+	check=5Fmem=
=5Fstat "rss" 0=0A+=0A+	echo "TMP=5FFILE:"=0A+	cat $TMP=5FFILE=0A+=0A+	if [=
 $4 -eq 0 ]; then=0A+		test -s $TMP=5FFILE=0A+		if [ $? -eq 0 ]; then=0A+		=
	result $PASS "allocate hugepage failed as expected"=0A+		else=0A+			kill -=
s USR1 $! 2> /dev/null=0A+			kill -s INT $! 2> /dev/null=0A+			result $FAIL=
 "allocate hugepage shoud fail"=0A+		fi=0A+	else=0A+		test ! -s $TMP=5FFILE=
=0A+		if [ $? -eq 0 ]; then=0A+			kill -s USR1 $! 2> /dev/null=0A+			kill -=
s INT $! 2> /dev/null=0A+			result $PASS "allocate hugepage succeeded"=0A+	=
	else=0A+			result $FAIL "allocate hugepage failed"=0A+		fi=0A+	fi=0A+=0A+	=
sleep 1=0A+	rm -rf $TMP=5FFILE=0A+	umount /hugetlb=0A+	rmdir /hugetlb=0A+	e=
cho $nr=5Fhugepages > /proc/sys/vm/nr=5Fhugepages=0A+}=0A+=0A+# Test the me=
mory charge won't move to subgroup=0A+# $1 - memory.limit=5Fin=5Fbytes in p=
arent group=0A+# $2 - memory.limit=5Fin=5Fbytes in sub group=0A+test=5Fsubg=
roup()=0A+{=0A+	mkdir subgroup=0A+	echo $1 > memory.limit=5Fin=5Fbytes=0A+	=
echo $2 > subgroup/memory.limit=5Fin=5Fbytes=0A+=0A+	echo "Running $TEST=5F=
PATH/memcg=5Fprocess --mmap-anon -s $PAGESIZE"=0A+	$TEST=5FPATH/memcg=5Fpro=
cess --mmap-anon -s $PAGESIZE &=0A+	sleep 1=0A+=0A+	warmup $!=0A+	if [ $? -=
ne 0 ]; then=0A+		return=0A+	fi=0A+=0A+	echo $! > tasks=0A+	kill -s USR1 $!=
 2> /dev/null=0A+	sleep 1=0A+	check=5Fmem=5Fstat "rss" $PAGESIZE=0A+=0A+	cd=
 subgroup=0A+	echo $! > tasks=0A+	check=5Fmem=5Fstat "rss" 0=0A+=0A+	# clea=
nup=0A+	cd ..=0A+	echo $! > tasks=0A+	kill -s INT $! 2> /dev/null=0A+	sleep=
 1=0A+	rmdir subgroup=0A+}=0A+=0A+# Run test cases which test memory.move=
=5Fcharge=5Fat=5Fimmigrate =0A+# $1 - the parameters of 'process', such as =
--shm=0A+# $2 - the -s parameter of 'process', such as 4096=0A+# $3 - some =
positive value, such as 1=0A+# $4 - the expected size=0A+# $5 - the expecte=
d size=0A+test=5Fmove=5Fcharge()=0A+{=0A+	mkdir subgroup=5Fa=0A+=0A+	$TEST=
=5FPATH/memcg=5Fprocess $1 -s $2 &=0A+	sleep 1=0A+	warmup $!=0A+	if [ $? -n=
e 0 ]; then=0A+		rmdir subgroup=5Fa=0A+		return=0A+	fi=0A+=0A+	echo $! > su=
bgroup=5Fa/tasks=0A+	kill -s USR1 $!=0A+	sleep 1=0A+=0A+	mkdir subgroup=5Fb=
=0A+	echo $3 > subgroup=5Fb/memory.move=5Fcharge=5Fat=5Fimmigrate=0A+	echo =
$! > subgroup=5Fb/tasks=0A+=0A+	cd subgroup=5Fb=0A+	check=5Fmem=5Fstat memo=
ry.usage=5Fin=5Fbytes $4=0A+	cd ../subgroup=5Fa=0A+	check=5Fmem=5Fstat memo=
ry.usage=5Fin=5Fbytes $5=0A+=0A+	cd ..=0A+	echo $! > tasks=0A+	kill -s USR1=
 $!=0A+	kill -s INT $!=0A+	sleep 1=0A+	rmdir subgroup=5Fa subgroup=5Fb=0A+}=
=0A+=0A+cleanup()=0A+{=0A+	killall -9 memcg=5Fprocess 2>/dev/null=0A+	if [ =
-e /dev/memcg ]; then=0A+		umount /dev/memcg 2>/dev/null=0A+		rmdir /dev/me=
mcg 2>/dev/null=0A+	fi=0A+}=0A+=0A+=0A+do=5Fmount()=0A+{=0A+	cleanup=0A+=0A=
+	mkdir /dev/memcg 2> /dev/null=0A+	mount -t cgroup -omemory memcg /dev/mem=
cg=0A+}=0A+=0A-- =0A1.7.1=0A=0A=

--------------050205040209060005020509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------050205040209060005020509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050205040209060005020509--


