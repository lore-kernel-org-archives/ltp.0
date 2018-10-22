From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 22 Oct 2018 11:24:53 +0200
Subject: [LTP] [PATCH v3 0/4] New Fuzzy Sync library API
In-Reply-To: <20181018150209.GA26947@rei>
References: <20181010140405.24496-1-rpalethorpe@suse.com>
 <20181018150209.GA26947@rei>
Message-ID: <87a7n6tjtm.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> I've dusted off my old pxa270 PDA and tried to compare the different
> implementations of the fuzzy sync library:

Good stuff!

>
> |-------------------------------------------------------------|
> | test          |  old library  |  new library                |
> |-------------------------------------------------------------|
> | shmctl05      | timeouts      | timeouts                    |
> |-------------------------------------------------------------|
> | inotify09     | timeouts      | exits in sampling with WARN |
> |-------------------------------------------------------------|
> | cve-2017-2671 | kernel crash  | kernel crash                |
> |-------------------------------------------------------------|
> | cve-2016-7117 | kernel crash  | exits in sampling with WARN |
> |-------------------------------------------------------------|
> | cve-2014-0196 | timetous      | exits in sampling with WARN |
> |-------------------------------------------------------------|
>
> The shmctl05 timeouts because the remap_file_pages is too slow and we
> fail to do even one iteration, it's possible that this is because we are
> hitting the race as well since this is kernel 3.0.0, but I cannot say
> that for sure.
>
> The real problem is that we fail to callibrate because the machine is
> too slow and we do not manage to take the minimal amount of samples
> until the default timeout.
>
> If I increase the timeout percentage to 0.5, we manage to take at least
> minimal amount of samples and to trigger the cve-2016-7117 from time to
> time. But it looks like the bias computation does not work reasonably
> reliably there, not sure why. But looking at the latest version adding
> bias no longer resets the averages, which may be the reason because the
> bias seems to be more or less the same as the number minimal samples.

Sounds correct. I guess context switches take a large number of cycles
on this CPU relative to x86.

>
> So there are a few things to consider, first one is that the default
> timeout percentage could be probably increased so that we do not have to
> tune the LTP_TIMEOUT_MUL even on slower processors. The downside is that
> these testcase would take longer on modern harware. Maybe we can do some
> simple CPU benchmarking to callibrate the timeout.

Perhaps the test runner or test library should tune LTP_TIMEOUT_MUL?
Assuming the user allows it.

>
> Second thing to consider is if and how to tune the minimal amount of
> samples, Maybe we can set the minimal amount of samples to be smaller
> and then exit the callibration if our deviation was small enough three
> times in a row. But then there is this bias that we have to take into an
> account somehow.

I think the only way is to benchmark a selection of syscalls and then
pass this data to the test somehow. Then it can calculate some
reasonable time and sample limits.

However I also think this is beyond the scope of this patch set because
fuzzy sync tests are just one potential user of such metrics. I suspect
also that it will be a big enough change to justify its own discussion
and patch set.

For now, if we increase the minimum time limit and samples so that
cve-2016-7117 behaves sensibly on a pxa270 then we are probably covering
most users. The downside is that we are wasting some time and
electricity on server grade hardware, but at least the tests are being
performed correctly on most hardware.

--
Thank you,
Richard.
