From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Feb 2019 14:04:52 +0530
Subject: [LTP] [PATCH v2] mtest06/mmap1: rewrite to newlib
In-Reply-To: <2002461812.80702248.1543571192512.JavaMail.zimbra@redhat.com>
References: <0e62adebbb4e5c8e3aa28440f860234b937d3e56.1543219161.git.jstancek@redhat.com>
 <20181129134411.GA22216@rei.lan>
 <2002461812.80702248.1543571192512.JavaMail.zimbra@redhat.com>
Message-ID: <CA+G9fYv1707K7G0x3cFVC9HXtwuwMVZLUp+6-qe6+14pi0sNhw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

FYI,

mtest06/mmap1.c fails intermittently on arm64 devices due to timeout reason.
The current timeout set as 15 minutes
export LTP_TIMEOUT_MUL=3

Test case output:
-----------------------
tst_test.c:1085: INFO: Timeout per run is 0h 15m 00s
tst_test.c:1085: INFO: Timeout per run is 0h 09m 00s
mmap1.c:234: INFO: [3] mapped: 15000, sigsegv hit: 11375, threads spawned: 6
mmap1.c:237: INFO: [3] repeated_reads: 67, data_matched: 3440667
mmap1.c:234: INFO: [6] mapped: 30000, sigsegv hit: 21256, threads spawned: 12
mmap1.c:237: INFO: [6] repeated_reads: 2530, data_matched: 8455962
mmap1.c:234: INFO: [9] mapped: 40000, sigsegv hit: 28215, threads spawned: 16
mmap1.c:237: INFO: [9] repeated_reads: 4413, data_matched: 11314629
mmap1.c:234: INFO: [12] mapped: 55000, sigsegv hit: 38454, threads spawned: 22
mmap1.c:237: INFO: [12] repeated_reads: 9285, data_matched: 15892633
mmap1.c:234: INFO: [15] mapped: 60000, sigsegv hit: 42462, threads spawned: 24
mmap1.c:237: INFO: [15] repeated_reads: 11993, data_matched: 16723333
mmap1.c:234: INFO: [18] mapped: 65000, sigsegv hit: 46272, threads spawned: 26
mmap1.c:237: INFO: [18] repeated_reads: 11993, data_matched: 18043857
mmap1.c:234: INFO: [21] mapped: 80000, sigsegv hit: 58736, threads spawned: 32
mmap1.c:237: INFO: [21] repeated_reads: 14467, data_matched: 20310080
mmap1.c:234: INFO: [24] mapped: 85000, sigsegv hit: 62747, threads spawned: 34
mmap1.c:237: INFO: [24] repeated_reads: 14467, data_matched: 21065412
mmap1.c:234: INFO: [27] mapped: 95000, sigsegv hit: 67177, threads spawned: 38
mmap1.c:237: INFO: [27] repeated_reads: 14467, data_matched: 26278412
mmap1.c:234: INFO: [30] mapped: 110000, sigsegv hit: 75318, threads spawned: 44
mmap1.c:237: INFO: [30] repeated_reads: 18749, data_matched: 32880471
mmap1.c:234: INFO: [33] mapped: 130000, sigsegv hit: 86435, threads spawned: 52
mmap1.c:237: INFO: [33] repeated_reads: 20987, data_matched: 41628336
mmap1.c:234: INFO: [36] mapped: 150000, sigsegv hit: 95359, threads spawned: 60
mmap1.c:237: INFO: [36] repeated_reads: 20987, data_matched: 52762236
mmap1.c:234: INFO: [39] mapped: 175000, sigsegv hit: 107473, threads spawned: 70
mmap1.c:237: INFO: [39] repeated_reads: 20987, data_matched: 65170250
mmap1.c:234: INFO: [42] mapped: 195000, sigsegv hit: 115860, threads spawned: 78
mmap1.c:237: INFO: [42] repeated_reads: 24446, data_matched: 76553410
mmap1.c:234: INFO: [45] mapped: 220000, sigsegv hit: 130868, threads spawned: 88
mmap1.c:237: INFO: [45] repeated_reads: 28657, data_matched: 86358966
mmap1.c:234: INFO: [48] mapped: 245000, sigsegv hit: 145435, threads spawned: 98
mmap1.c:237: INFO: [48] repeated_reads: 34613, data_matched: 96820804
mmap1.c:234: INFO: [51] mapped: 260000, sigsegv hit: 154934, threads
spawned: 104
mmap1.c:237: INFO: [51] repeated_reads: 38042, data_matched: 102281865
mmap1.c:234: INFO: [54] mapped: 280000, sigsegv hit: 168403, threads
spawned: 112
mmap1.c:237: INFO: [54] repeated_reads: 44799, data_matched: 108884699
mmap1.c:234: INFO: [57] mapped: 305000, sigsegv hit: 188132, threads
spawned: 122
mmap1.c:237: INFO: [57] repeated_reads: 48995, data_matched: 113829351
mmap1.c:234: INFO: [60] mapped: 315000, sigsegv hit: 196457, threads
spawned: 126
mmap1.c:237: INFO: [60] repeated_reads: 51657, data_matched: 115444681
mmap1.c:234: INFO: [63] mapped: 330000, sigsegv hit: 208077, threads
spawned: 132
mmap1.c:237: INFO: [63] repeated_reads: 51657, data_matched: 118910807
mmap1.c:234: INFO: [66] mapped: 335000, sigsegv hit: 211847, threads
spawned: 134
mmap1.c:237: INFO: [66] repeated_reads: 51657, data_matched: 119936305
mmap1.c:234: INFO: [69] mapped: 355000, sigsegv hit: 225809, threads
spawned: 142
mmap1.c:237: INFO: [69] repeated_reads: 58357, data_matched: 125691672
mmap1.c:234: INFO: [72] mapped: 365000, sigsegv hit: 233748, threads
spawned: 146
mmap1.c:237: INFO: [72] repeated_reads: 63594, data_matched: 127682094
mmap1.c:234: INFO: [75] mapped: 375000, sigsegv hit: 240935, threads
spawned: 150
mmap1.c:237: INFO: [75] repeated_reads: 65813, data_matched: 130436913
mmap1.c:234: INFO: [78] mapped: 395000, sigsegv hit: 256994, threads
spawned: 158
mmap1.c:237: INFO: [78] repeated_reads: 68240, data_matched: 134313071
mmap1.c:234: INFO: [81] mapped: 400000, sigsegv hit: 260739, threads
spawned: 160
mmap1.c:237: INFO: [81] repeated_reads: 68240, data_matched: 135483078
mmap1.c:234: INFO: [84] mapped: 405000, sigsegv hit: 263510, threads
spawned: 162
mmap1.c:237: INFO: [84] repeated_reads: 68240, data_matched: 137744513
mmap1.c:234: INFO: [87] mapped: 415000, sigsegv hit: 271049, threads
spawned: 166
mmap1.c:237: INFO: [87] repeated_reads: 70071, data_matched: 140167936
mmap1.c:234: INFO: [90] mapped: 430000, sigsegv hit: 282504, threads
spawned: 172
mmap1.c:237: INFO: [90] repeated_reads: 74335, data_matched: 143263860
mmap1.c:234: INFO: [93] mapped: 435000, sigsegv hit: 286623, threads
spawned: 174
mmap1.c:237: INFO: [93] repeated_reads: 76581, data_matched: 144114430
mmap1.c:234: INFO: [96] mapped: 445000, sigsegv hit: 292401, threads
spawned: 178
mmap1.c:237: INFO: [96] repeated_reads: 78725, data_matched: 148160778
mmap1.c:234: INFO: [99] mapped: 450000, sigsegv hit: 296192, threads
spawned: 180
mmap1.c:237: INFO: [99] repeated_reads: 78725, data_matched: 149328825
mmap1.c:234: INFO: [102] mapped: 460000, sigsegv hit: 304280, threads
spawned: 184
mmap1.c:237: INFO: [102] repeated_reads: 78725, data_matched: 151183014
mmap1.c:234: INFO: [105] mapped: 465000, sigsegv hit: 308364, threads
spawned: 186
mmap1.c:237: INFO: [105] repeated_reads: 78725, data_matched: 152036389
Test timeouted, sending SIGKILL!
tst_test.c:1125: INFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1126: BROK: Test killed! (timeout?)

