Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1URjNj-0007QX-Qb
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 13:23:39 +0000
Date: Mon, 15 Apr 2013 15:24:21 +0200
From: chrubis@suse.cz
Message-ID: <20130415132421.GE1091@rei>
References: <515EA506.8060305@linux.vnet.ibm.com>
	<51621625.6000507@cn.fujitsu.com>
	<5163BCCC.90909@linux.vnet.ibm.com>
	<516B70F5.8080100@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <516B70F5.8080100@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] runltp: syscalls/mount0* and inotify03 tests are
 getting skipped from runltp's execution
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
Cc: ltp-list@lists.sourceforge.net, Ramesh <rameshyr@linux.vnet.ibm.com>

Hi!
> > Signed-off-by: Ramesh YR <rameshyr@linux.vnet.ibm.com>
> 
> Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> 
> 
> Any other objections?

The patch logic looks fine.

The only thing that doesn't look 100% right are the overly long lines
(which could be fixed by splitting the messages and print each sentence
 with it's own echo).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
