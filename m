From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 5 Mar 2019 10:17:22 -0500 (EST)
Subject: [LTP] [PATCH/RFC] syscalls/readahead02: don't use cache size
In-Reply-To: <CAOQ4uxhqzTBkxva3Zhreb6o=EjnyFUkLutEjuNd8+jPn9bVr6w@mail.gmail.com>
References: <69e171efb14ec9078a4b70838f45ff5a550388d8.1551789098.git.jstancek@redhat.com>
 <CAOQ4uxhqzTBkxva3Zhreb6o=EjnyFUkLutEjuNd8+jPn9bVr6w@mail.gmail.com>
Message-ID: <565188461.5295049.1551799042924.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On Tue, Mar 5, 2019 at 2:34 PM Jan Stancek <jstancek@redhat.com> wrote:
> >
> > Using system-wide "Cached" size is not accurate. The test is sporadically
> > failing with warning on ppc64le 4.18 and 5.0 kernels.
> >
> > Problem is that test over-estimates max readahead size, which then
> > leads to fewer readhead calls and kernel can silently trims length
> > in each of them:
> >   ...
> >   readahead02.c:244: INFO: Test #2: POSIX_FADV_WILLNEED on file
> >   readahead02.c:134: INFO: creating test file of size: 67108864
> >   readahead02.c:263: INFO: read_testfile(0)
> >   readahead02.c:274: INFO: read_testfile(1)
> >   readahead02.c:189: INFO: max ra estimate: 12320768
> >   readahead02.c:198: INFO: readahead calls made: 6
> >   readahead02.c:204: PASS: offset is still at 0 as expected
> >   readahead02.c:308: INFO: read_testfile(0) took: 492486 usec
> >   readahead02.c:309: INFO: read_testfile(1) took: 430627 usec
> >   readahead02.c:311: INFO: read_testfile(0) read: 67108864 bytes
> >   readahead02.c:313: INFO: read_testfile(1) read: 59244544 bytes
> >   readahead02.c:316: PASS: readahead saved some I/O
> >   readahead02.c:324: INFO: cache can hold at least: 264192 kB
> >   readahead02.c:325: INFO: read_testfile(0) used cache: 124992 kB
> >   readahead02.c:326: INFO: read_testfile(1) used cache: 12032 kB
> >   readahead02.c:338: WARN: using less cache than expected
> >
> > Stop relying on used cache size, and use minimal sane readahead length,
> > that should work across all systems.
> 
> But now instead of over estimating readahead length you definetly
> underestimate it resulting in way too many readahead calls
> (reahead every 4K block), which does not validate long readahead
> code is working at all.

We could try to cap on backing device read_ahead_kb.

> 
> How about this patch instead.
> Can you say with sufficient confidence if it solves the sporadic errors?

It likely won't. We started at 2M couple years back, but there
were several commit that keep changing the limit: [1][2]

[1] 600e19afc5f8a6c18ea49cee9511c5797db02391
[2] https://lkml.org/lkml/2016/7/25/308

> Also, IMO if you solve the estimation problem, there is no need to
> remove the WARNING, it may still be informative.
> 
> Thanks,
> Amir.
> 
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -50,6 +50,8 @@ static int ovl_mounted;
>  #define OVL_WORK       MNTPOINT"/work"
>  #define OVL_MNT                MNTPOINT"/ovl"
>  #define MIN_SANE_READAHEAD (4u * 1024u)
> +/* To avoid over estimation of readahead length */
> +#define MAX_SANE_READAHEAD (1024u * 1024u)
> 
>  static const char mntpoint[] = MNTPOINT;
> 
> @@ -193,7 +195,7 @@ static int read_testfile(struct tcase *tc, int
> do_readahead,
>                         }
> 
>                         i++;
> -                       offset += max_ra_estimate;
> +                       offset += MIN(max_ra_estimate, MAX_SANE_READAHEAD);
>                 } while ((size_t)offset < fsize);
>                 tst_res(TINFO, "readahead calls made: %zu", i);
>                 *cached = get_cached_size();
> 