Test results comparison,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-mm-tests/mtest06

Any chance to minimize the test run time ?

Best regards
Naresh Kamboju


On Fri, 30 Nov 2018 at 15:16, Jan Stancek <jstancek@redhat.com> wrote:
>
>
>
> ----- Original Message -----
> > Hi!
> > > Instead each mmap/munmap increases a map/unmap counter. Upon hitting
> > > SIGSEGV or when comparing read value, these counter values are used
> > > to determine state of mapped area as observed by first thread.
> > > This isn't 100% accurrate as first thread might be faster than the
> > > check, but it allows second thread to race against map/unmap for
> > > its entire duration.
> >
> > Looks good to me, using atomic counters and comparing values before and
> > after we access the memory is very clever as well. You can add my
> > Reviewed-by.
> >
> > Very minor comments below.
> > > +/* compare "before read" counters  with "after read" counters */
> > > +static inline int was_area_mapped(int br_m, int br_u, int ar_m, int ar_u)
> > > +{
> > > +   return (br_m == ar_m && br_u == ar_u && br_m > br_u);
> > > +}
> >
> > Since the br_map and br_unmap are global I would consider passing only
> > the values after to this function.
>
> Hi,
>
> I find it more clear if it doesn't depend on globals. Since it's inlined
> there should be no penalty, so I kept it as is.
>
> > > +
> > > +void *read_mem(LTP_ATTRIBUTE_UNUSED void *ptr)
> > > +{
> > > +   int i, j, ar_map, ar_unmap;
> > > +   unsigned char c;
> > > +
> > > +   for (i = 0; i < num_iter; i++) {
> > > +           if (setjmp(jmpbuf) == 1)
> > > +                   continue;
>
> I made 'i' volatile, since longjmp could clobber it.
>
> > > +static void run(void)
> > > +{
> > > +   pthread_t thid[2];
> > > +   long chld_args[1];
> > > +   int remaining = tst_timeout_remaining();
> > > +   int elapsed = 0;
> > > +
> > > +   while (tst_timeout_remaining() > STOP_THRESHOLD) {
> > > +           int fd = mkfile(file_size);
> > > +
> > > +           tst_atomic_store(0, &mapcnt);
> > > +           tst_atomic_store(0, &unmapcnt);
> > > +
> > > +           chld_args[0] = fd;
> >
> > I would have just casted the fd here to long or intptr_t (to make sure
> > compiler padds it with zeroes) then to (void*) and passed the value
> > directly, i.e. (void*)(inptr_t)fd and then back in the thread we do
> > fd = (intptr_t)ptr.
>
> I changed this to pass int ptr directly, which requires no casts AFAICT.
>
> ... and pushed.
>
> Thanks,
> Jan
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
