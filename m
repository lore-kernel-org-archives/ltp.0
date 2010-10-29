Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pev@sketchymonkey.com>) id 1PBs54-0004sk-Sv
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 16:45:30 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PBs53-0006QY-Ss
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 16:45:30 +0000
Received: by qwd6 with SMTP id 6so3386035qwd.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 Oct 2010 09:45:24 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 29 Oct 2010 17:17:45 +0100
Message-ID: <AANLkTimdQrrOveqUDGo8yY+a9O=uAQ3VtfKLehQ6Bmgi@mail.gmail.com>
From: David Peverley <pev@sketchymonkey.com>
Subject: [LTP] PASS or WARN?
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

Hi all,

On my board, if I run an unsupported test (e.g. one where the kernel
has not been configured) I get the following :

Running tests.......
<<<test_start>>>
tag=Connectors stime=1288368730
cmdline="connector_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
Connectors 0 CONF : system doesn't support execution of the test
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=3 cstime=3
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: LTP-20100831

       ###############################################################"

            Done executing testcases."
            LTP Version:  LTP-20100831
       ###############################################################"

I'm fairly sure this should be a WARN? Is this a known issue?

Cheers,

~Pev

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
