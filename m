Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WZihF-0006v1-L0
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 15:21:21 +0000
Date: Mon, 14 Apr 2014 17:20:35 +0200
From: chrubis@suse.cz
Message-ID: <20140414152035.GA15381@rei.suse.cz>
References: <1395845334-8976-1-git-send-email-alexey.kodanev@oracle.com>
	<20140410153941.GA25778@rei> <534BDF7A.5080409@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <534BDF7A.5080409@oracle.com>
Subject: Re: [LTP] [PATCH v7] network: tcp_fastopen: add TCP Fast Open test
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
> > You pass the offset as a pointer but do not modify the value. Forgot to
> > change it when the code around changed?
> 
> I think so. Also I could remove offset from this function and pass "buf" 
> and "buf_size" to it with applied offset.

I do not care that much if the offset is added up in the function or by
the caller, either one is fine.

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
