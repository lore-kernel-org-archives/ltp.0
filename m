Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwZqE-0006aA-Mj
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 13:19:30 +0000
Date: Thu, 25 Aug 2011 15:24:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825132441.GA16393@saboteur.suse.cz>
References: <mailman.321379.1313481992.22889.ltp-list@lists.sourceforge.net>
	<CAPt5XBfBW2-mTXVYR=B-mbaN2pCPG0UGa7vm0Bb2X7G6pyqRMA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPt5XBfBW2-mTXVYR=B-mbaN2pCPG0UGa7vm0Bb2X7G6pyqRMA@mail.gmail.com>
Subject: Re: [LTP] Ltp-list Digest, Vol 63, Issue 22
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
To: hake huang <hakehuang@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I test LTP in arm, cortex-a9 which is 4 core system, and find that the mmap1
> of memtest06, failed. when I check the LTP mail list and find this patch
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10706.html
> however, when I apply this patch, I can still see the same problem but with
> less frequency. It looks like the write process and read process are running
> on different core, when write process unmap and remap the address, and the
> other process is read at the same time.
> 
> So any suggestions?

There is probably a race condition, what is exact output from the test
on the failure?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
