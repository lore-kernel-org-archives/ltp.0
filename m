Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YQyfh-0006EZ-IK
	for ltp-list@lists.sourceforge.net; Thu, 26 Feb 2015 13:40:09 +0000
Date: Thu, 26 Feb 2015 14:39:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150226133925.GA16136@rei.suse.de>
References: <1424764001.2546.15.camel@G08JYZSD130126.localdomain>
	<20150226090012.GA12353@rei.suse.de>
	<1449902344.19156887.1424942209488.JavaMail.zimbra@redhat.com>
	<20150226092313.GA13122@rei.suse.de>
	<20150226092622.GB13122@rei.suse.de>
	<1152905776.19309335.1424957443988.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1152905776.19309335.1424957443988.JavaMail.zimbra@redhat.com>
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
> > > If you want to go ahead and start runtest/libc, testcases/libc and move
> > > all the libc tests there I'm all for it.
> > 
> > On the other hand, I'm not sure where to draw the line.
> 
> For this particular regression test it seemed clear cut, but in general
> for functional and stress tests I don't a have good answer.

The most reasonable definition to me seems to call things that have very
thin wrapper in glibc or are called by syscall() to be syscall testcases
and the rest, even when they end up calling particular syscall to be
libc tests. But that is still wrong as any other simple definition.

The other simple and wrong option is to move everything that is
implemented purely in userspace to testcases/libc/.

Or we can stop pretending that there is a clear line between kernel and
libc and rename the syscalls to something else. The question is what
should be the new name, I do not have a good idea for that.

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
