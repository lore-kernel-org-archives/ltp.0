Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1Mnfxi-0006M1-S7
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 21:53:22 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mnfxf-0008Jn-33
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 21:53:22 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8FLqO3J014789
	for <Ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 17:52:24 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8FLr8kw253980
	for <Ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 17:53:08 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8FLr73W011526
	for <Ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 17:53:08 -0400
Date: Tue, 15 Sep 2009 14:53:07 -0700
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20090915215307.GD10922@count0.beaverton.ibm.com>
References: <alpine.LRH.2.00.0909151730320.29846@vixen.sonytel.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.0909151730320.29846@vixen.sonytel.be>
Subject: Re: [LTP] [PATCH] Filecaps: Update error message for recent kernels
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>, Serge Hallyn <serue@linux.vnet.ibm.com>

On Tue, Sep 15, 2009 at 05:30:55PM +0200, Geert Uytterhoeven wrote:
>    - As of 2.6.24, `capability' can no longer be a module,
>    - As of 2.6.27, CONFIG_SECURITY_CAPABILITIES no longer exists.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  .../kernel/security/filecaps/checkforfilecaps.sh   |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/security/filecaps/checkforfilecaps.sh b/testcases/kernel/security/filecaps/checkforfilecaps.sh
> index 20f97f5..3f6a4ec 100755
> --- a/testcases/kernel/security/filecaps/checkforfilecaps.sh
> +++ b/testcases/kernel/security/filecaps/checkforfilecaps.sh
> @@ -23,8 +23,7 @@ check_simple_capset
>  ret=$?
>  if [ $ret -ne 0 ]; then
>  	echo Posix capabilities not compiled into the kernel.  Please
> -	echo modprobe capability or recompile your kernel with
> -	echo CONFIG_SECURITY_CAPABILITIES=y.
> +	echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=y.

Then the advice is incorrect for older kernels. If LTP should still run
nicely for users of older kernels then perhaps something like this is better:

-	echo modprobe capability or recompile your kernel with
-	echo CONFIG_SECURITY_CAPABILITIES=y.
+	if tst_kvercmp 2 6 24 ; then
+		echo modprobe capability or recompile your kernel with
+		echo CONFIG_SECURITY_CAPABILITIES=y.
+	elif tst_kvercmp 2 6 27 ; then
+		echo recompile your kernel with CONFIG_SECURITY_CAPABILITIES=y.
+	else
+		echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=y.
+	fi

Cheers,
	-Matt Helsley

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
