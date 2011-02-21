Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Prc0a-0000kV-J8
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 20:05:24 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Prc0Z-00077S-P9
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 20:05:24 +0000
Received: by wyj26 with SMTP id 26so1231999wyj.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 21 Feb 2011 12:05:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=iUMsdkEcvw+zpxBnZYT1AAZWAp_OHNEVVxf8=@mail.gmail.com>
References: <AANLkTinOqU_P=kD065O7MayXgN30NV_=D2cpqWGVwM5E@mail.gmail.com>
	<AANLkTi=iUMsdkEcvw+zpxBnZYT1AAZWAp_OHNEVVxf8=@mail.gmail.com>
Date: Mon, 21 Feb 2011 12:05:17 -0800
Message-ID: <AANLkTi=xLRif2=pK_dZewBvboKa01g-f2ZyWb-S_g_6y@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP test cases fpathconf syscall and signal_test_06 ipc
 test cases found hanging on android Gingerbread kernel
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
To: Amit kumar <kumaratreya@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Sun, Feb 20, 2011 at 10:31 PM, Amit kumar <kumaratreya@gmail.com> wrote:
> Hi,
> I am using LTP to test Android platform and successively ported to Eclair
> after customization.
>
>
> fpathconf syscall and signal_test_06 ipc test cases found hanging on Android
> Gingerbread Kernel.
>
>
> Are these know issues or we need to fix them?

    Does this work when it's treated as a UCLINUX platform? I know
(based on previous reading) that Android uses Bionic libc, which is a
BSD based libc, and potentially incomplete compared to glibc or others
on the GNU/Linux platform.
    As an aside, I find it funny how Linux folks seem to be mixing and
matching libraries and kernels on `production' platforms like this,
expecting success.
Thanks,
-Garrett

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
