From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Apr 2016 14:51:03 +0200
Subject: [LTP] duplicated runltp options
In-Reply-To: <447366764.328002.1461669576415.JavaMail.zimbra@redhat.com>
References: <20160426110743.GA6766@rei.lan>
 <447366764.328002.1461669576415.JavaMail.zimbra@redhat.com>
Message-ID: <20160426125102.GC6766@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > And since nobody reported the problem so far, I guess that -T for
> > repetition wasn't widely used. So I would like to fix that by renaming
> > the -T REPETIONT to  -I ITERATIONS. Does that sound reasonably?
> 
> It does to me, code seems to call it as "iteration" already:
>   echo "Test Tags will be Prepended with ITERATION NO.s....."

Fix pushed.

-- 
Cyril Hrubis
chrubis@suse.cz
