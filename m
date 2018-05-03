From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 3 May 2018 08:15:31 +0200
Subject: [LTP] Want to contribute
In-Reply-To: <CAMZxAxcE7deAzonfmhX9YMWSy7sRgHCn3=oC_zaEi6KVBYMd=w@mail.gmail.com>
References: <CAMZxAxcE7deAzonfmhX9YMWSy7sRgHCn3=oC_zaEi6KVBYMd=w@mail.gmail.com>
Message-ID: <20180503061530.GA3382@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Aditya,

> Hi Developers,

> This is Aditya Upadhyay, Mentor at RTEMS Organization in Google Summer
> of Code-2018. Previously, I was a student intern at the same
> organization.

> One of the NetBSD members has suggested me to contribute to this
> project. I have gone through the wiki page:
> http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3.1
LTP has moved quite long time ago to git, hosted on github (including wiki):
https://github.com/linux-test-project/ltp
New wiki:
https://github.com/linux-test-project/ltp/wiki

LTP is (as the name suggests) quite the Linux kernel specific, although there are parts,
which are POSIX related (open POSIX test suite). Do you want to work on NetBSD support for
LTP or work generally on LTP?

> I have no idea about finding the issue while running the test-cases.
> At this point of time, I have no idea about fixing the issue. Would
> you like to share any pointers regarding "How to find the issue"?
> These are the outputs of this command: ./runltp -f syscalls -s madvise :

> aditya@aditya-Lenovo-ideapad-110-15ACL:/opt/ltp$ sudo ./runltp -f
...
> <<<test_output>>>
> tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
> madvise01.c:118: PASS: madvise test for MADV_NORMAL PASSED
PASS: test has been passed.

...
> madvise01.c:110: CONF: MADV_FREE is not supported
CONF: test has been skipped

TFAIL: would mean test failed.
See more info at:
https://github.com/linux-test-project/ltp/wiki/GettingStarted#3-structure

For contributing to LTP I recommend to read
https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

Kind regards,
Petr
