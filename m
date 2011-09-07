Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R1HxK-0004IR-SY
	for ltp-list@lists.sourceforge.net; Wed, 07 Sep 2011 13:14:18 +0000
Date: Wed, 7 Sep 2011 15:14:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110907131451.GA32567@saboteur.suse.cz>
References: <4E661988.80303@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E661988.80303@linux.vnet.ibm.com>
Subject: Re: [LTP] [Patch v3 1/4] KSM test case fixes - ksm01
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
To: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Fixed format issues.

^ please write here short description of the problme that the patch is
  fixing. Somethink like "Disable ksm01 test if KSM is not supported"
  should do.

> Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> 
> -- 
> Regards
> R.Nageswara Sastry
> 

> --- ltp.orig/testcases/kernel/mem/ksm/ksm01.c	2011-09-05 08:42:12.000000000 +0200
> +++ ltp/testcases/kernel/mem/ksm/ksm01.c	2011-09-06 14:49:27.000000000 +0200
> @@ -106,6 +106,8 @@ void setup(void)
>  
>  	if (tst_kvercmp(2, 6, 32) < 0)
>  		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
> +	if(access( PATH_KSM, F_OK ) == -1)
> +		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
>  
>  	tst_sig(FORK, DEF_HANDLER, NULL);
>  	TEST_PAUSE;

Still there should be whitespace after the if and there shouldn't be
whitespaces on the inner side of the braces.

Could you pretty please use the checkpatch.pl script, that should save
both your and mine time ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Using storage to extend the benefits of virtualization and iSCSI
Virtualization increases hardware utilization and delivers a new level of
agility. Learn what those decisions are and how to modernize your storage 
and backup environments for virtualization.
http://www.accelacomm.com/jaw/sfnl/114/51434361/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
