From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 30 Nov 2020 09:01:10 +0000
Subject: [LTP] [PATCH] fzsync: skip test when avaliable CPUs less than 2
In-Reply-To: <CAEemH2fXpPXvQVi_UUovp+eB5JeWfdTjv47KXnCBhF=VG0Rsog@mail.gmail.com>
References: <20201125101633.30154-1-liwang@redhat.com>
 <87eekhof3i.fsf@suse.de> <04c4b073-6ad3-836a-7f63-7632a4e6ddb7@suse.cz>
 <87blflo9hx.fsf@suse.de>
 <f9b2e084-f2e0-1016-f505-6218d7c1853e@jv-coder.de>
 <CAEemH2fXpPXvQVi_UUovp+eB5JeWfdTjv47KXnCBhF=VG0Rsog@mail.gmail.com>
Message-ID: <87wny3md61.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> Hi Joerg,
>
> On Mon, Nov 30, 2020 at 3:53 PM Joerg Vehlow <lkml@jv-coder.de> wrote:
>
>> Hi,
>> >> No, af_alg07 requires 2 CPUs, otherwise it'll report false positives.
>> >> The test will pass only if fchownat() hits a half-closed socket and
>> >> returns error. But IIRC the half-closed socket will be destroyed during
>> >> reschedule which means there's no race window to hit anymore. But it
>> >> would be better to put the TCONF condition into the test itself.
>> > Interesting, I wonder if this is also true for the real-time kernel with
>> > the threads set to RT priority?
>> It looks like the test can fail even with more than one cpu. I've seen
>> this sporadic failure on different hardware with more than two cores, at
>> least on intel denverton (x86_64) and renesas r-car (aarch64) systems.
>> Both with kernel 4.19 with the fix included, on the denverton system the
>> rt parches were included and on the r-car not. The test passes most of
>> the time, but sometimes fails with the message Li posted.
>>
>> It also seems to fail sporadically on other systems as well:
>> https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1892860
>>
>> Additionally I tested on qemu-x86 with 4.19 with and without rt patches.
>> The test succeeds even with only one virtualized cpu. So either Martin's
>> assumption is wrong or it holds only for newer kernel versions?
>>
>
> No, Mertin is not wrong, and you are also right.
>
> They are totally two different issues of af_alg07, the test on 1CPU
> should be fixed with TCONF. But the fail with aarch64 is more like a
> hardware issue, Chunyu has a drafted patch to add init delay value for
> such a system.
>
> Can you try this on your aarm64 platform?
> -----------------------------
> fzsync can't get a random delay range on hpe-moonshot systems, so run with
> delay=0 during all the tests. This is probably the hardware issue such as
> cache line design so can't get a stable state during the execution of the
> critical
> section. Provide an experience delay value on hpe-moonshot to make it hit
> the race window immediately without exceeding samples.
>
> ---
>  testcases/kernel/crypto/af_alg07.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/crypto/af_alg07.c
> b/testcases/kernel/crypto/af_alg07.c
> index 6ad86f4f3..24f5b8088 100644
> --- a/testcases/kernel/crypto/af_alg07.c
> +++ b/testcases/kernel/crypto/af_alg07.c
> @@ -47,6 +47,7 @@ static void setup(void)
>   fd = SAFE_OPEN("tmpfile", O_RDWR | O_CREAT, 0644);
>
>   tst_fzsync_pair_init(&fzsync_pair);
> + fzsync_pair.delay_bias = 700;

I hope there is some way to set this dynamically. Similar to
CVE-2016-7117.

If we know that we should get some particular error we could modify the
bias until the error happens.

>  }
>
>  static void *thread_run(void *arg)
> -- 
> 2.19.1


-- 
Thank you,
Richard.
