From: Li Wang <liwang@redhat.com>
Date: Sat, 25 Jan 2020 17:23:07 +0800
Subject: [LTP] [PATCH v3 1/2] lib: add .request_hugepages to reserve
 hugepage
In-Reply-To: <20200122143133.GA29412@rei>
References: <20191218090202.26932-1-liwang@redhat.com>
 <20200122143133.GA29412@rei>
Message-ID: <CAEemH2dTvYLRO5hyy-T4G-qB7KikbN=Q7zcy+mMp6dYF=XcUCw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jan 22, 2020 at 10:31 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> ...
> > +static void run(void)
> > +{
> > +     ...
> > +
> > +     if (tst_hugepages == test.request_hugepages)
> > +             TEST(do_hpage_test);
> > +     else
> > +             ...
> > +     ...
> > +}
>
> I guess that it would be more instructive to check the value in the test
> setup() here, because most of the test would just check if tst_hugepages
> has been set to expected value.
>

Yes, that will fit most situations.


> ...
> > +     if (access(PATH_HUGEPAGES, F_OK)) {
> > +             tst_res(TCONF, "Huge page is not supported.");
>
> I guess that this is something the test has to decide, i.e. I wouldn't
> print anything here.
>

OK.

>
> > +             tst_hugepages = 0;
> > +             goto out;
> > +     }
> > +
> > +     tst_hugepages = hpages;
> > +
> > +     SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
>
> Shouldn't we drop the caches only if MemAvailable is not present in
> /proc/meminfo?
>

Yes, that's right theoretically. But the reason I moved it here is that the
huge page reserving easily failed on a small RAM(1~2GB) system because of
too much caches.


>
> > +     if (FILE_LINES_SCANF("/proc/meminfo",
> > +                             "MemAvailable: %ld", &mem_avail)) {
> > +             /*
> > +              * Using "MemFree:" on kernel that doesn't have
> > +              * "MemAvailable:" in Meminfo
> > +              */
> > +             tst_res(TINFO, "MemAvailable: not found in /proc/meminfo");
> > +
> > +             mem_avail = SAFE_READ_MEMINFO("MemFree:");
> > +     }
> > +
> > +     max_hpages = mem_avail / SAFE_READ_MEMINFO("Hugepagesize:");
> > +
> > +     if (hpages > max_hpages) {
> > +             tst_res(TINFO, "Requested number(%d) of hugepages is too
> large, "
> > +                             "limiting to 80%% of the max hugepage
> count %ld",
> > +                             hpages, max_hpages);
> > +             tst_hugepages = max_hpages * 0.8;
>
> Why 80%?
>

I choose(base on personal experience) this number to try again, to satisfy
some test which does not need precise hpages can still run.

Or, maybe let's remove this part, and limit LTP to make use of a precise
number(the at least) of hpage in each test?

>
> Also I guess that we should check here that max_hpages * 0.8 > 1,
> otherwise there is no reason to continue.
>

Agreed.
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200125/cf9223ca/attachment-0001.htm>
