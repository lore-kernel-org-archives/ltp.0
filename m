Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ccnandi@yahoo.com>) id 1UjzXv-0004I1-9M
	for ltp-list@lists.sourceforge.net; Tue, 04 Jun 2013 22:17:39 +0000
Received: from nm41-vm8.bullet.mail.ne1.yahoo.com ([98.138.120.212])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UjzXu-0006Rh-Dl
	for ltp-list@lists.sourceforge.net; Tue, 04 Jun 2013 22:17:39 +0000
Message-ID: <1370384252.14316.YahooMailClassic@web120802.mail.ne1.yahoo.com>
Date: Tue, 4 Jun 2013 15:17:32 -0700 (PDT)
From: C Nandi <ccnandi@yahoo.com>
MIME-Version: 1.0
Subject: [LTP] Test suite for the t-core kernel patch
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi,

Is this test suite for t-core kernel patch still valid?
If yes, can we avoid invoking following function, and go with the following patch? I believe "/proc/sys/kernel/core_dumps_threads" file will not get created by latest kernel.

File: testcases/misc/tcore_patch_test_suites/tcore.sh

check_install()
{
        if [ -f /proc/sys/kernel/core_dumps_threads ];then
                pass=`expr $pass + 1`
                return 0
        else
                fail=`expr $fail + 1`
                return 1
        fi
}

=========



diff -urN org/tcore.exp mod/tcore.exp
--- org/tcore.exp       2013-05-17 15:08:09.000000000 -0600
+++ mod/tcore.exp       2013-05-17 14:07:37.000000000 -0600
@@ -39,7 +39,7 @@
     set istrue 0
     send "info threads\n"
     expect {
-               -re " \[0-9\]+ process .*(gdb)" {
+               -re " \[0-9\]+ Thread .*(gdb)" {
        set buf $expect_out(0,string)
        }
        timeout {
@@ -47,7 +47,7 @@
                return 1
        }
     }
-    set curr_thread [check_buf $buf "process"]
+    set curr_thread [check_buf $buf "Thread"]
     if { $curr_thread == 0 } {
        send_user "check_threads (no current thread)\n"
        return 1
@@ -76,7 +76,7 @@
                                  return 1
                         }
                 }
-                set number1 [check_buf $buf "(process"]
+                set number1 [check_buf $buf "(Thread"]
                 send "bt\n"
                 expect {
                         -re  " bt.*#\[0-9\]+ .*(gdb)" {
@@ -101,13 +101,13 @@
 }

 proc check_fpu {num} {
+       exp_internal 1
        global expect_out
        global pass
-       send "\n"
-       send "info register\n"
-       send "\n"
+       send "set pagination off\n"
+       send "info all-register\n"
        expect {
-               -re "xmm$num\[\t \]+\{f \= .*\}+\[\t \]+\{f \= .*\}" {
+               -re "xmm$num\[\t \]+\{.*f.* \= .*\}" {
                        set buf $expect_out(0,string)
                }
                timeout {
@@ -130,8 +130,8 @@
        }
 }
 set GDB gdb
-set binfile ./tcore
-set corefile  ./corefile
+set binfile  [lindex $argv 0]
+set corefile [lindex $argv 1]

 spawn $GDB ${binfile} ${corefile}
 check_fpu 5
diff -urN org/tcore.sh mod/tcore.sh
--- org/tcore.sh        2013-05-17 15:08:09.000000000 -0600
+++ mod/tcore.sh        2013-05-17 14:08:05.000000000 -0600
@@ -125,19 +125,22 @@
        prepare_gdb
        mv -f $TEST_DIR/core.* $TEST_DIR/corefile >/dev/null 2>&1
        echo "Test whether the core support bt,fpu and threads commands "
-       expect $BIN_DIR/tcore.exp
+       expect $BIN_DIR/tcore.exp $BIN_DIR/tcore $TEST_DIR/corefile
        return=$?
        pass=`expr $pass + $return`
+echo $pass,$return,$fail
        fail=`expr 3 - $return + $fail`
 }

 echo "Test Tcore patch "
-check_install
+# Avoid check for /proc/sys/kernel/core_dumps_threads
+# This is not supported by latest kernels
+#check_install
 Test_gen_core
 Test_core_file
 echo "Linux Tcore test results" > results
 echo "Total pass fail" >>  results
-echo "  5      $pass   $fail" >> results
+echo "  4      $pass   $fail" >> results
 cleanup $fail


Thanks,
Nandi


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
