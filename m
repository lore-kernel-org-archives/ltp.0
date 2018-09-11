From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Sep 2018 17:32:18 +0300
Subject: [LTP] [PATCH] syscalls/fanotify: new test for mount ignore mask
In-Reply-To: <87in3c5rn6.fsf@rpws.prws.suse.cz>
References: <20180908142453.21532-1-amir73il@gmail.com>
 <20180908142453.21532-2-amir73il@gmail.com>
 <87in3c5rn6.fsf@rpws.prws.suse.cz>
Message-ID: <CAOQ4uxho8Fh7=eJr962UeTr4dwqnOjFQJZxvJ4ZreMa_MRJDfQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Sep 11, 2018 at 12:07 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Hello,
>
> If a test can handle two different regressions with only slight
> modifications then we should use the test index feature:
> https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial#6-split-the-test
>
> In more complex cases common code can be put into a shared header file
> or library. Whatever is simpler and cleaner overall. A lot of older
> tests have been copied and pasted which leads to big problems in the
> long term.
>

All right. I have already written this test with a test index to cover
all possible
mixes of mark types include and exclude masks:
https://github.com/amir73il/ltp/blob/fanotify_sb/testcases/kernel/syscalls/fanotify/fanotify13.c
This gives better coverage than fanotify06 and fanotify10 combined.

However, if I modify test fanotify06 instead of forking test fanotify10, the
test (fanotify06) is going to start failing on non-master kernels.
Is that acceptable for LTP? I am asking because in fstests project, we have
the practice not to change an existing test to failing. When we find a
new regression
we write a new variant of the test for it.

If changing an existing test to cover more cases is appropriate than I am
going to generalize fanotify06 (as fanotify13 linked above) and then
when FAN_MARK_FILESYSTEM mark type support is added to kernel
all I will need to do is change the test again to add another mark type
to  fanotify_mark_types array.

Thoughts?

Thanks,
Amir.
