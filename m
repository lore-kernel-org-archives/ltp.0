From: Li Wang <liwang@redhat.com>
Date: Fri, 2 Dec 2016 15:49:25 +0800
Subject: [LTP] [PATCH 1/3] ltp/numa: waiting for numastat refresh
In-Reply-To: <20161201105129.GB5626@rei.lan>
References: <1479872202-29920-1-git-send-email-liwang@redhat.com>
 <20161123125727.GF3346@rei.lan>
 <CAEemH2fRor7ORDSzfDf8podzjXc5jAYWn+L6d3kcudkW7kcGmg@mail.gmail.com>
 <20161201105129.GB5626@rei.lan>
Message-ID: <CAEemH2eRWKMEVKc-EZ4Z78eJ18sqqori=-_QcSTtm8w31=aXdg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Dec 1, 2016 at 6:51 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
> I've been looking into the problem and found much better solution. We
> can, instead of quering the whole system statistic, read statistic for a
> single process.

This method is great! But, I'm thinking about how can we apply to
test6, test7 and test8, because these functions do not involve
support_numa.c process in their test.

In test8:
   numactl --interleave=all memhog 1MB

It seems a little hard to hang up this memhog process.


Or, can we reseve previous method compatible with this? In other
words, two method exsit at the same time.

Li Wang


>
> What about we do:
>
> 1. Change support_numa.c to sleep in wait() instead of exitting when
>    allocating memory
> 2. Run the numactl ... command on background with &
> 3. Then we can get statistic for a single process with numastat -p $pid
>    Alternatively we can change the support_numa.c to allocate the memory
>    with mmap and parse /proc/$pid/numa_maps to match the pointer address
>    and figure out if the mapping(s) are distributed correctly
> 4. Then we can kill the $pid
>
> --
> Cyril Hrubis
> chrubis@suse.cz



-- 
Regards,
Li Wang
Email: liwang@redhat.com
