From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Jun 2017 15:17:52 +0200
Subject: [LTP] [PATCH] dio: reduce the number of cycles
In-Reply-To: <CAEemH2ebRhRDST+HMUB=LUge_w5TvEC7PaYDwCYxaP+hGjpiyQ@mail.gmail.com>
References: <20170614033830.12736-1-liwang@redhat.com>
 <20170614111610.GC17436@eguan.usersys.redhat.com>
 <20170614134939.GB7604@rei.suse.de>
 <20170615065430.GE17436@eguan.usersys.redhat.com>
 <20170615092307.GA27932@rei.lan>
 <CAEemH2ebRhRDST+HMUB=LUge_w5TvEC7PaYDwCYxaP+hGjpiyQ@mail.gmail.com>
Message-ID: <20170615131752.GA8212@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> > What's the reliability after the patch btw? What is the actual
> >> > percentage of undetected failures for at least 10 runs of the test?
> >>
> >> I ran diotest30 10 times with "-i 100" and 8 of them failed. IIRC, it
> >> was not 100% reproduced either when I first saw the test failure in
> >> 4.10-rc kernel testing. So I think ~80% probability to reproduce is
> >> fine.
> >
> > Fair enough I've added this paragraph to the commit message and pushed,
> > thanks.
> 
> Hmm, it does not takes about 100 minutes, without this change, it
> takes almost 9mins. After applying, only 50secs.
> 
> That's probably my description misleading you, sorry about that. Since
> you have already submitted this patch, so, let it go.

Strange, it does take about ~10 minutes after the patch is applied for
me and about ~100 before at least for diotest6, diotest3 is a bit faster
with ~20 minutes before and ~4 minutes after. That is on NUMA machine
with 24 CPUs and 16GB RAM and /tmp on Btrfs.

The diotest6 appears to be taking about ~45 minutes in our automated
framework before this patch and diotest3 takes about 3 minutes.

On my workstation the diotest3 takes ~5 minutes after the patch and
diotest06 takes ~45 minutes. That is much more modest machine with just
4GB RAM and 4 CPUs.

So I would say that the resulting time depends on many factors, most
notably the underlying I/O device, fileystem, number of CPUs and RAM.

-- 
Cyril Hrubis
chrubis@suse.cz
