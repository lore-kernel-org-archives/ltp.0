From: Chunyu Hu <chuhu@redhat.com>
Date: Fri, 22 Jul 2016 06:54:47 -0400 (EDT)
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <1624002578.18739039.1469184591173.JavaMail.zimbra@redhat.com>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
 <1822250385.6269456.1468911402613.JavaMail.zimbra@redhat.com>
 <20160719085756.GB31704@gmail.com> <578F8CB6.2020602@redhat.com>
 <597691787.18542977.1469097118207.JavaMail.zimbra@redhat.com>
 <20160721110159.GA13274@gmail.com> <5790DADF.8000506@redhat.com>
 <1624002578.18739039.1469184591173.JavaMail.zimbra@redhat.com>
Message-ID: <1364997364.18740114.1469184887166.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Chunyu Hu" <chuhu@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Friday, July 22, 2016 6:49:51 PM
> Subject: Re: [LTP] [PATCH] madvise06: wait a bit after madvise() call
> 
> 
> 
> ----- Original Message -----
> > From: "Jan Stancek" <jstancek@redhat.com>
> > To: "Li Wang" <liwang@redhat.com>, "Chunyu Hu" <chuhu@redhat.com>
> > Cc: ltp@lists.linux.it
> > Sent: Thursday, July 21, 2016 10:23:27 PM
> > Subject: Re: [LTP] [PATCH] madvise06: wait a bit after madvise() call
> > 
> > On 07/21/2016 01:02 PM, Li Wang wrote:
> > > On Thu, Jul 21, 2016 at 06:31:58AM -0400, Chunyu Hu wrote:
> > >>>
> > >>> If you still have the setup, can you try how reliable is this approach?
> > >>
> > >> I also had a try on my desktop. I copied the file as a.c and compiled it
> > >> in ltp.
> > >> Result is that if the sys is fresh with low Cache, it can pass rightly.
> > >> But if
> > >> the Cache is before exhausted, it can hit failure, as the thresh_hold is
> > >> too
> > >> large to get there. Just FYI.
> > 
> > I'm not sure I follow here, your /proc/meminfo shows:
> > Cached:           260124 kB
> > SwapCached:        38096 kB
> > 
> > That doesn't seem very high to me.
> 
> Sorry. This info is just for showing the system info. I didn't save the info
> at the beginning,
> this is the info after a reboot.
> 
> The other case that reproduced the false positive issue is when another
> WILL_NEED process swapping
> a large mem(4G) at the same.
> 
> 
> 
> > > 
> > > Yes, Chunyu ran failed the case with his destop(uptime more than 30days)
> > > at
> > > first,
> > > after rebooting it could be PASS.
> > 
> > I'm starting to run out of ideas how we can test this somewhat reliably.
> > 
> > Attached is approach v3, which sets up memory cgroup:
> > - memory.limit_in_bytes is 128M
> > - we allocate 512M
> > - as consequence ~384M should be swapped while system should still have
> >   plenty of free memory, which should be available for cache

I use the same host to test your V3, didn't reproduce the false positive issue.
It skipped the test when the swap space is so large successfully. So great V3! Thanks.
I guess if we got the V4, that's must be tricky, but seems no need now?

[root@dhcp-chuhu mem]# ./b
tst_test.c:701: INFO: Timeout per run is 300s
b.c:73: INFO: dropping caches
b.c:175: INFO: SwapCached (before madvise): 78688
b.c:188: INFO: SwapCached (after madvise): 486628
b.c:190: PASS: Regression test pass

Summary:
passed   1
failed   0
skipped  0
warnings 0
[root@dhcp-chuhu mem]# ./b
tst_test.c:701: INFO: Timeout per run is 300s
b.c:73: INFO: dropping caches
b.c:78: CONF: System RAM is too small, skip test

Summary:
passed   0
failed   0
skipped  0
warnings 0



> > Regards,
> > Jan
> > 
> > 
> 
> --
> Regards,
> Chunyu Hu
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Regards,
Chunyu Hu

