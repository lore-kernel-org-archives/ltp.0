From: Li Wang <liwang@redhat.com>
Date: Mon, 5 Dec 2016 18:24:45 +0800
Subject: [LTP] [PATCH 1/3] ltp/numa: waiting for numastat refresh
In-Reply-To: <20161205092810.GB15793@rei.lan>
References: <1479872202-29920-1-git-send-email-liwang@redhat.com>
 <20161123125727.GF3346@rei.lan>
 <CAEemH2fRor7ORDSzfDf8podzjXc5jAYWn+L6d3kcudkW7kcGmg@mail.gmail.com>
 <20161201105129.GB5626@rei.lan>
 <CAEemH2eRWKMEVKc-EZ4Z78eJ18sqqori=-_QcSTtm8w31=aXdg@mail.gmail.com>
 <20161205092810.GB15793@rei.lan>
Message-ID: <CAEemH2cCzNBi3fKscopmH=GPgmH3mk7Ucx=uvUQ5iKaE34t5hw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Dec 5, 2016 at 5:28 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> This method is great! But, I'm thinking about how can we apply to
>> test6, test7 and test8, because these functions do not involve
>> support_numa.c process in their test.
>
> I guess that we can add a dummy program to make wait for a signal in the test06.
>
> Does something like this work?
>
> numactl --length=1M --file /dev/shm/numa_shm --interleave=all --touch support_numa 3 &

Sounds good, we can just add raise(SIGSTOP) in support_numa.c to wait a signal.

>
> I would be probably in favor of dropping the test07, since that does
> more or less the same as test03.

Ok, agree to remove.

>
>> In test8:
>>    numactl --interleave=all memhog 1MB
>>
>> It seems a little hard to hang up this memhog process.
>
> Just set large enough memhog repeat parameter with -r so that it does
> not finish prematurely. Or even better we can just add a few lines of
> code to the numa helper so that it can memset the memory in a loop just
> like the memhog does.
>
> https://github.com/numactl/numactl/blob/master/memhog.c

Great! Let me have a look and then choose a way.

Thanks,
Li Wang
