From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Sep 2019 08:29:10 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/bpf: auto bump RLIMIT_MEMLOCK
In-Reply-To: <20190926121744.GC13769@rei.lan>
References: <a9fc2ff0c27317ae8ac2d56a819eeac5a281dd86.1569496399.git.jstancek@redhat.com>
 <20190926121744.GC13769@rei.lan>
Message-ID: <278524783.2287755.1569500950109.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > eBPF tests may fail (-EPERM) if max locked memory limit is too low.
> > User-space tools such as perf started increasing MELOCK limit to
> > avoid this problem.
> > 
> > LTP follows same approach and will attempt to raise RLIMIT_MEMLOCK
> > if possible, otherwise prints an info message.
> > 
> > Link: http://lists.linux.it/pipermail/ltp/2019-August/013349.html
> > Link: https://lkml.org/lkml/2019/7/17/714
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> 
> Looks good, acked.

Thanks, pushed with typo above fixed: s/MELOCK/MEMLOCK/.

> 
> Also have you had a look at the eBPF regression test?
> 
> Do you mind if I push that before the release (with added call to adjust
> the memlock limit)?

If you mean "Regression test for 64bit arithmetic", I think that's OK for release.

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
