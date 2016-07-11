From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jul 2016 14:18:02 +0100
Subject: [LTP] [PATCH] syscalls/mmap16: close open files in cleanup path
In-Reply-To: <1194994844.3639216.1468239570693.JavaMail.zimbra@redhat.com>
References: <1467384925-24792-1-git-send-email-peter.maydell@linaro.org>
 <1194994844.3639216.1468239570693.JavaMail.zimbra@redhat.com>
Message-ID: <CAFEAcA_5+0TQMr4iQSD2ogCRXyB9Jii6x-5xO8-j1M7zRStWFQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11 July 2016 at 13:19, Jan Stancek <jstancek@redhat.com> wrote:
> From: "Peter Maydell" <peter.maydell@linaro.org>

>> If the mmap16 test fails while the do_test() function
>> still has its filedescriptor open, the cleanup function's
>> attempt to unmount will fail with EBUSY, resulting in a
>> lot of noise in the test log, a leaked mounted filesystem
>> and unnecessary test failures later in the run.

> pushed with small change, which treats uninitialized fd as -1, not 0.

Thanks. Could you explain why you added

+               parentfd = -1;

after the SAFE_CLOSE() line? doc/test-writing-guidelines.txt
says "The SAFE_CLOSE() function also sets the passed file
descriptor to -1 after it's successfully closed.", so if
that's not correct we should fix the docs.

That doc also gives an example (in section 2.2.1) that
says "Since global variables are initialized to zero we can
just check that fd > 0 before we attempt to close it.",
which is why I used 0 rather than -1. If current preferred
test style has changed it would be nice to update the
example code.

thanks
-- PMM
