From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 20 Nov 2018 12:35:10 +0100
Subject: [LTP] [PATCH v4 0/4] New Fuzzy Sync library API
In-Reply-To: <CAEemH2dF4Mg6C_uu6GUxixev_pZqbmL-h0sE73X2_6CyN1x7nA@mail.gmail.com>
References: <20181105154217.18879-1-rpalethorpe@suse.com>
 <CAEemH2dF4Mg6C_uu6GUxixev_pZqbmL-h0sE73X2_6CyN1x7nA@mail.gmail.com>
Message-ID: <87bm6kasnl.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> On Mon, Nov 5, 2018 at 11:42 PM, Richard Palethorpe
> <rpalethorpe@suse.com> wrote:
>> Changes for V4:
>>
>> * Increase fzsync timeout to 50% of the overall LTP test timeout
>> * Increase default iterations to 3 million
>> * Set cve-2014-0196 iterations to 50,000
>> * Increase sample iterations for cve-2016-7117
>>
>> With these defaults almost all of the tests should reliably trigger their
>> bugs while not taking more than 30 seconds to execute on server grade
>> hardware. On slow embedded systems the tests should also be fairly reliable,
>> however will take up to 150 seconds.
>>
>> Hopefully none of the tests will exit with a warning on slow systems because
>> they failed to complete the sampling phase. However on a very slow system
>> cve-2016-7117 will probably not have time to finish the sampling phase, but
>> this bug is simply very difficult to reproduce[1] on some kernels and a long
>> sampling time is required to get the optimal delay bias.
>
> I run these corresponding tests[1] with applying the new fuzzy_sync
> API on some slow systems. The follows are the test status and sampling
> time consumption.
>
> 1. KVM Guest, RHEL-7.6GA, x86_64, 1vcpu, 1G RAM
> cve-2016-7117 and shmctl05 failed to complete the sampling phase and
> eventually exit with warnings.
>
> Sampling time consume:
> -------------------------------
> cve-2016-7117: ~440.31s
> cve-2014-0196: ~33.77s
> cve-2017-2671: ~33.81s
> inotify09: ~33.83s
> shmctl05: ~33.78s
> test16: ~44.91s
>
> My extra proposal for test shmctl05 is to extend its timeout from 20s
> to 100s. Because from the time cost detection on such a slow(1cpu, 1G
> ram) machine, 10s(1/2 of .timeout=20) is too short to finish sampling.

Interesting that it is so slow on an x86 system, but it also makes sense
with a single core because these are all multi-threaded tests. If the
kernel is completely preemptive then it may be theoretically possible to
trigger one of these bugs on a single core, but most people seem to
think the probability of it happening is lower than on a multi-core
machine.

I am tempted to simply exit the test with TCONF if it is a single core
system. If we do allow them to run on a single core then we have to test
that they work reasonably well on single cores (given enough
time). Which I just don't think is worth doing based on the times you
have given.

>
> 2. KVM Guest, RHEL-7.6GA, x86_64, 2vcpu, 2G RAM
> All test[1] PASS with execution time/loops exceeded. I didn't do time
> consume detection on this system.
>
> 3. Raspberry Pi3, CentOS-7.5(4.14.78-v7.1.el7 armv7l), 4cpus, 1G RAM
> All test[1] PASS with execution time/loops exceeded.
> What surprised me was that the average of sampling time is only 9~11
> seconds on the RaspbeeryPi3. Even includes cve-2016-7117 also complete
> its sampling phase so fast!
>
> [1] cve-2014-0196 cve-2016-7117 cve-2017-2671 inotify09 shmctl05 test16

Again, interesting. I found the Pi3 was significantly slower (although
still quite good), but possibly it is better now because I removed some
memory barriers although we still sync the memory a lot. Having 3+ cores
probably helps as well because it leaves one or more cores to do
background tasks.

--
Thank you,
Richard.
