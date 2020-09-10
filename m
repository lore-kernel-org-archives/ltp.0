From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Sep 2020 20:54:09 +0800
Subject: [LTP] [PATCH v4] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <20200910095542.GA4275@yuki.lan>
References: <20200910093532.20223-1-liwang@redhat.com>
 <20200910095542.GA4275@yuki.lan>
Message-ID: <CAEemH2eFR63=G-sJyRPv+KwAELh3ukCoZ4NMUsDFQcM=oCNc-A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +     child_pid = SAFE_FORK();
> > +     if (!child_pid)
> > +             grow_stack(stack, stack_size, stack - stack_size +
> UNITS(1));
>
> Why don't we allocate the stack here in the child process? That way we
> can also get rid of the cleanup() function.
>

Ok, that's no problem.


> Also when we are at it, can we also add a second test where we mmap() a
> page in the space the stack is supposed to grow into i.e. do
> allocate_stack() then mmap() a page in the free address space and check
> that the child is killed by a SIGSEGV?
>

Sure, it is a strict way to verify everything goes well with
MAP_GROWSDOWN:).
And to guarantee SIGSEGV, it needs mapping into the address higher than the
(void *)(stack - stack_size), because older kernel set 'stack_guard_gap' as
1 page.

I'll try this in V5 tomorrow.


>
> > +     SAFE_WAIT(&wstatus);
> > +     if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0)
> > +             tst_res(TPASS, "Stack grows in unmapped region");
> > +     else if (WIFSIGNALED(wstatus))
> > +             tst_res(TFAIL, "Child killed by %s",
> tst_strsig(WTERMSIG(wstatus)));
>
> There is no point in this else if and tst_res(), the tst_strstatus() will
> print that info
> for you.
>
Agree.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200910/9891e1ea/attachment.htm>
