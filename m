From: Mike Marshall <hubcap@omnibond.com>
Date: Mon, 23 May 2016 11:03:19 -0400
Subject: [LTP] Fwd: pwrite04 ltp bug?
In-Reply-To: <20160523123928.GE22559@rei.lan>
References: <CAOg9mSSjfxiZ960tpADgVmndxXQpC7ag9QZSz68NbdeGn+yW9g@mail.gmail.com>
 <CADVQ27oBdCxfuVmknYa16RTXpnYgncn94VnutMgn2+9VD-9bcg@mail.gmail.com>
 <CADVQ27q119e2Oqg0tVGDjc_8yjoXvQHbg=Tqd9n4jxu8tedRVg@mail.gmail.com>
 <CAOg9mSScVopGsoQeoESWAnD2YFrsr2qzQksC8A8T8m8dncFdAg@mail.gmail.com>
 <20160523123928.GE22559@rei.lan>
Message-ID: <CAOg9mSQJF9gShs0m8osa7=idydmsacV1og78XCq=zitNH6aR9Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

 > This does not look right...

OK, I was just copying the file size test
loop above the "Finally" comment, I assumed
that cleanup exited. As it is, if you fail the
file size loop I edited,  you'll get both a FAIL
and a PASS...

Maybe in all the cases that resolve to FAIL
we should goto some kind of out-fail: ?

Thanks for looking...

-Mike

On Mon, May 23, 2016 at 8:39 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> While fixing a couple of LTP regressions in the out-of-tree Orangefs
>> kernel module, I think I found a problem with the pwrite04 test,
>> here's what I think was meant:
>>
>> # git diff testcases/kernel/syscalls/pwrite/pwrite04.c
>> diff --git a/testcases/kernel/syscalls/pwrite/pwrite04.c
>> b/testcases/kernel/syscalls/pwrite/pwrite04.c
>> index b297682..4ca7dc1 100644
>> --- a/testcases/kernel/syscalls/pwrite/pwrite04.c
>> +++ b/testcases/kernel/syscalls/pwrite/pwrite04.c
>> @@ -196,9 +196,9 @@ int main(int ac, char *av[])
>>
>>                 }
>>                 if (statbuf.st_size != K5) {
>> -                       tst_resm(TFAIL, "file size is %ld != K4",
>> +                       tst_resm(TFAIL, "file size is %ld != K5",
>>                                  statbuf.st_size);
>
> This is obvious typo fix.
>
>> -
>> +                       cleanup();
>
> This does not look right. Looking at the test source the rest of the ifs
> has the cleanup right after tst_resm() but the cleanup() fuction is
> supposed to be called exactly once at the end of the test at the end of
> the main.
>
> If it's called in the testing loop the test will fail when cleanup() is
> invoked second time at the test exit since it will attempt to remove
> allready deleted test temporary directory. So the correct solution to
> this problem would rather be to remove the cleanup() from the test loop.
>
>>                 }
>>                 tst_resm(TPASS, "O_APPEND test passed.");
>
> --
> Cyril Hrubis
> chrubis@suse.cz
