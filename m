Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mxi2X-0003Os-S9
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:07:49 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxi2S-0005MW-E2
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:07:49 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1254228745.3843.10.camel@dyn9002018117.watson.ibm.com>
References: <1254228745.3843.10.camel@dyn9002018117.watson.ibm.com>
Date: Tue, 13 Oct 2009 17:43:31 +0530
Message-Id: <1255436011.8438.33.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] IMA tcb policy
Reply-To: subrata@linux.vnet.ibm.com
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Tue, 2009-09-29 at 08:52 -0400, Mimi Zohar wrote: 
> Dependency section update.
> 
> Signed-off-by: Mimi Zohar <zohar@us.ibm.com>

Thanks Mimi.

Regards--
Subrata

> 
> Index: ltp-full-20090831/testcases/kernel/security/integrity/ima/README
> ===================================================================
> --- ltp-full-20090831.orig/testcases/kernel/security/integrity/ima/README
> +++ ltp-full-20090831/testcases/kernel/security/integrity/ima/README
> @@ -46,11 +46,13 @@ CONFIG_IMA_LSM_RULES=y
> 
>  Dependency
>  ----------
> -The testsuite is dependent on the default policy being enabled, which
> +The testsuite is dependent on the default TCB policy being enabled, which
>  measures all executables, all files mmapped for execute and all files
> -open for read by root. If the default policy has been replaced, loading
> -another measurement policy will fail, as the policy may only be replaced
> -once per boot. Some of the policy dependency tests might also fail as well.
> +open for read by root.  For kernels 2.6.31 and greater, enable the
> +trusted computing base(TCB) policy using the ima_tcb=1 boot parameter.
> +If the TCB policy has been replaced, loading another measurement
> +policy will fail, as the policy may only be replaced once per boot.
> +Some of the policy dependency tests might also fail as well.
> 
>  ima_tpm.sh: test02, verifying the PCR-10 value, requires a hard reboot.
>  [On Ubuntu, before running the ltp tests, disable /etc/init.d/kexec-load
> 
> 


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
