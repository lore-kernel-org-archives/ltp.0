Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mv6xV-0006z9-IW
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 10:07:53 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mv6xN-0003Oj-R7
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 10:07:53 +0000
Received: by pxi39 with SMTP id 39so3930036pxi.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 06 Oct 2009 03:07:40 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 6 Oct 2009 03:07:40 -0700
Message-ID: <364299f40910060307g33fcf21chcfcdb4cefe4e9bc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Issue 3 - ptrace06 hung for 7 hours
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
To: LTP list <ltp-list@lists.sourceforge.net>

Hi all,
    Ran into another issue. When I was running ptrace06 in the
syscalls test I noticed that it had been hung for over 7 hours -- is
this a known issue?
    strace'ing the child proc didn't help (got ENOPERM), and
strace'ing the parent proc returned nada. I'm going to attach gdb and
figure out what the issue is, but I was wondering whether or not
anyone else knew.
Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
