From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Jul 2020 21:29:12 +0800
Subject: [LTP] [PATCH v2] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <CAEemH2febKOruSdyVDMa8sOTFNnSEdEwZkY1OP_34=Ac2GDxSA@mail.gmail.com>
References: <20200703030811.11521-1-pravinraghul@zilogic.com>
 <CAEemH2febKOruSdyVDMa8sOTFNnSEdEwZkY1OP_34=Ac2GDxSA@mail.gmail.com>
Message-ID: <CAEemH2egK01VqrZEaedr_YpgGmz8YLvBDq7bOkA2w+cJdupy5g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jul 28, 2020 at 11:20 AM Li Wang <liwang@redhat.com> wrote:

> ...
>
>> +       return !(local_var_1 < &local_var_2);
>>
>
> Shouldn't local_var_1 less than local_var_2 on a stack grow up arch? why
> we return the reverse value here?
>
> And the worth to say that the optimization of GCC will break this rule in
> the compilation.
>
> -O2  (ltp default gcc flag)
> mmap18.c:46: INFO: local_var_1 = 0x3ffd177dea0, loval_var_2 = 0x3ffd177dea4
> -O0
> mmap18.c:46: INFO: local_var_1 = 0x3ffc86fe614, loval_var_2 = 0x3ffc86fe56c
>

To avoid the compiler optimization disturbing the address order of
variables, I'd
suggest using only one local variable as the baseline to compare with
itself new
address in another recursive function calling.

Something maybe like this:

static int check_stackgrow_up(void)
{
    char local_var;
    static char *addr = 0;

    if (addr == 0) {
        addr = &local_var;
        return check_stackgrow_up();
    }

    return ((&local_var > addr) ? 1 : 0);
}


--------
>
> Apart from that, mmap18 also gets FAIL with s390x platform like:
>
> # ./mmap18
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> mmap18.c:46: INFO: local_var_1 = 0x3fff537e5d4, loval_var_2 = 0x3fff537e52c
> mmap18.c:126: INFO: mem = 0x3ff8dd3a000, stack = 0x3ff8dd5a000
> mmap18.c:136: FAIL: Child killed by SIGSEGV
>

From my observation, the failure only occurs on s390x, and it could not
overstride to the unmap memory area. With the following debug-code
adding to run_test():

+       memset(stack, 1, getpagesize());
+       tst_res(TINFO, "write to *stack sucess");
+       memset(stack - getpagesize(), 1, getpagesize());
+       tst_res(TINFO, "write to *(stack - %d) sucess", getpagesize());

mmap18 (on s390x) prints:

  tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
  mmap18.c:137: INFO: write to *stack sucess
  tst_test.c:1292: BROK: Test killed by SIGSEGV!

But trying with other architectures(x86_64, aarch64), they all override
the stack and write into the unmapped area.

  tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
  mmap18.c:139: INFO: write to *stack sucess
  mmap18.c:141: INFO: write to *(stack - 65536) sucess
  mmap18.c:151: PASS: Stack grows in unmapped region


And the Linux Manual makes me feel confusing here, what is the correct
behavior when writing the "guard" page? Can someone help explain this?

?"?
    MAP_GROWSDOWN
    ...
    Touching an address in the "guard" page below the mapping will
    cause the mapping to grow by a page. This growth can be repeated
    until the mapping grows to within a page of the high end of the next
    lower mapping, at which point touching the "guard" page will result
    in a SIGSEGV signal.
"""

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200728/c0f8f89b/attachment-0001.htm>
