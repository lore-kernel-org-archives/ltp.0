From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 15 May 2017 03:22:09 -0400 (EDT)
Subject: [LTP] LTP: readahead02 failed
In-Reply-To: <CA+G9fYvHus+AB1CD4AGxw3pOAKavO=gQ0W2zfPSZ-qkUac9U-w@mail.gmail.com>
References: <CA+G9fYvHus+AB1CD4AGxw3pOAKavO=gQ0W2zfPSZ-qkUac9U-w@mail.gmail.com>
Message-ID: <1149421133.11389918.1494832929012.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi Team,
> 
> readahead02 failed on HiKey board with below error message.
> 1. Any minimal limitation of Buffers size or Cached size should have
> to pass this test case ?  if yes we would change test logic to detect
> and skip test run.

Hi,

Your system appears to have plenty of memory for this test.

> 2. The first FAIL message is not giving enough information (*) there
> is a room for improvement here.

I pushed a patch to include errno code in failure message.

> 3.  strace output show Invalid argument for readahead()
> 
> readahead(3, 0, 67108864)               = -1 EINVAL (Invalid argument)
> write(1, "readahead02    1  TFAIL  :  read"..., 100readahead02    1
> TFAIL  :  readahead02.c:86: unexpected failure - returned value = -1,
> expected: 0
> ) = 100
> 
> The man page have explanation of EINVAL is
> EINVAL fd  does  not  refer  to a file type to which readahead() can be
> applied.

Have you run into this with any of previous kernels?

What filesystem is /tmp? Is it tmpfs?

Can you try with LTP tmpdir backed by different fs?
For example: env TMPDIR=/root/ ./readahead02

Regards,
Jan
