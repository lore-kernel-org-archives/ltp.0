Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1My8Fo-0000Ab-7y
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:07:16 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My8Fc-0004vM-Tm
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:07:11 +0000
Received: by pzk26 with SMTP id 26so35416pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 11:06:59 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 11:06:59 -0700
Message-ID: <364299f40910141106s66c7c2bejd08ee702fb895e77@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [issue 7] rpc01 arguments don't match up with rpc1's usage
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

<<<test_output>>>
/tests/ltp/testcases/bin/rpc01: line 61: rsh: command not found
/tests/ltp/testcases/bin/rpc01: line 62: rsh: command not found
The rpc_server PID is
Starting rpc01
server o unknown
Usage: /tests/ltp/testcases/bin/rpc1 -s server -f file [-p
program-number] [-v version]
rpc01: doing /tests/ltp/testcases/bin/rpc01.
Test Failed: Fail on using file.1
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=2 cstime=3
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
