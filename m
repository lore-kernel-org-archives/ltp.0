Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1Prmuf-0004vD-DI
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 07:44:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Prmue-0007L5-1X
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 07:44:01 +0000
Date: Tue, 22 Feb 2011 15:47:45 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110222074745.GE2883@hpt.nay.redhat.com>
References: <20110222065507.GA7689@hpt.nay.redhat.com>
	<49FB8369-77D6-4B9A-B69C-6E9E2DC54F80@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <49FB8369-77D6-4B9A-B69C-6E9E2DC54F80@gmail.com>
Subject: Re: [LTP] [PATCH] try two methods to disable set_ftrace_pid
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 21, 2011 at 10:57:34PM -0800, Garrett Cooper wrote:
> On Feb 21, 2011, at 10:55 PM, Han Pingtian wrote:
> 
> > On older kernel, we should use "echo -1 > ..." to disable
> > set_ftrace_pid, but on the latest kernel we must use
> > "echo > ..." to disable it. So we have to try both methods
> > for disabling it in ftrace stress test.
> > 
> > Signed-off-by: Han Pingtian <phan@redhat.com>
> > ---
> > .../ftrace_stress/ftrace_set_ftrace_pid.sh         |    8 +++++++-
> > 1 files changed, 7 insertions(+), 1 deletions(-)
> > 
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> > index 541215c..2ab6cf2 100755
> > --- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> > @@ -36,7 +36,13 @@ for ((; ; ))
> > 			eval echo $str >> "$TRACING_PATH"/set_ftrace_pid
> > 		}
> > 
> > -		echo > "$TRACING_PATH"/set_ftrace_pid
> > +		if ! echo > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1; then
> > +			echo -1 > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1 
> > +
> > +			if [ $? -ne 0 ]; then
> > +				tst_resm TBROK "Cannot disable set_ftrace_pid!"
> 
> 	Unlike the C APIs, this will never exit. Yes, I realize this is dumb.
> Thanks,
> -Garrett
I have updated the patch, please have a review. Thanks.

-- 
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-try-two-methods-to-disable-set_ftrace_pid.patch"

From 7db898dbc4b57e20bca4fc5d2f736eef81b21c85 Mon Sep 17 00:00:00 2001
From: Han Pingtian <phan@redhat.com>
Date: Tue, 22 Feb 2011 14:22:52 +0800
Subject: [PATCH] try two methods to disable set_ftrace_pid

On older kernel, we should use "echo -1 > ..." to disable set_ftrace_pid,
but on the latest kernel we must use "echo > ..." to disable it. So we
have to try both methods for disabling it in ftrace stress test.

And if we failed to disable the set_ftrace_pid, will try to report test
failure to the user.

Signed-off-by: Han Pingtian <phan@redhat.com>
---
 .../ftrace_stress/ftrace_set_ftrace_pid.sh         |    7 +++-
 .../ftrace_stress_test/ftrace_stress_test.sh       |   40 +++++++++++--------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
index 541215c..7bc76d9 100755
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
+++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
@@ -36,7 +36,12 @@ for ((; ; ))
 			eval echo $str >> "$TRACING_PATH"/set_ftrace_pid
 		}
 
-		echo > "$TRACING_PATH"/set_ftrace_pid
+		if ! echo > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1; then
+			if ! echo -1 > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1; then
+				tst_resm TBROK "Cannot disable set_ftrace_pid!"
+				exit 1
+			fi
+		fi
 	}
 
 	sleep 1
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
index 874268e..b4b115a 100755
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
+++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
@@ -34,6 +34,7 @@ export TRACING_PATH="$PWD/debugfs/tracing"
 export SPATH="$TPATH/ftrace_stress"
 
 test_interval=$1
+test_success=true
 
 save_old_setting()
 {
@@ -100,22 +101,22 @@ restore_old_setting()
 
 clean_up()
 {
-	kill -KILL $pid1
-	kill -KILL $pid2
-	kill -KILL $pid3
-	kill -KILL $pid4
-	kill -KILL $pid5
-	kill -KILL $pid6
-	kill -KILL $pid7
-	kill -KILL $pid8
-	kill -KILL $pid9
-	kill -KILL $pid10
-	kill -KILL $pid11
-	kill -USR1 $pid12
-	kill -KILL $pid13
-	kill -KILL $pid14
-	kill -KILL $pid15
-	kill -KILL $pid16
+	kill -KILL $pid1 || test_success=false
+	kill -KILL $pid2 || test_success=false
+	kill -KILL $pid3 || test_success=false
+	kill -KILL $pid4 || test_success=false
+	kill -KILL $pid5 || test_success=false
+	kill -KILL $pid6 || test_success=false
+	kill -KILL $pid7 || test_success=false
+	kill -KILL $pid8 || test_success=false
+	kill -KILL $pid9 || test_success=false
+	kill -KILL $pid10 || test_success=false
+	kill -KILL $pid11 || test_success=false
+	kill -USR1 $pid12 || test_success=false
+	kill -KILL $pid13 || test_success=false
+	kill -KILL $pid14 || test_success=false
+	kill -KILL $pid15 || test_success=false
+	kill -KILL $pid16 || test_success=false
 
 	sleep 2
 	restore_old_setting
@@ -233,5 +234,10 @@ clean_up
 
 echo "Ftrace Stress Test End"
 
-tst_resm TPASS "finished running the test. Run dmesg to double-check for bugs"
+if $test_success; then
+	tst_resm TPASS "finished running the test. Run dmesg to double-check for bugs"
+else
+	tst_resm TFAIL "please check log message."
+	exit 1
+fi
 
-- 
1.7.1


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Index, Search & Analyze Logs and other IT data in Real-Time with Splunk 
Collect, index and harness all the fast moving IT data generated by your 
applications, servers and devices whether physical, virtual or in the cloud.
Deliver compliance at lower cost and gain new business insights. 
Free Software Download: http://p.sf.net/sfu/splunk-dev2dev
--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--wRRV7LY7NUeQGEoC--

