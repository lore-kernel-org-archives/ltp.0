From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 16 Jan 2017 08:19:40 -0500 (EST)
Subject: [LTP] LTP release status
In-Reply-To: <20170116130237.GA26610@rei.lan>
References: <20170112142828.GC1208@rei.lan>
 <1124039564.1917107.1484233086635.JavaMail.zimbra@redhat.com>
 <20170112153917.GB5381@rei.lan>
 <1054431302.3375878.1484571069128.JavaMail.zimbra@redhat.com>
 <20170116130237.GA26610@rei.lan>
Message-ID: <1116838376.3405880.1484572780617.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 16 January, 2017 2:02:38 PM
> Subject: Re: [LTP] LTP release status
> 
> Hi!
> > > > Couple more days would be great. I'll try to schedule tests on various
> > > > RHELs
> > > > tomorrow, but some reserve would be nice to have.
> > > 
> > > Okay then, just let me know once we are ready.
> > 
> > Looks good over here, I've been running tests on RHEL6.2 up to 7.3,
> > plus a RHEL7.3 with recent upstream kernel.
> > 
> > I found only 2 problems (and sent 2 patches) for:
> > - tst_resm_hexd
> > - quotactl01 on big endian systems
> 
> Good. I've acked these two already.
> 
> And also pushed the fix for unprobable munmap_2-1 failure from Richie
> since I'm pretty sure that it will not break anything and that it fixes
> real segfaults.
> 
> I have one more problem, zram01 fails on ppc64le since minimal btrfs
> size there is larger due to larger page size. I think that I may be able
> to parse mkfs.btrfs output to get the minimal size and adjust the size
> of the zram device in the test setup but I consider this too risky for
> the release.

I recall running into something similar in one non-LTP test.
I had to bump (back in 2013) ramdisk (brd) size to 384M on ppc systems.

> 
> So I guess I should tag the git and write the release notes once you
> push your patches, okay?

Fine by me. I'm going to look at pushing those 2 patches.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
