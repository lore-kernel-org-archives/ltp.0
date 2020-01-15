From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Jan 2020 11:46:27 +0100
Subject: [LTP] [PATCH v2] tst_dev_bytes_written: parsing /proc/diskstats
 instead of sys file
In-Reply-To: <20200110123012.GA14140@rei.lan>
References: <1578299418-4961-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200108131231.GA23619@rei.lan>
 <bee8d39f-723f-491d-8676-a1c303f0a5bb@cn.fujitsu.com>
 <CAFA6WYMk-bT7xKG7nov8mzd=b4T1gzghxrFz9x_OegU8mtSNVA@mail.gmail.com>
 <20200110123012.GA14140@rei.lan>
Message-ID: <20200115104627.GB24851@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > Maybe, I am fine with your way(I tested it). I only  refer to kernel
> > > documention [1] .sysfs and proc file  use the same source for the
> > > information and so should not differ. So I use fixed format as kernel
> > > function to exact.  Also, I want to listen advise from Sumit.


> > TBH, I think it's just a matter of taste. I am fine with either approach.

> I dot not like that much that we generate the scanf format string on the
> fly in the version that parses /proc/diskstat.
+1

> In the end we have to merge one of them, I slightly prefer mine, but I
> do not have a strong feelings about this.
+1

If we merge Cyril's, I'd be for adding the hint about LTP_DEV (maybe as a
separate commit).

Thank you both for working on this fix.

Kind regards,
Petr
