From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Mar 2019 22:08:02 +0200
Subject: [LTP] [PATCH v2] syscalls/readahead02: limit max readahead to
 backing device max_readahead_kb
In-Reply-To: <518295220.5323766.1551804903461.JavaMail.zimbra@redhat.com>
References: <CAOQ4uxi49WogvHDck_JXiUV8VfLDHhzu=EYVYWiTz+zagT41KA@mail.gmail.com>
 <e27f21eef1ea317efcae24816b7a014e9e663f2d.1551802444.git.jstancek@redhat.com>
 <CAOQ4uxgc2NqK=6Lmau08y_k6tQa17xg8Q50UB+xwkgdetTWKuQ@mail.gmail.com>
 <518295220.5323766.1551804903461.JavaMail.zimbra@redhat.com>
Message-ID: <CAOQ4uxhAESuU2HZ73kU0tMZ4CvQSJPo4c176MuBoN9WrT2nhTg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 5, 2019 at 6:55 PM Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
> > On Tue, Mar 5, 2019 at 6:17 PM Jan Stancek <jstancek@redhat.com> wrote:
> > >
> > > Using system-wide "Cached" size is not accurate. The test is sporadically
> > > failing with warning on ppc64le 4.18 and 5.0 kernels.
> > >
> > > Problem is that test over-estimates max readahead size, which then
> > > leads to fewer readhead calls and kernel can silently trims length
> > > in each of them:
> > >   ...
> > >   readahead02.c:244: INFO: Test #2: POSIX_FADV_WILLNEED on file
> > >   readahead02.c:134: INFO: creating test file of size: 67108864
> > >   readahead02.c:263: INFO: read_testfile(0)
> > >   readahead02.c:274: INFO: read_testfile(1)
> > >   readahead02.c:189: INFO: max ra estimate: 12320768
> > >   readahead02.c:198: INFO: readahead calls made: 6
> > >   readahead02.c:204: PASS: offset is still at 0 as expected
> > >   readahead02.c:308: INFO: read_testfile(0) took: 492486 usec
> > >   readahead02.c:309: INFO: read_testfile(1) took: 430627 usec
> > >   readahead02.c:311: INFO: read_testfile(0) read: 67108864 bytes
> > >   readahead02.c:313: INFO: read_testfile(1) read: 59244544 bytes
> > >   readahead02.c:316: PASS: readahead saved some I/O
> > >   readahead02.c:324: INFO: cache can hold at least: 264192 kB
> > >   readahead02.c:325: INFO: read_testfile(0) used cache: 124992 kB
> > >   readahead02.c:326: INFO: read_testfile(1) used cache: 12032 kB
> > >   readahead02.c:338: WARN: using less cache than expected
> > >
> > > Stop relying on used cache size, and use backing device readahead
> > > limit instead.
> > >
> >
> > This is certainly better than 4K, but still feels like we are not really
> > testing
> > the API properly, but I'm fine with this fix.
> >
> > However... as follow up, how about extending the new
> > tst_dev_bytes_written() utils from Sumit to cover also bytes_read
> > and replace validation of readahead() from get_cached_size() diff
> > to tst_dev_bytes_read()?
>
> There is something similar based on /proc/self/io. We could try using
> that to estimate max readahead size.
>
> Or /sys/class/block/$dev/stat as you suggested, not sure which one is
> more accurate/up to date.
>

I believe /proc/self/io doesn't count IO performed by kernel async
readahead against the process that issued the readahead, but didn't
check. The test uses /proc/self/io to check how many IO where avoided
by readahead...

Do its the combination of both that gives the most information, i.e.:
X bytes read from device, Y bytes out of which read by process
on mmap access... (the rest must have been read by kernel readahead)

Thanks,
Amir.
