Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NeMnx-0007TY-0P
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 06:09:05 +0000
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NeMnv-00049V-IL
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 06:09:04 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp04.in.ibm.com (8.14.3/8.13.1) with ESMTP id o1868thm013328
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 11:38:55 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1868tw52732280
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 11:38:55 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1868tep023521
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 17:08:55 +1100
Message-ID: <4B6FAA76.6000505@linux.vnet.ibm.com>
Date: Mon, 08 Feb 2010 11:38:54 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4B6FA8F0.6050504@cn.fujitsu.com>
In-Reply-To: <4B6FA8F0.6050504@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] cap_bound: should to TBROK if f != CAP_SET in
	exec_without_inh.c
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On 02/08/2010 11:32 AM, Shi Weihua wrote:
> An error occured on my i386 box.
>   (OS: Fedora8, Kernel: 2.6.33-rc6, libcap: libcap-2.16)
> -------------
> exec_without_inh    1  TFAIL  :  Failed to drop CAP_SYS_ADMIN from bounding set.
> exec_without_inh    0  TINFO  :  (ret=-1, errno 38)
> -------------
> If the macro HAVE_DECL_CAP_BSET_DROP is 0, this error will occurs.
> But the program should to be broken when f != CAP_SET, like the similar code
> "if (ret || f != CAP_SET) {" in exec_with_inh.c.
>
> The TBROK message will be outputted if my patch merged.
> -------------
> exec_without_inh    1  TBROK  :  Failed to add CAP_SYS_ADMIN to pI
>    
Looks good. I will include if others are not having any comment.

Acked-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

Thanks
Rishi

> -------------
>
> Signed-off-by: Shi Weihua<shiwh@cn.fujitsu.com>
> ---
> --- testcases/kernel/security/cap_bound/exec_without_inh.c.orig	2010-02-08 11:54:22.000000000 -0500
> +++ testcases/kernel/security/cap_bound/exec_without_inh.c	2010-02-08 11:55:00.000000000 -0500
> @@ -80,6 +80,11 @@ int main(int argc, char *argv[])
>   			tst_exit();
>   		}
>   	}
> +	else if (ret) {
> +		tst_resm(TBROK, "Failed to add CAP_SYS_ADMIN to pI\n");
> +		tst_exit();
> +	}
> +
>   #if HAVE_DECL_CAP_FREE
>   	cap_free(cur);
>   #endif
>
> ------------------------------------------------------------------------------
> The Planet: dedicated and managed hosting, cloud storage, colocation
> Stay online with enterprise data centers and the best network in the business
> Choose flexible plans and management services without long-term contracts
> Personal 24x7 support from experience hosting pros just a phone call away.
> http://p.sf.net/sfu/theplanet-com
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>    


------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
