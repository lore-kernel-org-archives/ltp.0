Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OZcOh-0002cc-Ch
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 04:19:39 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OZcOf-0004fi-Nn
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 04:19:39 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.25])
	by out03.sjc.mx.trendmicro.com (Postfix) with ESMTP id A452A211020
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Jul 2010 04:19:31 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 1676B3DD027
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Jul 2010 04:19:30 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 16 Jul 2010 13:19:28 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 16 Jul 2010 13:19:28 +0900
Message-ID: <000001cb249e$14ed7490$3ec85db0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] =?iso-2022-jp?b?GyRCIUkjQyNvI24jdCNhI2kjbiNlI3IjcyFJGyhC?=
	=?iso-2022-jp?b?IHRlc3Qgd2FzICJURkFJTCIgYnV0ICJQQVNTIiBpcyBpbiBs?=
	=?iso-2022-jp?b?b2cgcmVzdWx0cw==?=
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

With RHEL5.4/5.5 systems, I noticed that "Containers" test failed but 
"Containers" is PASS in log results:

---<log results file>-------------
...
hangup01                       PASS       0    
Containers                     PASS       0    
BindMounts                     PASS       0    
...
----------------

---<detail in redirected file>-------------
...
check_netns_enabled    1  TFAIL  :  unshare syscall smoke test failed:
errno=EINVAL(22): Invalid argument
Network namespaces not enabled in kernel.  Not running netns tests.
...
----------------

The source which returned with "Invalid argument" is
"check_netns_enabled.c":

---<check_netns_enabled.c>-------------
main()
{
        /* Checking if the kernel supports unshare with netns capabilities.
*/
        if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) < 0) {
                tst_resm (TFAIL | TERRNO, "unshare syscall smoke test
failed");
        }
        tst_exit();
}
----------------

In RHEL5.4/5.5 systems, unshare() does not support the argument 
"CLONE_NEWNET".
But I feel strange that log results is "PASS" in spite of "TFAIL" exit. 

"container_test.sh" which calls "check_netns_enabled.c" is as follows:
---<container_test.sh>-------------
...
check_netns_enabled
if [ $? -eq 0 ]; then
        echo "Running netns tests."
        runnetnstest.sh
else
        echo "Network namespaces not enabled in kernel.  Not running netns
tests."
fi
...
----------------

According to above source, "check_netns_enabled.c" is only the judgement 
whether "runnetnstest.sh" test can be called or not.
So, I think that "TFAIL" is not suitable for the test impossibility 
message.
"TCONF" is more suitable for the message than "TFAIL", I think.
But, if "TCONF" is used instead of "TFAIL", "tst_exit" returns with 0.
And the test shell "runnetnstest.sh" is called against intention.


I thought up two ways of solutions.
(1) Insert "exit(1)" just after "tst_resm()" of "check_netns_enabled.c"
(2) Replace "TFAIL" with "TWARN", instead of "TCONF".

But above solutions are both irregular measures, I think.

If there are other good measures, please give me advice.


In the following, I nominate a temporary patch for an example:

Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

===(1)=========
--- a/testcases/kernel/containers/netns/check_netns_enabled.c	2010-07-12
02:01:45.000000000 +0900
+++ b/testcases/kernel/containers/netns/check_netns_enabled.c	2010-07-16
11:58:14.000000000 +0900
@@ -43,7 +43,8 @@
 {
 	/* Checking if the kernel supports unshare with netns capabilities.
*/
         if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) < 0) {
-		tst_resm (TFAIL | TERRNO, "unshare syscall smoke test
failed");
+		tst_resm (TCONF | TERRNO, "unshare syscall smoke test
failed");
+		exit (1);
 	}
 	tst_exit();
 }
============

===(2)=========
--- a/testcases/kernel/containers/netns/check_netns_enabled.c	2010-07-12
02:01:45.000000000 +0900
+++ b/testcases/kernel/containers/netns/check_netns_enabled.c	2010-07-16
11:56:47.000000000 +0900
@@ -43,7 +43,7 @@
 {
 	/* Checking if the kernel supports unshare with netns capabilities.
*/
         if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) < 0) {
-		tst_resm (TFAIL | TERRNO, "unshare syscall smoke test
failed");
+		tst_resm (TWARN | TERRNO, "unshare syscall smoke test
failed");
 	}
 	tst_exit();
 }
============



Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
