Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YxXYg-0006tT-Mf
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 09:23:30 +0000
Date: Wed, 27 May 2015 11:22:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150527092237.GA9075@rei>
References: <1815411283.124861432698468787.JavaMail.weblogic@epmlwas05a>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1815411283.124861432698468787.JavaMail.weblogic@epmlwas05a>
Subject: Re: [LTP] [PATCH]: Fix dprt() function call by adding gettid()
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
To: Manjeet Pawar <manjeet.p@samsung.com>
Cc: ltp-list@lists.sourceforge.net, Yogesh Narayan Gaur <yn.gaur@samsung.com>

Hi!
> This patch adds missing gettid() function call in dprt
> 
> Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
> Reviewed-by: Yogesh Gaur <yn.gaur@samsung.com>

This has been fixed a few days ago by:

commit 16ff436309f47503338ed07ef95523cd5d6092dc
Author: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
Date:   Wed May 13 19:19:46 2015 +0800

    network/nfs/nfsstress: fix printf format

    format string requires 2 parameters but only 1 is given

    Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>



Thanks for the effort anyway. :)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
