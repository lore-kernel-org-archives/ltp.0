Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdiYK-0002s7-Er
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 13:19:20 +0000
Date: Thu, 22 Dec 2011 14:29:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222132904.GH26303@saboteur.suse.cz>
References: <4ED5EA87.2010805@sx.jp.nec.com>
	<1322643045-6605-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1322643045-6605-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] ext4-online-defrag: use the e4defrag from local
	system
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: k-mio@sx.jp.nec.com, ltp-list@lists.sourceforge.net

Hi!
> Remove the out-of-dated e4defrag prog, and use the e4defrag
> we installed own.
> 
> Note:As Kazuya said, e4defrag here is too old to defrag the
> file in the latest kernel. We should use the latest e4defrag
> command that is contained in e2fsprogs. So, when testing,
> install the lastest e2fsprogs by self.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
