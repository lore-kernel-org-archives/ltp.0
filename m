Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PBu2j-0006qq-9H
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 18:51:13 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PBu2g-0001pa-St
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 18:51:13 +0000
Received: by eya28 with SMTP id 28so1963199eya.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 Oct 2010 11:51:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <D943D2E3-F6CB-46BF-98F5-96585390926E@sketchymonkey.com>
References: <AANLkTimdQrrOveqUDGo8yY+a9O=uAQ3VtfKLehQ6Bmgi@mail.gmail.com>
	<AANLkTi=haZnJtS-WiUr+=bLNuwywLinSdSm7Ok+=p8d5@mail.gmail.com>
	<D943D2E3-F6CB-46BF-98F5-96585390926E@sketchymonkey.com>
Date: Fri, 29 Oct 2010 11:51:04 -0700
Message-ID: <AANLkTin4uxLebTz=jVFbHmxyeVAXpKhBZCAkF1LXLPVs@mail.gmail.com>
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

On Fri, Oct 29, 2010 at 10:58 AM, David Peverley <pev@sketchymonkey.com> wrote:
> On 29 Oct 2010, at 18:04, Garrett Cooper wrote:
>>> On my board, if I run an unsupported test (e.g. one where the kernel
>>> has not been configured) I get the following :
> ...
>
>>> Connectors 0 CONF : system doesn't support execution of the test
> ...
>
>>> INFO: ltp-pan reported all tests PASS
>>> LTP Version: LTP-20100831
>> CONF -> expected failure due to lack of support -> ok to ignore if
>> your system doesn't meet the preconditions :). tst_res(3) (yes,
>> there's a manpage) describes this in more detail, as well as a few
>> documents in LTP; they might be a bit stale though.
> Hi Garett - not quite what I was wondering about! I understand the result of CONF which is expected. However this is reported by ltp-pan as a PASS at the end of the test as quoted above (as well as in the results/LTP_xxxxxxx log file). From my understanding and what bits of other peoples logs I could find via google this should also be logged as a CONF or a WARN?
>
> I also noticed some other tests that failed as some scripts that were depended on weren't present and these were being represented as a PASS in the results too...

    The only thing that is reported as "errors" at the top-level
runltp scripts are TFAIL and TBROK. Everything else passes (because if
you dig through lib/tst_res.c you'll soon discover that the exit code
that's used in tst_exit is dependent on those inputs). This is by
design.
    If people abused the APIs, then the API calls need to be fixed.
Thanks,
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
