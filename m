Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1My8EY-0008AE-BS
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:05:58 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My8EW-0004kJ-4W
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:05:58 +0000
Received: by pzk26 with SMTP id 26so34430pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 11:05:50 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 11:05:50 -0700
Message-ID: <364299f40910141105h5bb4c8f2g546328105791d86b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [issue 6] testcases/network/multicast testcases need rewriting
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

1. mc_cmds has unnecessary noise (most likely because it's trying to
install non-existent files):

<<<test_start>>>
tag=mc_cmds stime=1255502704
cmdline="mc_cmds"
contacts=""
analysis=exit
<<<test_output>>>
Getting ALL enabled interfaces which are configured !
gethostbyname*: Host name lookup failure
Testing ifconfig and netstat
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
: doing /tests/ltp/testcases/bin/mc_cmds.
: doing /tests/ltp/testcases/bin/mc_cmds.
Test Failed: Multicast ping disabled on this system (this is normal on
post 2005 kernels)
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=5 cstime=5
<<<test_end>>>

2. mc_opts is trying to do install, even though it shouldn't be:

<<<test_output>>>
gethostbyname*: Host name lookup failure
install: cannot stat `/tests/ltp/opts': No such file or directory
install: cannot stat `/tests/ltp/opts_e': No such file or directory
mc_opts: doing /tests/ltp/testcases/bin/mc_opts.
Running mc_opts opts_e on
/tests/ltp/testcases/bin/mc_opts: line 86:
/tests/ltp/bin/mc_opts13780/opts: No such file or directory
mc_opts: doing /tests/ltp/testcases/bin/mc_opts.
mc_opts: doing /tests/ltp/testcases/bin/mc_opts.
Test Failed: opts  failed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=6
<<<test_end>>>

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
