Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YQuij-0003gF-JH
	for ltp-list@lists.sourceforge.net; Thu, 26 Feb 2015 09:27:01 +0000
Date: Thu, 26 Feb 2015 10:26:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150226092622.GB13122@rei.suse.de>
References: <1424764001.2546.15.camel@G08JYZSD130126.localdomain>
	<20150226090012.GA12353@rei.suse.de>
	<1449902344.19156887.1424942209488.JavaMail.zimbra@redhat.com>
	<20150226092313.GA13122@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150226092313.GA13122@rei.suse.de>
Subject: Re: [LTP] [PATCH] gethostbyname_r01: check whether a system is
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> Well, it kind of is. On the other hand we have glibc testcases under
> kernel/syscalls allready, see string/string01.c, memset/memset01.c ...
> 
> If you want to go ahead and start runtest/libc, testcases/libc and move
> all the libc tests there I'm all for it.

On the other hand, I'm not sure where to draw the line.

For example mutexes are implemented in glibc but they end up calling
futex_wait() and futex_wake() which is kernel syscall. Where does these
testcases belong to?

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
