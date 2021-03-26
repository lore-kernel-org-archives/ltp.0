From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 26 Mar 2021 11:43:02 +0100
Subject: [LTP] [PATCH v2 1/1] brk02: Add test for removing more than one
 VMA
In-Reply-To: <CAEemH2fOBjn-HkcrDZAam1YZkKLm1rLwOnG-KoGGjRQH59e3Pg@mail.gmail.com>
References: <20210224213114.2976705-1-Liam.Howlett@Oracle.com>
 <20210224213114.2976705-2-Liam.Howlett@Oracle.com>
 <CAEemH2cKR98HvHZ6OYJpLpaX9-5hfhTak650=DtU-q2Yoo6kbA@mail.gmail.com>
 <20210323162714.t5dm5vbo35vl4t2l@revolver>
 <CAEemH2fnyB_dGzQWUb7SBi9S01vYGXaZBczj2ZwaYF-Rqv9UsA@mail.gmail.com>
 <20210325131545.jwrzhdy474utqjpa@revolver>
 <CAEemH2fOBjn-HkcrDZAam1YZkKLm1rLwOnG-KoGGjRQH59e3Pg@mail.gmail.com>
Message-ID: <YF26tr2CKGSjRsq5@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Liam, Li,

> > This was my test platform.  I also sent it to the Travis CI which passed
> > for x86_64.  I will re-examine the accepted code to ensure the cosmetic
> > changes didn't invalidate my testing.

> FWIK, the Travis CI does not run test case, it just compiles/builds LTP
> across
> many arches/platforms.

Yes, while KernelCI and some enterprise / embedded distros for their kernels run
LTP testcases, the project does not run it. Cyril run some regression tests for
few most important runtests before release manually. But having a server it'd be
handy to run them.

Kind regards,
Petr
