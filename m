Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y1DQb-0003eP-18
	for ltp-list@lists.sourceforge.net; Wed, 17 Dec 2014 12:10:05 +0000
Date: Wed, 17 Dec 2014 13:09:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141217120943.GA29078@rei>
References: <1418740497-24661-1-git-send-email-mats.liljegren@enea.com>
	<1418740497-24661-2-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1418740497-24661-2-git-send-email-mats.liljegren@enea.com>
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Compilation included the flag "-I/usr/include/tirpc" which ignores sysroot.
> This makes a cross-compile to suddenly use host files rather than the files
> installed in the compiler sysroot.
> 
> By prepending path with "=", the "=" will be replaced with the sysroot path.

Unfortunatelly this does not work for me. The compiler fails to find the
header after the change.

> diff --git a/m4/ltp-tirpc.m4 b/m4/ltp-tirpc.m4
> index 73fde51..f4df239 100644
> --- a/m4/ltp-tirpc.m4
> +++ b/m4/ltp-tirpc.m4
> @@ -25,7 +25,7 @@ AC_DEFUN([LTP_CHECK_TIRPC],[
>  	TIRPC_LIBS=""
>  
>  	AC_CHECK_HEADER(tirpc/netconfig.h,[
> -		TIRPC_CPPFLAGS="-I/usr/include/tirpc"

I've looked around for a solution and the internet seems to suggest to
add ${SYSROOT} before the /usr/include/tirpc:

+		TIRPC_CPPFLAGS="-I${SYSROOT}/usr/include/tirpc"

Does that work for you?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
