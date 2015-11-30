From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Nov 2015 12:04:25 +0100
Subject: [LTP] How to identify all LTP tests needing block device and
 how to skip them?
In-Reply-To: <565847AC.9040807@st.com>
References: <565847AC.9040807@st.com>
Message-ID: <20151130110425.GA11935@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I contact you because i am running LTP tests on a board and at the end i
> always get this error message :
> "
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20140422
> 
> ###############################################################
> 
>               Done executing testcases.
>               LTP Version:  20140422
> ###############################################################
> losetup: /dev/loop0: failed to use device: No such file or directory
> "

There is ~40 testcases that needs a block device to run, mostly
testcases that test mount() syscall but there are also tests for quite a
lot of filesystem related syscalls to test conditions as ENOSPC and
things like mkfs testcases.

> I think that occurs because some tests actually need block device which
> i don't have.

This is a bit more complicated. The testcases needs a block device, if
you do not pass it to the runltp script (or does not export it as
TST_DEVICE) the testcases try to create a loopback device.

Now looking at the error above it looks like loosetup failed because
there is no support for loop devices in kernel. So the failure is from a
test coded in shell (since the C library calls the ioctls() directly).
And the equivalent functionality written in C library should handle the
situation more gracefully and exit the test with TCONF.

> Although all tests are executed regardless of this error,
> the blocking point is that i run LTP tests from custom script and this
> error provokes an exit from custom script (of course after LTP tests
> execution is done).
> My question is how can i identify all these tests which can potentially
> create this error and skip them?

Grep for tst_acquire_device() function in the source code. There are two
variants, one is coded in shell and one is coded in C. You are proably
looking for the testcases that are written in shell though.

-- 
Cyril Hrubis
chrubis@suse.cz
