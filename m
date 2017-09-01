From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Sep 2017 18:44:25 +0800
Subject: [LTP] [PATCH] thp01: Find largest arguments size
In-Reply-To: <87val2bw3j.fsf@our.domain.is.not.set>
References: <20170831083407.28402-1-rpalethorpe@suse.com>
 <CAEemH2cdcy16cDifgMd=_pk=3z3M79Z=04iA4c0xfktgdONDog@mail.gmail.com>
 <87val2bw3j.fsf@our.domain.is.not.set>
Message-ID: <CAEemH2fca0n64ffaPB25gGxSaqrcougvzQbtF1MzZ3wGJtROdA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 1, 2017 at 5:34 PM, Richard Palethorpe <rpalethorpe@suse.de> wrote:
> Hello,
>
> Thanks for the review,
>>
>> 1. Can't we declare the arg_count just as a global variable? why
>> should we take use of share memory, only for the loop counting?
>
> It forks so that it can call exec without overwriting the test process
> image. Global variables are copy-on-write for a child process (unless we
> use clone()), so the parent's memory would not be updated by the
> child. We need the parent to be updated so that, when the next child is
> run, it already has the correct argument count saving a lot of calls to
> exec.

Yep! But for this test, it does not need to update 'arg_count' in the
parent process, and after fork a child, it call execvp() to create a
new process image. So I think here is OK to take use of global
variable.

Did I miss anything?


I do change the 'arg_count' to a global variable and get pass:
(see attachment)

static void thp_test(void)
{
    pid_t pid = SAFE_FORK();

    if (!pid) {
        args[arg_count] = NULL;

        do {
            TEST(execvp("true", args));
            args[--arg_count] = NULL;
            printf("debuginfo: arg_count = %d\n", arg_count);
        } while (arg_count > 0 && TEST_ERRNO == E2BIG);

        tst_brk(TBROK | TTERRNO, "execvp(\"true\", ...)");
    }

    tst_reap_children();

    tst_res(TPASS, "system didn't crash, pass.");
}


==========
# ./thp01
tst_test.c:908: INFO: Timeout per run is 0h 05m 00s
debuginfo: arg_count = 254
...
debuginfo: arg_count = 49
debuginfo: arg_count = 48
thp01.c:69: PASS: system didn't crash, pass.

Summary:
passed   1
failed   0
skipped  0
warnings 0


>>
>>
>> 2. The kernel patch limit all arg stack usage to at most 75% of _STK_LIM (6MB),
>> and here the size of arg_len is 32*PAGE_SIZE.  So it means that there
>> almost only have 6MB/(PAGE_SIZE*32) numbers can be accepted in
>> args[(*arg_count)], if it is a ppc64 machine(*arg_count == 3) that's
>> OK, but if a system PAGE_SIZE > 192KB, then the test will be break and
>> your loop is absolutely useless. About that, if we shrink the arg_len
>> size, things would be better I guess.
>
> That is true, but even on PPC64 with a default page size of 64Kb, the
> default huge page size is 15MB (I think). So, on PPC64, we are only
> doing a very basic test of exec on current kernels. Systems with page
> sizes over 192KB seem even less likely to have huge pages smaller than
> 6MB.
>
> However I don't see any harm in reducing the PAGE_SIZE coefficient to 1
> and multiplying the ARGS_SZ by 32, this will make the test slower, but
> more accurate at finding the maximum argument size while maintaining the
> allocation size of the original reproducer.
>
> --
> Thank you,
> Richard.



-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: thp01.c
Type: text/x-csrc
Size: 2434 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170901/27ea9726/attachment.c>
