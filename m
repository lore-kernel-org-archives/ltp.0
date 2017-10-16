From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 16 Oct 2017 12:47:48 -0700
Subject: [LTP] [PATCH v2 3/4] syscalls/keyctl07: new test for oops when
 reading negative key
In-Reply-To: <20171016102259.GB29957@rei>
References: <20171012204227.116510-1-ebiggers3@gmail.com>
 <20171012204227.116510-4-ebiggers3@gmail.com>
 <20171016102259.GB29957@rei>
Message-ID: <20171016194748.GE121701@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Oct 16, 2017 at 12:22:59PM +0200, Cyril Hrubis wrote:
> Hi!
> I've pushed all patches but this one, since it actually looks like a
> test bug when we oops the kernel since the test gets SIGKILL, which is
> the same signal the library uses for a timeout:
> 
>  $ ./keyctl07
>  tst_test.c:958: INFO: Timeout per run is 0h 05m 00s
>  keyctl07.c:72: INFO: trying to read from the negative key...
>  tst_test.c:1008: INFO: If you are running on slow machine, try
>  exporting LTP_TIMEOUT_MUL > 1
>  tst_test.c:1009: BROK: Test killed! (timeout?)
> 
> Can we, pretty please, run the test in a child process and wait it in
> the test function and report a failure instead? I fear that kind of test
> output will confuse people into thinking that this is a test problem
> rather than a kernel bug.
> 

Hi Cyril, I'll send out a new version that does that.  But please check that I'm
handling the exit status from the child process correctly because I wasn't 100%
sure how to do it.  (And I'm surprised more tests haven't run into this problem.
Maybe there should be something in the library for this, like being able to set
'.fail_on_sigkill = 1' in the 'struct tst_test'?  Or at least a different
version of tst_reap_children().)

Eric
