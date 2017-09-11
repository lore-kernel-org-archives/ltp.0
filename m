From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Sep 2017 08:08:06 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/shmat01: avoid dumping corefile for
 expected crash
In-Reply-To: <20170911115349.GA22586@rei.lan>
References: <8df1dcaee102405b65fb575744323b3dfb348de1.1505129509.git.jstancek@redhat.com>
 <20170911115349.GA22586@rei.lan>
Message-ID: <154541893.12328039.1505131686278.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> I guess that this is optimization that speeds up the test, right?

That as well, but main reason is our automation, which scans
for "unexpected corefiles". There is a blacklist, however this
testcase mixes crashing/non-crashing inputs, so I wanted to
avoid any corefiles and keep it off blacklist.

> 
> > -static void do_child(int *in_addr)
> > +static void do_child(int *in_addr, int expect_crash)
> >  {
> > +	if (expect_crash) {
> > +		/* crash is expected, avoid dumping corefile */
> > +		struct rlimit r;
> > +
> > +		r.rlim_cur = 1;
> > +		r.rlim_max = 1;
> > +		SAFE_SETRLIMIT(RLIMIT_CORE, &r);
> 
> Hmm, why not 0?

1 is a special case, that disables also coredump-into-pipe,
and it also happens to be small enough to skip coredump-to-file.

fs/coredump.c:
  "if (cprm.limit == 1) {"

> 
> The manual says that when we set it to 0 no core file are created. I
> find that better than setting it to 1 which supposedly creates 1 byte
> file...

That shouldn't happen because of this check:
  if (cprm.limit < binfmt->min_coredump)

Regards,
Jan
