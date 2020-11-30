From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 30 Nov 2020 09:39:33 +0100
Subject: [LTP] [PATCH] fzsync: skip test when avaliable CPUs less than 2
In-Reply-To: <CAEemH2fXpPXvQVi_UUovp+eB5JeWfdTjv47KXnCBhF=VG0Rsog@mail.gmail.com>
References: <20201125101633.30154-1-liwang@redhat.com>
 <87eekhof3i.fsf@suse.de> <04c4b073-6ad3-836a-7f63-7632a4e6ddb7@suse.cz>
 <87blflo9hx.fsf@suse.de> <f9b2e084-f2e0-1016-f505-6218d7c1853e@jv-coder.de>
 <CAEemH2fXpPXvQVi_UUovp+eB5JeWfdTjv47KXnCBhF=VG0Rsog@mail.gmail.com>
Message-ID: <821eeadf-acd2-0de6-033d-1c3442a20407@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

On 11/30/2020 9:14 AM, Li Wang wrote:
> Hi Joerg,
>
> On Mon, Nov 30, 2020 at 3:53 PM Joerg Vehlow <lkml@jv-coder.de 
> <mailto:lkml@jv-coder.de>> wrote:
>
>     Hi,
>     >> No, af_alg07 requires 2 CPUs, otherwise it'll report false
>     positives.
>     >> The test will pass only if fchownat() hits a half-closed socket and
>     >> returns error. But IIRC the half-closed socket will be
>     destroyed during
>     >> reschedule which means there's no race window to hit anymore.
>     But it
>     >> would be better to put the TCONF condition into the test itself.
>     > Interesting, I wonder if this is also true for the real-time
>     kernel with
>     > the threads set to RT priority?
>     It looks like the test can fail even with more than one cpu. I've
>     seen
>     this sporadic failure on different hardware with more than two
>     cores, at
>     least on intel denverton (x86_64) and renesas r-car (aarch64)
>     systems.
>     Both with kernel 4.19 with the fix included, on the denverton
>     system the
>     rt parches were included and on the r-car not. The test passes
>     most of
>     the time, but sometimes fails with the message Li posted.
>
>     It also seems to fail sporadically on other systems as well:
>     https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1892860
>     <https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1892860>
>
>     Additionally I tested on qemu-x86 with 4.19 with and without rt
>     patches.
>     The test succeeds even with only one virtualized cpu. So either
>     Martin's
>     assumption is wrong or it holds only for newer kernel versions?
>
>
> No, Mertin is not wrong, and you are also right.
>
> They are totally two different issues of af_alg07, the test on 1CPU
> should?be fixed with TCONF. But the fail with aarch64 is more like a
> hardware issue, Chunyu has a drafted patch to add init delay value for
> such a system.
I think you misunderstood something. I see random fails with "TFAIL: 
fchownat() failed to fail, kernel may be vulnerable" on both x86_64 and 
aarch64 with more than one cpu core (4 for x86_64 and 2 or 4 for aarch64).

I see no error ("TPASS: fchownat() failed successfully: ENOENT (2)") on 
single core qemu-x86. This is why I think Martin's assumption may be 
wrong. If it was right, it should never succeed on a single core system 
right?

J?rg
