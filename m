Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MVgWP-0001NP-TV
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2009 06:50:49 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MVgWO-0007qR-Jj
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2009 06:50:49 +0000
Received: by yxe33 with SMTP id 33so6828793yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 27 Jul 2009 23:50:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810907200605r5fc2f575ta761cd45c92b0837@mail.gmail.com>
References: <f5a7b3810907200605r5fc2f575ta761cd45c92b0837@mail.gmail.com>
Date: Tue, 28 Jul 2009 12:20:43 +0530
Message-ID: <f5a7b3810907272350n258c4018mcbf1c5806c3bd27f@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [FIX PATCHES] open_posix_execute.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Brandon Philips <bphilips@suse.de>

Hi,

Hope you have reviewed below patch.
If you any issue please let me know.

Subrata/ Garrett,
Please review, if you feel okay.
commit.

Best regards,
Naresh Kamboju


On Mon, Jul 20, 2009 at 6:35 PM, naresh kamboju<naresh.kernel@gmail.com> wr=
ote:
> Hi,
>
> As per the execute.sh script file there is time limit of two minutes
> for each test case execution if it takes more time it will be reported
> as HUNG.
>
> shm_open/23-1.c test case under posix test suite which executes more
> than two minitutes so test case reported as HUNG.
>
> I have changed time limit from 120 to 300 sec. that is nothing but two
> minutes to five minutes. In low end machines this test case taking 4
> min to complete execution.
>
> Now test cases reported as PASS
>
> I have attached patch and below.
> Please review the same.
>
>
> Best regards,
> Naresh Kamboju
>
>
> /*****************************************************/
> Before Patch:
>
> conformance/interfaces/shm_open/23-1.test:execution:HUNG
>
>
> After Patch:
>
> conformance/interfaces/shm_open/23-1.test:execution:PASS
> /*****************************************************/
>
>
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>
> diff -Naurb a/testcases/open_posix_testsuite/execute.sh
> b/testcases/open_posix_testsuite/execute.sh
> --- a/testcases/open_posix_testsuite/execute.sh 2007-07-26
> 17:32:11.000000000 +0530
> +++ b/testcases/open_posix_testsuite/execute.sh 2009-07-20
> 17:53:15.000000000 +0530
> @@ -163,8 +163,8 @@
> =A0declare -i SEGV=3D0
> =A0declare -i OTH=3D0
>
> -# Maximum Two minutes waiting time period to execute a test. If it
> exceeds, the test case will go into the 'HUNG' category.
> -TIMEOUT_VAL=3D120
> +# Maximum five minutes waiting time period to execute a test. If it
> exceeds, the test case will go into the 'HUNG' category.
> +TIMEOUT_VAL=3D300
>
> =A0# if gcc available then remove the below line comment else put the t0
> in posixtestsuite directory.
> =A0#gcc -o t0 t0.c
>

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
