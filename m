Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WS8PX-0000bh-C1
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 17:11:43 +0000
Date: Mon, 24 Mar 2014 18:11:18 +0100
From: chrubis@suse.cz
Message-ID: <20140324171118.GA6954@rei.suse.cz>
References: <1392731616-25514-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392731616-25514-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] lib/tst_res.c: synchronize access to tst_res
 functions
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> The patch adds synchronization mechanism which is required (tst_res.c
> uses global variables e.g. T_exitval, tst_count, T_out, ...) when tst_res
> functions are used in multi-threaded tests.
> Note: it will only work if test is linked with pthread library, also some
> functions include each other that is why recursive mutex is used (can be
> locked several times by the same thread).

I've reworded the commit message a bit to make it (hopefully) more
clear and pushed the change. Thanks.

PS: Can you add a paragraph about thread safety and about the once
    callback macro to test-writing-guidelines or should I write it?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
