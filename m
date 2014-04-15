Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wa0Pr-0003qg-Sc
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 10:16:35 +0000
Date: Tue, 15 Apr 2014 12:15:49 +0200
From: chrubis@suse.cz
Message-ID: <20140415101549.GA13512@rei>
References: <1397552535-6822-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397552535-6822-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH] containers/netns:parameters are not correct when
 calling crtchild() function
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
To: shuang.qiu@oracle.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> The numbers of parameters for crtchild() function which called in
> two_children_ns.c and par_chld_ipv6.c is not correct.And it will make
> the child process to be a zombie process.

Can you please create proper header file (common.h) and move the
function prototype there and include it in both common.c and the tests
that use it?

Because otherwise the code may break again if sommebody forgets to
change all occurences.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
