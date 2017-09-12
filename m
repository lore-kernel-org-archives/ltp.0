From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Sep 2017 08:46:50 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/shmat01: avoid dumping corefile for
 expected crash
In-Reply-To: <20170912091548.GC13765@rei>
References: <8df1dcaee102405b65fb575744323b3dfb348de1.1505129509.git.jstancek@redhat.com>
 <20170911115349.GA22586@rei.lan>
 <154541893.12328039.1505131686278.JavaMail.zimbra@redhat.com>
 <20170911122114.GB22586@rei.lan> <20170912091548.GC13765@rei>
Message-ID: <592097599.13745862.1505220410557.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > 1 is a special case, that disables also coredump-into-pipe,
> > > and it also happens to be small enough to skip coredump-to-file.
> > > 
> > > fs/coredump.c:
> > >   "if (cprm.limit == 1) {"
> > > 
> > > > The manual says that when we set it to 0 no core file are created. I
> > > > find that better than setting it to 1 which supposedly creates 1 byte
> > > > file...
> > > 
> > > That shouldn't happen because of this check:
> > >   if (cprm.limit < binfmt->min_coredump)
> > 
> > I guess that we should get the setrlimit manual page update then.
> > 
> > Looking at the kernel code it will skip the core-file creation silently
> > unless the minimal size > PAGE_SIZE for most of the binfmt handlers.
> 
> Also consider the patch acked, but please add a bit more descriptive
> commit message, i.e. why the limit is set to 1 and not 0.

Pushed with extra comment.

Regards,
Jan
