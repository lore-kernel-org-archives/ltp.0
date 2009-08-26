Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MgBzn-0007hL-9T
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 06:28:35 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgBzi-0005ML-Dd
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 06:28:35 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7Q6WYFO004239
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Aug 2009 02:32:34 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7Q6SONv217494
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Aug 2009 02:28:24 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7Q6SOTT027737
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Aug 2009 02:28:24 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090826055713.GA22281@us.ibm.com>
References: <20090826055713.GA22281@us.ibm.com>
Date: Wed, 26 Aug 2009 11:57:54 +0530
Message-Id: <1251268075.4895.9.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/1] netns: don't run sysfsview testcase
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Wed, 2009-08-26 at 00:57 -0500, Serge E. Hallyn wrote:
> It can't pass right now, and leaves the system in a bad state on
> its inevitable failure.
> 
> Leave the testcase there though since one day we will hopefully
> support it.
> 
> Signed-off-by: Serge Hallyn <serge@us.ibm.com>

Ok. Merged.

Regards--
Subrata

> ---
>  testcases/kernel/containers/netns/runnetnstest.sh |   25 ++++++++++++--------
>  1 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/containers/netns/runnetnstest.sh b/testcases/kernel/containers/netns/runnetnstest.sh
> index 8a52e7b..e5ae694 100755
> --- a/testcases/kernel/containers/netns/runnetnstest.sh
> +++ b/testcases/kernel/containers/netns/runnetnstest.sh
> @@ -90,16 +90,21 @@ else
>  fi
>  echo
> 
> -sysfsview
> -rc=$?
> -if [ $rc -ne 0 ]; then
> -    exit_code=$rc
> -    errmesg="$errmesg sysfsview: return code is $exit_code ; "
> -    echo $errmesg
> -else
> -   echo "sysfsview: PASS"
> -fi
> -echo
> +# sysfs tagging does not exist, so this test can't pass.  In
> +# fact at the moment it fails when mount -t sysfs none /sys is
> +# refused, fails in a bad state, leaving the system hard to
> +# reboot.  Revisit enabling this test when per-container sysfs
> +# views are supported.
> +#sysfsview
> +#rc=$?
> +#if [ $rc -ne 0 ]; then
> +#    exit_code=$rc
> +#    errmesg="$errmesg sysfsview: return code is $exit_code ; "
> +#    echo $errmesg
> +#else
> +#   echo "sysfsview: PASS"
> +#fi
> +#echo
> 
>  par_chld_ftp
>  rc=$?


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
