From: Liam Howlett <liam.howlett@oracle.com>
Date: Fri, 26 Mar 2021 16:13:54 +0000
Subject: [LTP] [PATCH v2 1/1] brk02: Add test for removing more than one
 VMA
In-Reply-To: <YF26tr2CKGSjRsq5@pevik>
References: <20210224213114.2976705-1-Liam.Howlett@Oracle.com>
 <20210224213114.2976705-2-Liam.Howlett@Oracle.com>
 <CAEemH2cKR98HvHZ6OYJpLpaX9-5hfhTak650=DtU-q2Yoo6kbA@mail.gmail.com>
 <20210323162714.t5dm5vbo35vl4t2l@revolver>
 <CAEemH2fnyB_dGzQWUb7SBi9S01vYGXaZBczj2ZwaYF-Rqv9UsA@mail.gmail.com>
 <20210325131545.jwrzhdy474utqjpa@revolver>
 <CAEemH2fOBjn-HkcrDZAam1YZkKLm1rLwOnG-KoGGjRQH59e3Pg@mail.gmail.com>
 <YF26tr2CKGSjRsq5@pevik>
Message-ID: <20210326161348.vcztygn5kb5ki2hn@revolver>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Petr Vorel <pvorel@suse.cz> [210326 06:43]:
> Hi Liam, Li,
> 
> > > This was my test platform.  I also sent it to the Travis CI which passed
> > > for x86_64.  I will re-examine the accepted code to ensure the cosmetic
> > > changes didn't invalidate my testing.
> 
> > FWIK, the Travis CI does not run test case, it just compiles/builds LTP
> > across
> > many arches/platforms.
> 
> Yes, while KernelCI and some enterprise / embedded distros for their kernels run
> LTP testcases, the project does not run it. Cyril run some regression tests for
> few most important runtests before release manually. But having a server it'd be
> handy to run them.


Thank you for clarification.  What is the best way to re-test my
changes?  As I had said, I made a change that will not add EXEC but will
still test removal of more than one VMA.  We cannot just mprotect
PROT_READ|PROT_WRITE as this will allow VMA merging to occur.  My
solution is to change the anon vma to just PROT_READ.  It passes in my
x86_64 test but since that was the case for me regardless, I cannot say
that I have fixed the issue, but I have verified that the test still
does what I expect it to do.


Thanks,
Liam

Patch below.
-------------------------------------------

+++ b/testcases/kernel/syscalls/brk/brk02.c
@@ -36,8 +36,7 @@ void brk_down_vmas(void)
                return;
        }
 
-       if (mprotect(addr - page_size, page_size,
-                    PROT_READ|PROT_WRITE|PROT_EXEC)) {
+       if (mprotect(addr - page_size, page_size, PROT_READ)) {
                tst_res(TFAIL, "Cannot mprotect new VMA");
                return;
        }

