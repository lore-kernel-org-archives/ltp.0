From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 30 Aug 2017 14:27:18 +0200
Subject: [LTP] [PATCH v2 1/7] tst_atomic: Add load,
	store and use __atomic builtins
In-Reply-To: <00e8fd78-6cc0-6e5d-4055-b255fc317aa1@redhat.com>
References: <20170828110241.30453-1-rpalethorpe@suse.com>
 <00e8fd78-6cc0-6e5d-4055-b255fc317aa1@redhat.com>
Message-ID: <87y3q1b5qx.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

As always, thanks for the review.

Jan Stancek writes:

> On 08/28/2017 01:02 PM, Richard Palethorpe wrote:
>> Also add more fallback inline assembly for the existing architectures and add
>> SPARC64. Use the __atomic_* compiler intrinsics when available.
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>
> Hi,
>
> I gave this patch a go on number of old/new distros, x86_64, ppc64le
> and s390 and I haven't ran into issues. My review is mostly only
> comparison against kernel sources as much of inline assembly is beyond me.
>
> I think we could use a comment about what sort of ordering do we expect
> from tst_atomic.h. I always assumed we care only for compiler barriers,
> and when we use __sync_* functions, it's more for convenience (not
> because we wanted full memory barrier).

I think that is a good idea, I will write some justification and
explanation in the header.

In my particular use case (tst_fuzzy_sync), I need atleast an
"acquire-release" memory barrier to ensure that some non-atomic updates
to shared data between threads are globally visible after a given
point. I could probably remove them and it would work on most machines
most of the time. However if a bug does occure due to stale data, I
think it would be extremely difficult for someone to diagnose.

>
> I don't quite understand tst_atomic_load/store() for aarch64, because
> when I look at kernel's arch/arm64/include/asm/atomic.h
> these are a lot simpler:
> #define atomic_read(v)                  READ_ONCE((v)->counter)
> #define atomic_set(v, i)                WRITE_ONCE(((v)->counter),
> (i))

I think these are _just_ atomic load and store. There are no common load
or store functions in the kernel which are also a memory
barriers (probably). However there are cmpxchg and add-load atomics which are also
memory barriers (they have acquire or release semantics).

I adapted the ARM load/store ASM from the cmpxchg code and I am pretty
sure they are overkill. However ARM is the only architecture where I
managed to cause an error without memory barriers, but with these
functions no error occurs.

>
> The rest of fallback functions looks good to me (at least for architectures
> I checked). I expect fallback is used only by very small fringe of users
> and their numbers will only go down in future.
>
> Regards,
> Jan

Yes I think so, GCC has had the sync intrinsics for a long time and
Clang. If anyone is using a compiler without these intrinsics it would
be interesting to know about it.

--
Thank you,
Richard.
