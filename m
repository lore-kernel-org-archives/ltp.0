Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Whd86-0007fG-Ma
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 11:01:46 +0000
Date: Tue, 6 May 2014 13:00:48 +0200
From: chrubis@suse.cz
Message-ID: <20140506110048.GC6403@rei.Home>
References: <1396350731.10607.12.camel@G08JYZSD130126>
	<20140505163249.GD11256@rei>
	<1399373430.3177.55.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399373430.3177.55.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] readdir/readdir03.c: add new error number testes
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
> > > +char *TCID = "readdir03";
> > > +
> > > +#if !defined __x86_64__
> > 
> > Why is the test disabled on x86_64? What about other 64 bit
> > architectures?
> > 
> 
> In syscall.h __NR_readdir only appears on NONE x86_64. It will fail when
> I make on x86_64:
> readdir03.c:122:15: error: ???__NR_readdir??? undeclared (first use in this
> function)
>   TEST(syscall(__NR_readdir, *test->fd, test->dirp, test->count));

We have testcases/kernel/include/linux_syscall_numbers.h and
ltp_syscall() to solve this problem.

Once this header is included, the syscall number will always be defined
and ltp_syscall() will return -1 and set errno to ENOSYS if syscall
wasn't implemented on the particular arch.

> > > +static void readdir_verify(const struct test_case_t *test)
> > > +{
> > > +	TEST(syscall(__NR_readdir, *test->fd, test->dirp, test->count));
> > 
> > So you are using raw readdir() syscall (man 2 readdir) instead of the
> > glibc readdir() (man 3 readdir).
> > 
> > Are you aware that the rest of the readdir testcases use the glibc
> > readdir()?
> > 
> 
> Yes, I am aware that.
> Could I create a new directory to do that or others?

Not necessarily. At least add a note about this in the comment at the
start of the testcase, and maybe we should start the test numbers at 21.

Moreover if you expect to create more than one testcase (which I expect
because the current one does not cover much) you should put the
old_linux_dirent structure definition into a header.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
