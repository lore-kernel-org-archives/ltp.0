Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1YNH22-0003pz-Ch
	for ltp-list@lists.sourceforge.net; Mon, 16 Feb 2015 08:27:54 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1YNH20-0007bL-Lf
	for ltp-list@lists.sourceforge.net; Mon, 16 Feb 2015 08:27:54 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Mon, 16 Feb 2015 08:15:22 +0000
Message-ID: <0247700D01F14443B9209F90AD938CC524E65CBB@SESTOEX04.enea.se>
References: <1418740497-24661-1-git-send-email-mats.liljegren@enea.com>
	<1418740497-24661-2-git-send-email-mats.liljegren@enea.com>,
	<20150216051704.GB4075@vapier>
In-Reply-To: <20150216051704.GB4075@vapier>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] ltp: Fix cross-compile issue
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

My change never made it into the repository. Instead, Cyril prepended the path with ${SYSROOT}, where your cross-compile environment needs to setup SYSROOT path in order to make a proper cross-compile of LTP. See commit d4ab5d27d5ad666547d7b4d8e269e00921960c58. Cludgy, but it is simple and it works. This "=" thing I proposed apparently didn't work for everyone.

As for using pkg-config, I have no idea how that will work out in a cross-compile environment. But I guess it should be possible to go down that route as well...

/Mats
________________________________________
From: Mike Frysinger [vapier@gentoo.org]
Sent: Monday, February 16, 2015 6:17 AM
To: Mats Liljegren
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] [PATCH] ltp: Fix cross-compile issue

On 16 Dec 2014 15:34, Mats Liljegren wrote:
> --- a/m4/ltp-tirpc.m4
> +++ b/m4/ltp-tirpc.m4
> @@ -25,7 +25,7 @@ AC_DEFUN([LTP_CHECK_TIRPC],[
>       TIRPC_LIBS=""
>
>       AC_CHECK_HEADER(tirpc/netconfig.h,[
> -             TIRPC_CPPFLAGS="-I/usr/include/tirpc"
> +             TIRPC_CPPFLAGS="-I=/usr/include/tirpc"
>               AC_DEFINE(HAVE_LIBTIRPC, 1, [Define to 1 if you have libtirpc headers installed])
>               AC_CHECK_LIB(tirpc, rpcb_set, [TIRPC_LIBS="-ltirpc"])])

this m4 is fatally flawed and tweaking the flags won't help.  we should switch
to use pkg-config here.  a cursory glance suggests acl/cap should also be
updated.
-mike

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
