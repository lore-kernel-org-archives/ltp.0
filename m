From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Jul 2016 07:02:41 -0400 (EDT)
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <1364997364.18740114.1469184887166.JavaMail.zimbra@redhat.com>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
 <20160719085756.GB31704@gmail.com> <578F8CB6.2020602@redhat.com>
 <597691787.18542977.1469097118207.JavaMail.zimbra@redhat.com>
 <20160721110159.GA13274@gmail.com> <5790DADF.8000506@redhat.com>
 <1624002578.18739039.1469184591173.JavaMail.zimbra@redhat.com>
 <1364997364.18740114.1469184887166.JavaMail.zimbra@redhat.com>
Message-ID: <1001938980.7344214.1469185361447.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Chunyu Hu" <chuhu@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, "Chunyu Hu" <chuhu@redhat.com>
> Sent: Friday, 22 July, 2016 12:54:47 PM
> Subject: Re: [LTP] [PATCH] madvise06: wait a bit after madvise() call
> > > 
> > > Attached is approach v3, which sets up memory cgroup:
> > > - memory.limit_in_bytes is 128M
> > > - we allocate 512M
> > > - as consequence ~384M should be swapped while system should still have
> > >   plenty of free memory, which should be available for cache
> 
> I use the same host to test your V3, didn't reproduce the false positive
> issue.
> It skipped the test when the swap space is so large successfully. So great
> V3! Thanks.
> I guess if we got the V4, that's must be tricky, but seems no need now?

I posted v3 just now. I reduced allocated size to 400M, so it should
run also on systems as small as 1GB RAM. Other than that, it contains
feedback from Li and some additional checks so it TCONFs on older kernels
which don't have all /proc and memory cgroup knobs.

Regards,
Jan

> 
> [root@dhcp-chuhu mem]# ./b
> tst_test.c:701: INFO: Timeout per run is 300s
> b.c:73: INFO: dropping caches
> b.c:175: INFO: SwapCached (before madvise): 78688
> b.c:188: INFO: SwapCached (after madvise): 486628
> b.c:190: PASS: Regression test pass
> 
> Summary:
> passed   1
> failed   0
> skipped  0
> warnings 0
> [root@dhcp-chuhu mem]# ./b
> tst_test.c:701: INFO: Timeout per run is 300s
> b.c:73: INFO: dropping caches
> b.c:78: CONF: System RAM is too small, skip test
> 
> Summary:
> passed   0
> failed   0
> skipped  0
> warnings 0
> 
> 
> 
> > > Regards,
> > > Jan
> > > 
> > > 
> > 
> > --
> > Regards,
> > Chunyu Hu
> > 
> > 
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> > 
> 
> --
> Regards,
> Chunyu Hu
> 
> 
