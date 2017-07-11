From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Jul 2017 12:32:19 +0800
Subject: [LTP] [PATCH V2 05/14] mem/thp: convert to new API
In-Reply-To: <20170707152714.GG28534@rei.lan>
References: <20170410100556.4465-1-liwang@redhat.com>
 <20170410100556.4465-6-liwang@redhat.com>
 <20170707152714.GG28534@rei.lan>
Message-ID: <CAEemH2d8HqO-_Uq=acqU2MdoJ231J7izdm_AHe=vTmEXcr+fYA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 7, 2017 at 11:27 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> +     switch (pid = SAFE_FORK()) {
>>               case 0:
>>                       memset(arg, 'c', length - 1);
>>                       arg[length - 1] = '\0';
>> @@ -91,29 +72,31 @@ int main(int argc, char **argv)
>>                       }
>>               default:
>>                       if (waitpid(pid, &st, 0) == -1)
>> -                             tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
>> +                             tst_brk(TBROK | TERRNO, "waitpid");
>>                       if (!WIFEXITED(st) || WEXITSTATUS(st) != 0)
>> -                             tst_brkm(TBROK, cleanup,
>> -                                      "child exited abnormally");
>> -             }
>> +                             tst_brk(TBROK, "child exited abnormally");
>>       }
>
> We do have SAFE_WAITPID() as well, but in this case we can simply call
> tst_reap_children() that would take care of the exit status as well.

Great function.

>>       for (i = 0; i < 4; i++) {
>>               if (posix_memalign(&p, hps, size))
>> -                     tst_brkm(TBROK | TERRNO, cleanup, "memalign p");
>> +                     tst_brk(TBROK | TERRNO, "memalign p");
>>               if (posix_memalign(&p2, hps, size))
>> -                     tst_brkm(TBROK | TERRNO, cleanup, "memalign p2");
>> +                     tst_brk(TBROK | TERRNO, "memalign p2");
>>               if (posix_memalign(&p3, hps, size))
>> -                     tst_brkm(TBROK | TERRNO, cleanup, "memalign p3");
>> +                     tst_brk(TBROK | TERRNO, "memalign p3");
>
> The posix_memalign() returns errno hence this will print bogus values
> with TERRNO. We can either use SAFE_MEMALIGN() or possibly add
> POSIX_MEMALIGN() to the safe_macros and use that one instead.

Sure, I choose the obsolete one here.
  p = SAFE_MEMALIGN(hps, size);


>>  #else
>> -int main(void)
>> -{
>> -     tst_brkm(TCONF, NULL, "Kernel doesn't support MADV_MERGEABLE"
>> +     TST_TEST_TCONF("Kernel doesn't support MADV_MERGEABLE"
>>                " or you need to update your glibc-headers");
>
> Hmm, if we get here the problem was MADV_MERGEABLE missing in system
> headers. The kernel part is checked at runtime (that is the EINVAL check
> from madvise()).
>
> And we have lapi/mmap.h with fallback definition for it, so what about
> we get rid of the ifdefs and include the fallback header lapi/mmap.h
> instead?

Good suggestion. And no objection to the rest comments.

Thanks for reviewing patiently.

-- 
Li Wang
liwang@redhat.com
