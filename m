From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 16 Jan 2017 07:51:09 -0500 (EST)
Subject: [LTP] LTP release status
In-Reply-To: <20170112153917.GB5381@rei.lan>
References: <20170112142828.GC1208@rei.lan>
 <1124039564.1917107.1484233086635.JavaMail.zimbra@redhat.com>
 <20170112153917.GB5381@rei.lan>
Message-ID: <1054431302.3375878.1484571069128.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 12 January, 2017 4:39:18 PM
> Subject: Re: [LTP] LTP release status
> 
> Hi!
> > > I would like to finally do the release at the start of the next week, is
> > > that OK with everyone or do we need some more time for pre-release
> > > testruns?
> > 
> > Couple more days would be great. I'll try to schedule tests on various
> > RHELs
> > tomorrow, but some reserve would be nice to have.
> 
> Okay then, just let me know once we are ready.

Looks good over here, I've been running tests on RHEL6.2 up to 7.3,
plus a RHEL7.3 with recent upstream kernel.

I found only 2 problems (and sent 2 patches) for:
- tst_resm_hexd
- quotactl01 on big endian systems

Regards,
Jan
