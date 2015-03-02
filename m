Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YSS34-0005MA-Vy
	for ltp-list@lists.sourceforge.net; Mon, 02 Mar 2015 15:14:23 +0000
Date: Mon, 2 Mar 2015 16:13:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150302151337.GB22136@rei>
References: <1424764001.2546.15.camel@G08JYZSD130126.localdomain>
	<20150226090012.GA12353@rei.suse.de>
	<1425016398.11179.22.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1425016398.11179.22.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH v2] gethostbyname_r01: check whether a system is
 vulnerable or not.
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
> Qualys security researchers discovered a serious weakness in the Linux glibc
> library:
> https://www.qualys.com/research/security-advisories/GHOST-CVE-2015-0235.txt
> 
> We write this test to check wherher a system is vulnerable or not.

Looks good to me.

Jan: What do we do about the syscalls/libcalls issue? Do we keep the
     status quo and apply this one as it is? Anybody has a better idea?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
