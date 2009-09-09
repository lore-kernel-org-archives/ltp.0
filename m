Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <suzuki@in.ibm.com>) id 1MlFb4-0006mI-Lg
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 05:19:58 +0000
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MlFaX-00048A-Vk
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 05:19:58 +0000
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id n895F6I8008789
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 15:15:06 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n895IlvC995328
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 15:18:47 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n895Ik95018170
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 15:18:47 +1000
Message-ID: <4AA73AB0.9020202@in.ibm.com>
Date: Wed, 09 Sep 2009 10:48:40 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
References: <4AA67D12.5010602@in.ibm.com> <4AA7391B.4020804@cn.fujitsu.com>
In-Reply-To: <4AA7391B.4020804@cn.fujitsu.com>
Content-Type: multipart/mixed; boundary="------------010407000204040901000202"
Subject: Re: [LTP] LTP : Fix connectors event_generator program : gen_fork
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
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010407000204040901000202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Li Zefan wrote:
> Suzuki Poulose wrote:
>> Hi,
>>
>> There is a testcase issue in the event_generator code. The gen_fork() is
>> called to generate the fork event.
>>
>> The child process prints the following message:
>>
>> static inline void gen_fork(void)
>> {
>>         pid_t pid;
>>         int status;
>>
>>         pid = fork();
>>         if (pid == 0) {
>>                 printf("fork parent: %d, child: %d\n", getppid(),
>> getpid());
>>                 exit(0);
>>         } else if (pid < 0) {
>>                 fprintf(stderr, "fork() failed\n");
>>                 exit(1);
>>         }
>> }
>>
>> Now the parent process just exits after this call. So, if the child
>> doesn't get to run before parent exits, the child will see the ppid as
>> 1, that of INIT and this contradicts the actual data. Hence the test fails.
>>
>> Attached patch fixes the issue. I have verified the same. Please apply.
>>
> 
> Thanks for fixing it.
> 
> Acked-by: Li Zefan <lizf@cn.fujitsu.com>
> 
> But you forgot to add your Signed-off-by in the patch. ;)
> 
Ah! Thanks for catching that ! Re-attaching it ;)

Thanks

Suzuki

--------------010407000204040901000202
Content-Type: text/plain;
 name="connectors-gen_fork-wait-for-child.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="connectors-gen_fork-wait-for-child.diff"

gen_fork() event should wait until the child exits. Otherwise the child would see INIT as the parent and
end up in collecting wrong information to compare with.


Signed-off-by: Suzuki K P <suzuki@in.ibm.com>
Acked-by: Li Zefan <lizf@cn.fujitsu.com>

Index: ltp/testcases/kernel/connectors/pec/event_generator.c
===================================================================
--- ltp.orig/testcases/kernel/connectors/pec/event_generator.c	2008-10-22 13:40:31.000000000 +0000
+++ ltp/testcases/kernel/connectors/pec/event_generator.c	2009-09-08 13:52:14.000000000 +0000
@@ -25,6 +25,9 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <pwd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
 #include "test.h"
 
 #define DEFAULT_EVENT_NUM       1
@@ -94,6 +97,7 @@
 static inline void gen_fork(void)
 {
 	pid_t pid;
+	int status;
 
 	pid = fork();
 	if (pid == 0) {
@@ -102,6 +106,8 @@
 	} else if (pid < 0) {
 		fprintf(stderr, "fork() failed\n");
 		exit(1);
+	} else {  /* Parent should wait for the child */
+		wait(&status);
 	}
 }
 

--------------010407000204040901000202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------010407000204040901000202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010407000204040901000202--

