From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Mar 2019 08:41:35 +0200
Subject: [LTP] [PATCH v2] syscalls/readahead02: limit max readahead to
 backing device max_readahead_kb
In-Reply-To: <20190306164256.GA570@dustball.usersys.redhat.com>
References: <CAOQ4uxi49WogvHDck_JXiUV8VfLDHhzu=EYVYWiTz+zagT41KA@mail.gmail.com>
 <e27f21eef1ea317efcae24816b7a014e9e663f2d.1551802444.git.jstancek@redhat.com>
 <CAOQ4uxgc2NqK=6Lmau08y_k6tQa17xg8Q50UB+xwkgdetTWKuQ@mail.gmail.com>
 <518295220.5323766.1551804903461.JavaMail.zimbra@redhat.com>
 <CAOQ4uxhAESuU2HZ73kU0tMZ4CvQSJPo4c176MuBoN9WrT2nhTg@mail.gmail.com>
 <2040204176.5432824.1551817326223.JavaMail.zimbra@redhat.com>
 <CAOQ4uxiVkayLBWPAdPSz9W17hPNp7LagdtJ2k+vL98C0KgbKtA@mail.gmail.com>
 <20190306164256.GA570@dustball.usersys.redhat.com>
Message-ID: <CAOQ4uxjO+jYKzor7_eqBd8HMGs=m-EKt3jd+jRtOhh_KNPzYXQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 6, 2019 at 6:43 PM Jan Stancek <jstancek@redhat.com> wrote:
>
> On Tue, Mar 05, 2019 at 10:44:57PM +0200, Amir Goldstein wrote:
> >> > > > This is certainly better than 4K, but still feels like we are not really
> >> > > > testing
> >> > > > the API properly, but I'm fine with this fix.
> >> > > >
> >> > > > However... as follow up, how about extending the new
> >> > > > tst_dev_bytes_written() utils from Sumit to cover also bytes_read
> >> > > > and replace validation of readahead() from get_cached_size() diff
> >> > > > to tst_dev_bytes_read()?
> >> > >
> >> > > There is something similar based on /proc/self/io. We could try using
> >> > > that to estimate max readahead size.
> >> > >
> >> > > Or /sys/class/block/$dev/stat as you suggested, not sure which one is
> >> > > more accurate/up to date.
> >> > >
> >> >
> >> > I believe /proc/self/io doesn't count IO performed by kernel async
> >> > readahead against the process that issued the readahead, but didn't
> >> > check. The test uses /proc/self/io to check how many IO where avoided
> >> > by readahead...
> >>
> >> We could do one readahead() on entire file, then read
> >> the file and see how many IO we didn't manage to avoid.
> >> The difference between filesize and IO we couldn't avoid,
> >> would be our max readahead size.
>
> This also doesn't seem 100% accurate.
>
> Any method to inspect side-effect of readahead, appears to lead to more
> readahead done by kernel. E.g. sequential reads leading to more async
> readahead started by kernel (which tries to stay ahead by async_size).
> mmap() approach appears to fault-in with do_fault_around().
>
> MAP_NONBLOCK is gone, mincore and pagemap doesn't help here.
>
> I'm attaching v3, where I do reads with sycalls() in reverse order.
> But occasionally, it still somehow leads to couple extra pages being
> read to cache. So, it still over-estimates. On ppc64le, it's quite
> significant, 4 extra pages in cache, each 64k, causes readahead
> loop to miss ~10MB of data.
>
> /sys/class/block/$dev/ stats appear to be increased for fs metadata
> as well, which can also inflate value and we over-estimate.
>
> I'm running out of ideas for something more accurate/stable than v2.
>

I'm trying to understand if maybe you are running off the rails with
the estimation issue.
What the test aims to verify is that readahead prevents waiting
on IO in the future.
The max readahead size estimation is a very small part
of the test and not that significant IMO.
Why is the test not trying to readahead more than 64MB?
It's arbitrary. So my first proposal to over-estimation was
to cap upper estimation with 1MB, i.e.:

offset += MIN(max_ra_estimate, MAX_SANE_READAHEAD_ESTIMATION);

With this change we won't be testing if readahead of 64MB
in one go works anymore - it looks like getting that to work reliably
is more challenging and not sure its worth the trouble.

What you ended up implementing in v2 is not what I proposed
(you just disabled estimation altogether)
I am fine with the dynamic setting on min_sane_readahead
in v2, but it is independent of capping the upper limit for
estimation.

So what do you say about v2 + estimation (with or without reading
file backwards) and upper estimation limit?
Does it solve the sporadic failures problem?

Thanks,
Amir.
