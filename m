Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R1Hpw-0000Sr-J3
	for ltp-list@lists.sourceforge.net; Wed, 07 Sep 2011 13:06:40 +0000
Date: Wed, 7 Sep 2011 15:07:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110907130706.GC31361@saboteur.suse.cz>
References: <4E660F57.6050608@linux.vnet.ibm.com> <4E66135F.9050001@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E66135F.9050001@redhat.com>
Subject: Re: [LTP] [Patch v2 1/4] KSM test case fixes - ksm01
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >--- ltp.orig/testcases/kernel/mem/ksm/ksm01.c	2011-09-05 08:42:12.000000000 +0200
> >+++ ltp/testcases/kernel/mem/ksm/ksm01.c	2011-09-06 13:48:56.000000000 +0200
> >@@ -109,6 +109,8 @@ void setup(void)
> >
> >  	tst_sig(FORK, DEF_HANDLER, NULL);
> >  	TEST_PAUSE;
> >+        if( access( PATH_KSM, F_OK ) == -1 )
> >+                tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
> 
> Hi, sorry I still have some comments to the new version of 1/4 and 2/4.
> 
> format corrections:
> 
> 1. use tab instead of 8 spaces
> 2. space after "if" and no space inside round backets
> 
> (you may want to check the style-guide in LTPROOT/doc/style-guide.txt)
> 
> And I suggest put this if-condtion before tst_sig(). Cyril, any comments?

LTP uses LKML coding style and you can use the checkpatch.pl script
packed with kernel sources (reasonably new sources are needed) to check
that your patch is clean.

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
