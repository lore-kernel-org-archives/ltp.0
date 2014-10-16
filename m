Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<jbeckenbach=ltp-list=lists.sourceforge.net=jmtqtyzj@lancope.com>)
	id 1XemPc-0002Gy-Sw
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 14:52:20 +0000
Received: from smtp-out3.electric.net ([72.35.12.185])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XemPb-0002gC-U8
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 14:52:20 +0000
Received: from 1XelX6-0001Hz-Uj by out3a.electric.net with emc1-ok (Exim
	4.80.1) (envelope-from <jbeckenbach@lancope.com>) id 1XelX6-0001Lw-W6
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 06:56:00 -0700
Received: from [209.182.184.2] (helo=LCHQEX03.lancope.local)
	by out3a.electric.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.80.1) (envelope-from <jbeckenbach@lancope.com>)
	id 1XelX6-0001Hz-Uj
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 06:56:00 -0700
From: Joseph Beckenbach <jbeckenbach@lancope.com>
Date: Thu, 16 Oct 2014 13:55:58 +0000
Message-ID: <4506ACC2AE90484D87F9A883BA36C21C2AE70C85@LCHQEX03.lancope.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] cpuset_syscall_testset.sh: check TCONF for test
	15, 16
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi, Jan, all!

Apologies for non-standard reply format:  I'm forced to use a brain-dead WYSIWYG GUI for text processing
fronting a brain-dead email processor which often fails to honor newlines in original text. :-b

In b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
in @@ -299,7 +299,18 @@ and @@ -316,7 +327,18 @@ you use
====
+	grep "TCONF" "$TEST_OUTPUT"
+	if [ $? -eq 0 ]; then
+		return 0
+	fi
+
+	if [ $ret -ne 0 ]; then
+		return 1
+	fi
====

perhaps express this more idiomatically:
====
+	grep "TCONF" "$TEST_OUTPUT" && return 0
+	[ $ret -ne 0 ] && return 1
====

This appears to be elsewhere in test15() and test16(), so I presume it's throughout the file,
and thus worthy of a separate refactoring patch if anyone chooses to perform this.

Thanks!

Joseph
Joseph Beckenbach, senior QA engineer : Automation  -- +1-470-299-7166
Lancope, Inc. -- makers of StealthWatch


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
