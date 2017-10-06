From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 6 Oct 2017 13:37:44 +0200
Subject: [LTP] [PATCH 2/2] security/dirtyc0w: synchronize parent and
	child
In-Reply-To: <47778538.26248540.1507119900299.JavaMail.zimbra@redhat.com>
References: <94518262a76edca533440acb73611eb93184dc90.1507113734.git.jstancek@redhat.com>
 <1300ca0b5103f4f145af3be1a0295974a04dcae8.1507113734.git.jstancek@redhat.com>
 <20171004120240.GA29423@rei>
 <47778538.26248540.1507119900299.JavaMail.zimbra@redhat.com>
Message-ID: <20171006113744.GA8258@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +static const char *const resource_files[] = {
> > > +	TEST_APP,
> > > +	NULL,
> > > +};
> > 
> > I do not get why we need the test binary to be listed as resource file,
> > the rest seems OK to me.
> 
> Since the test is using tmpdir, we either need exec*p* variant and
> set PATH or copy binary to tmpdir. I took inspiration from creat07.

We actually copy the binary for creat07 since are are trying to
overwrite it, which is supposed to fail, but I do not want to overwrite
the installed files in a case that the kernel is buggy.

> Copy approach is slightly more convenient when running test from git tree:
> # ./dirtyc0w
> 
> But I can replace it with execvpe() - user would just need to setup PATH
> before running it from git tree:
> # env PATH=`pwd`:$PATH ./dirtyc0w

You are supposed to do that, but maybe we can add the code to change
PATH to the test library itself, so it will include $PWD automatically,
which would fix this problem for quite a lot of test without a need to
modify these. Or add a modified exec function to the test library that
locates the binary first.

-- 
Cyril Hrubis
chrubis@suse.cz
