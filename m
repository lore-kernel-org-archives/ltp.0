From: Li Wang <liwang@redhat.com>
Date: Sat, 22 Feb 2020 11:02:26 +0800
Subject: [LTP] [PATCH v4 1/2] lib: add .request_hugepages to reserve
 hugepage
In-Reply-To: <20200221121618.GA16421@dell5510>
References: <20200208092014.24824-1-liwang@redhat.com>
 <20200218162739.GA9985@rei.lan> <20200221121618.GA16421@dell5510>
Message-ID: <CAEemH2ftLanZppq4kiVCK7JuRvCh+xX4GG9--GKrOQ8j8c2idw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Feb 21, 2020 at 8:16 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li, Cyril,
>
> > > +   if (FILE_LINES_SCANF("/proc/meminfo",
> > > +                           "MemAvailable: %ld", &mem_avail)) {
> > > +           /*
> > > +            * Using "MemFree:" on kernel that doesn't have
> > > +            * "MemAvailable:" in Meminfo
> > > +            */
> > > +           tst_res(TINFO, "MemAvailable: not found in /proc/meminfo");
> > > +
> > > +           mem_avail = SAFE_READ_MEMINFO("MemFree:");
> > > +   }
>
> > I guess that we don't have to bother with MemAvailable here, since we do
> > drop the system caches the MemFree should be equal to MemAvailable. So I
> > would be for reading just MemFree unconditionally here.
>
> > If you agree with this change I can change it before applying.
>
> Merged both patches with this change and my docs change.
>

Thanks very much Petr. Btw, I added a commit to remove the surplus variable
'mem_avail'.(It's a tiny issue so I pushed directly:)

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200222/9598924f/attachment-0001.htm>
