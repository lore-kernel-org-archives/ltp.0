Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PBsNI-0006IU-CJ
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 17:04:20 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PBsNG-0000Jp-3C
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 17:04:20 +0000
Received: by wya21 with SMTP id 21so3298997wya.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 Oct 2010 10:04:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimdQrrOveqUDGo8yY+a9O=uAQ3VtfKLehQ6Bmgi@mail.gmail.com>
References: <AANLkTimdQrrOveqUDGo8yY+a9O=uAQ3VtfKLehQ6Bmgi@mail.gmail.com>
Date: Fri, 29 Oct 2010 10:04:11 -0700
Message-ID: <AANLkTi=haZnJtS-WiUr+=bLNuwywLinSdSm7Ok+=p8d5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] PASS or WARN?
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
To: David Peverley <pev@sketchymonkey.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Oct 29, 2010 at 9:17 AM, David Peverley <pev@sketchymonkey.com> wrote:
> Hi all,
>
> On my board, if I run an unsupported test (e.g. one where the kernel
> has not been configured) I get the following :
>
> Running tests.......
> <<<test_start>>>
> tag=Connectors stime=1288368730
> cmdline="connector_test.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> Connectors 0 CONF : system doesn't support execution of the test
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=0 corefile=no
> cutime=3 cstime=3
> <<<test_end>>>
> INFO: ltp-pan reported all tests PASS
> LTP Version: LTP-20100831

CONF -> expected failure due to lack of support -> ok to ignore if
your system doesn't meet the preconditions :). tst_res(3) (yes,
there's a manpage) describes this in more detail, as well as a few
documents in LTP; they might be a bit stale though.
HTH,
-Garrett

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
