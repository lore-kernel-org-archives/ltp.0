From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 May 2019 12:43:11 +0200
Subject: [LTP] [EXT] Re: [PATCH v9 00/24] ILP32 for ARM64
In-Reply-To: <MN2PR18MB30865B950D85C6463EB0E1D4CB0F0@MN2PR18MB3086.namprd18.prod.outlook.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20190508225900.GA14091@yury-thinkpad> <mvmtvdyoi33.fsf@suse.de>
 <MN2PR18MB30865B950D85C6463EB0E1D4CB0F0@MN2PR18MB3086.namprd18.prod.outlook.com>
Message-ID: <20190514104311.GA24708@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > There is a problem with the stack size accounting during execve when
> > there is no stack limit:
> >
> > $ ulimit -s
> > 8192
> > $ ./hello.ilp32 
> > Hello World!
> > $ ulimit -s unlimited
> > $ ./hello.ilp32 
> > Segmentation fault
> > $ strace ./hello.ilp32 
> > execve("./hello.ilp32", ["./hello.ilp32"], 0xfffff10548f0 /* 77 vars */) = -1 ENOMEM (Cannot allocate memory)
> > +++ killed by SIGSEGV +++
> > Segmentation fault (core dumped)
> >
> > Andreas.
> 
> Thanks Andreas, I will take a look. Do we have such test in LTP?

We do have a test that we can run a binary with very small stack size
i.e. 512kB but there does not seem to be anything that would catch this
specific problem.

Can you please open an issue and describe how to reproduce the problem
at our github tracker:

https://github.com/linux-test-project/ltp/issues

Then we can create testcase based on that reproducer later on.

-- 
Cyril Hrubis
chrubis@suse.cz
