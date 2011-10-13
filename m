Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1REKbJ-0007Fe-9h
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 12:41:29 +0000
Date: Thu, 13 Oct 2011 14:45:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111013124503.GB23592@saboteur.suse.cz>
References: <6b1be13a5797d4c5bc9343f5c84d5e14bcc705f5.1317115609.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b1be13a5797d4c5bc9343f5c84d5e14bcc705f5.1317115609.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] mm/vma01: remove useless mmap
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> addr v has been proved unless in test case, so remove it in this patch.
> Also a tst_resm/printf would call mmap() which might cause noise in this
> test, remove it as well.

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
