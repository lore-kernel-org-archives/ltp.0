From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Jul 2016 10:04:32 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/mmap16: close open files in cleanup path
In-Reply-To: <CAFEAcA_5+0TQMr4iQSD2ogCRXyB9Jii6x-5xO8-j1M7zRStWFQ@mail.gmail.com>
References: <1467384925-24792-1-git-send-email-peter.maydell@linaro.org>
 <1194994844.3639216.1468239570693.JavaMail.zimbra@redhat.com>
 <CAFEAcA_5+0TQMr4iQSD2ogCRXyB9Jii6x-5xO8-j1M7zRStWFQ@mail.gmail.com>
Message-ID: <1497887326.3689343.1468245872467.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, "Patch Tracking" <patches@linaro.org>
> Sent: Monday, 11 July, 2016 3:18:02 PM
> Subject: Re: [LTP] [PATCH] syscalls/mmap16: close open files in cleanup path
> 
> On 11 July 2016 at 13:19, Jan Stancek <jstancek@redhat.com> wrote:
> > From: "Peter Maydell" <peter.maydell@linaro.org>
> 
> >> If the mmap16 test fails while the do_test() function
> >> still has its filedescriptor open, the cleanup function's
> >> attempt to unmount will fail with EBUSY, resulting in a
> >> lot of noise in the test log, a leaked mounted filesystem
> >> and unnecessary test failures later in the run.
> 
> > pushed with small change, which treats uninitialized fd as -1, not 0.
> 
> Thanks. Could you explain why you added
> 
> +               parentfd = -1;
> 
> after the SAFE_CLOSE() line? doc/test-writing-guidelines.txt
> says "The SAFE_CLOSE() function also sets the passed file
> descriptor to -1 after it's successfully closed.", so if
> that's not correct we should fix the docs.

It's true for newlib, but not for oldlib. I think we should
rather fix oldlib SAFE_CLOSE to match the docs, so I dropped
the line:

include/old/safe_macros.h:
#define SAFE_CLOSE(cleanup_fn, fildes)  \
        safe_close(__FILE__, __LINE__, (cleanup_fn), (fildes))

I'll send a patch for oldlib SAFE_CLOSE.

> 
> That doc also gives an example (in section 2.2.1) that
> says "Since global variables are initialized to zero we can
> just check that fd > 0 before we attempt to close it.",
> which is why I used 0 rather than -1. If current preferred
> test style has changed it would be nice to update the
> example code.

Hmm. Cyril, can we guarantee that testcase won't open fd 0?
Would that apply for both newlib and oldlib?

Regards,
Jan

> 
> thanks
> -- PMM
> 
