Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UUDYZ-0005Oi-2w
	for ltp-list@lists.sourceforge.net; Mon, 22 Apr 2013 10:01:07 +0000
Date: Mon, 22 Apr 2013 12:01:58 +0200
From: chrubis@suse.cz
Message-ID: <20130422100158.GA3214@rei>
References: <515EA506.8060305@linux.vnet.ibm.com>
	<51621625.6000507@cn.fujitsu.com>
	<5163BCCC.90909@linux.vnet.ibm.com>
	<516CABFB.3030602@cn.fujitsu.com>
	<5174F86B.20601@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5174F86B.20601@linux.vnet.ibm.com>
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
To: Ramesh <rameshyr@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I think History part in runltp script needs to be updated to reflect the 
> changes.

Since we started to use git and make sure the commit messages describe
the change well the "History" stored in the files are not that relevant
anymore. If there is history that could not be found by 'git log filename'
it is kept. For new changes is updating the "History" is not recomended.

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
