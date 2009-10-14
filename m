Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyAph-0005Gn-4F
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 20:52:29 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyApc-0001eG-Ks
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 20:52:29 +0000
Received: by pzk26 with SMTP id 26so152770pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 13:52:19 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 13:52:19 -0700
Message-ID: <364299f40910141352v37591304k2694df3a8ca42273@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [issue 11] pan doesn't output exec log if execve fails quickly
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
    Something I've noticed with my execltp script is that when it goes
and parses the exec log for LTP, the results are missing if the
testsuite fails to execute with execve. Example (filecaps):

Exec log:
startup='Wed Oct 14 08:15:02 2009'
startup='Wed Oct 14 08:15:02 2009'

Output log:

<<<test_start>>>
tag=Filecaps stime=1255508102
cmdline="filecapstest.sh"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(4861): execvp of 'filecapstest.sh' (tag
Filecaps) failed.  errno:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
incrementing stop

    I'm trying to track down and fix the issue in ltp-pan.c in my free
time, but it seems like this issue is either a corner case that wasn't
considered when with verifying children produced with run_child and
printing out their results.
Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
