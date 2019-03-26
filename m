From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Mar 2019 13:51:32 +0100
Subject: [LTP] [RFC PATCH 1/4] syscalls/abort01: convert to new library
In-Reply-To: <20190326124743.GC5826@google.com>
References: <20190325232012.67123-1-sspatil@android.com>
 <20190325232012.67123-2-sspatil@android.com>
 <20190326115825.GA32549@rei.lan> <20190326124743.GC5826@google.com>
Message-ID: <20190326125132.GA11086@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > * Got rid of tst_brk(TFAIL, ...) calls
> >   see: https://github.com/linux-test-project/ltp/issues/462
> 
> Thanks for this, it is good to know. What is the recommended replacement?
> tst_res()?

Yes, tst_res() followed by either return or exit(0) if you need to
actually exit the code flow.

> > 
> > * Used tst_strsig() and tst_strstatus() to print signal and status
> > 
> > * Used tst_res() API in the child
> > 
> > * Got rid of unused variables, etc.
> 
> I am surprised that didn't throw a warning + build error for me.
> other than that, thanks for doing this

That depends on gcc version and mix of warning flags...

-- 
Cyril Hrubis
chrubis@suse.cz
