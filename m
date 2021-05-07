From: Li Wang <liwang@redhat.com>
Date: Fri, 7 May 2021 11:02:27 +0800
Subject: [LTP] [PATCH v2 1/1] brk02: Add test for removing more than one
 VMA
In-Reply-To: <20210326161348.vcztygn5kb5ki2hn@revolver>
References: <20210224213114.2976705-1-Liam.Howlett@Oracle.com>
 <20210224213114.2976705-2-Liam.Howlett@Oracle.com>
 <CAEemH2cKR98HvHZ6OYJpLpaX9-5hfhTak650=DtU-q2Yoo6kbA@mail.gmail.com>
 <20210323162714.t5dm5vbo35vl4t2l@revolver>
 <CAEemH2fnyB_dGzQWUb7SBi9S01vYGXaZBczj2ZwaYF-Rqv9UsA@mail.gmail.com>
 <20210325131545.jwrzhdy474utqjpa@revolver>
 <CAEemH2fOBjn-HkcrDZAam1YZkKLm1rLwOnG-KoGGjRQH59e3Pg@mail.gmail.com>
 <YF26tr2CKGSjRsq5@pevik> <20210326161348.vcztygn5kb5ki2hn@revolver>
Message-ID: <CAEemH2f0vBDuBPH9teZzmEhcfVLhm0ieK7qCZ5UDLTmyc61-5Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Laim and all,

On Sat, Mar 27, 2021 at 12:14 AM Liam Howlett <liam.howlett@oracle.com>
wrote:

> * Petr Vorel <pvorel@suse.cz> [210326 06:43]:
> > Hi Liam, Li,
> >
> > > > This was my test platform.  I also sent it to the Travis CI which
> passed
> > > > for x86_64.  I will re-examine the accepted code to ensure the
> cosmetic
> > > > changes didn't invalidate my testing.
> >
> > > FWIK, the Travis CI does not run test case, it just compiles/builds LTP
> > > across
> > > many arches/platforms.
> >
> > Yes, while KernelCI and some enterprise / embedded distros for their
> kernels run
> > LTP testcases, the project does not run it. Cyril run some regression
> tests for
> > few most important runtests before release manually. But having a server
> it'd be
> > handy to run them.
>
>
> Thank you for clarification.  What is the best way to re-test my
> changes?  As I had said, I made a change that will not add EXEC but will
>

No best way I guess, it would be great if you can do more arches
verification before patch sending, but then the maintainers would
help do that also.



> still test removal of more than one VMA.  We cannot just mprotect
> PROT_READ|PROT_WRITE as this will allow VMA merging to occur.  My
> solution is to change the anon vma to just PROT_READ.  It passes in my
> x86_64 test but since that was the case for me regardless, I cannot say
> that I have fixed the issue, but I have verified that the test still
> does what I expect it to do.
>

I'm fine with just test PROT_READ. And we can take this way to fix
the FAIL before the next LTP release.

But there is still a query in my mind, whether the FAIL I mentioned before
is a kernel bug or just caused by preventing process Self Modiefed Code,
that probably needs more investigation.



>
>
> Thanks,
> Liam
>
> Patch below.
> -------------------------------------------
>
> +++ b/testcases/kernel/syscalls/brk/brk02.c
> @@ -36,8 +36,7 @@ void brk_down_vmas(void)
>                 return;
>         }
>
> -       if (mprotect(addr - page_size, page_size,
> -                    PROT_READ|PROT_WRITE|PROT_EXEC)) {
> +       if (mprotect(addr - page_size, page_size, PROT_READ)) {
>                 tst_res(TFAIL, "Cannot mprotect new VMA");
>                 return;
>         }
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210507/5b376d68/attachment.htm>
