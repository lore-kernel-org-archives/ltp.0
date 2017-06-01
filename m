From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 1 Jun 2017 12:48:10 +0200
Subject: [LTP] [lkp-robot] [fs] b220238d4b:
 INFO:ltp-pan_reported_some_tests_FAIL
In-Reply-To: <20170601082938.GB4765@rei.lan>
References: <20170601015815.GB16905@yexl-desktop>
 <20170601082938.GB4765@rei.lan>
Message-ID: <20170601104809.GA10526@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > <<<test_output>>>
> > io_submit01    1  TPASS  :  expected failure - returned value = -22 : Invalid argument
> > io_submit01    2  TPASS  :  expected failure - returned value = -22 : Invalid argument
> > io_submit01    3  TFAIL  :  io_submit01.c:138: unexpected failure - returned value = -95 : Operation not supported, expected one of -EINVAL, -EBADF, -EFAULT
> > io_submit01    4  TPASS  :  expected failure - returned value = -14 : Bad address
> > io_submit01    5  TPASS  :  expected failure - returned value = -22 : Invalid argument
> > io_submit01    6  TPASS  :  expected failure - returned value = -9 : Bad file descriptor
> > io_submit01    7  TPASS  :  expected success - returned value = 0
> > io_submit01    8  TPASS  :  expected success - returned value = 1
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=0 cstime=0
> > <<<test_end>>>
> 
> 
> Looks like an invalid testcase to me, feel free to ignored it.
> 
> What the test does is to try with uninitialized "radnom" iocb to
> io_submit() and expects certain subset of errors to be returned.

FYI: Should be fixed in:

https://github.com/linux-test-project/ltp/commit/89d1e69d5953eac71b121b8ec5ee31d769e17ee2

-- 
Cyril Hrubis
chrubis@suse.cz
