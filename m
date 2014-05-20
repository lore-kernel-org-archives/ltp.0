Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WmmP7-00081C-DQ
	for ltp-list@lists.sourceforge.net; Tue, 20 May 2014 15:56:37 +0000
Date: Tue, 20 May 2014 17:56:25 +0200
From: chrubis@suse.cz
Message-ID: <20140520155625.GB30538@rei.suse.cz>
References: <1398159613.2772.7.camel@G08JYZSD130126>
	<1398159660.2772.8.camel@G08JYZSD130126>
	<64087164.7823458.1398172479616.JavaMail.zimbra@redhat.com>
	<1398225094.3850.1.camel@G08JYZSD130126>
	<1398225176.3850.3.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398225176.3850.3.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 2/2] sbrk/sbrk02.c: add ENOMEM errno test
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +#if !defined(UCLINUX)

If none of the sbrk tests runs on uClinux the UCLINUX ifdefs should be
removed and the whole directory should be skipped on build and install.
(by adding into UCLINUX FILTER_OUT_DIRS in
testacses/kernel/syscalls/Makefile)

Otherwise the test looks fine.

Jan can you please tune the increments, remove the ifdefs and push into
git?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
