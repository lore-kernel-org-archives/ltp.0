From: Aditya Upadhyay <aadit0402@gmail.com>
Date: Thu, 3 May 2018 22:07:57 +0530
Subject: [LTP] Want to contribute
In-Reply-To: <20180503061530.GA3382@x230>
References: <CAMZxAxcE7deAzonfmhX9YMWSy7sRgHCn3=oC_zaEi6KVBYMd=w@mail.gmail.com>
 <20180503061530.GA3382@x230>
Message-ID: <CAMZxAxfP8srQrngYuTOV7o39QAn9-53K+pJkqPubeXcYaF8Lww@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 3, 2018 at 11:45 AM, Petr Vorel <pvorel@suse.cz> wrote:
> Hi Aditya,
>
>> Hi Developers,
>
>> This is Aditya Upadhyay, Mentor at RTEMS Organization in Google Summer
>> of Code-2018. Previously, I was a student intern at the same
>> organization.
>
>> One of the NetBSD members has suggested me to contribute to this
>> project. I have gone through the wiki page:
>> http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3.1
> LTP has moved quite long time ago to git, hosted on github (including wiki):
> https://github.com/linux-test-project/ltp
> New wiki:
> https://github.com/linux-test-project/ltp/wiki
>
Got it. I have already gone through the git hub wiki page.
> LTP is (as the name suggests) quite the Linux kernel specific, although there are parts,
> which are POSIX related (open POSIX test suite). Do you want to work on NetBSD support for
> LTP or work generally on LTP?
>
Yes, I want to work on NetBSD Support for LTP. LTP is really a good platform to
 test the robustness of Linux Kernel.
Last year, I was working on POSIX Compliance as Google Summer of Code project
 and this year, I am a mentor for the same project.

>> I have no idea about finding the issue while running the test-cases.
>> At this point of time, I have no idea about fixing the issue. Would
>> you like to share any pointers regarding "How to find the issue"?
>> These are the outputs of this command: ./runltp -f syscalls -s madvise :
>
>> aditya@aditya-Lenovo-ideapad-110-15ACL:/opt/ltp$ sudo ./runltp -f
> ...
>> <<<test_output>>>
>> tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
>> madvise01.c:118: PASS: madvise test for MADV_NORMAL PASSED
> PASS: test has been passed.
>
> ...
>> madvise01.c:110: CONF: MADV_FREE is not supported
> CONF: test has been skipped
>
> TFAIL: would mean test failed.
> See more info at:
> https://github.com/linux-test-project/ltp/wiki/GettingStarted#3-structure
>
> For contributing to LTP I recommend to read
> https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
>
Thanks for pointing me these links. It is really helpful to me.
I would love to contribute to LTP as well as NetBSD(Open POSIX Test Suite).
> Kind regards,
> Petr
