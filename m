From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 7 Mar 2018 07:17:24 -0500 (EST)
Subject: [LTP] [PATCH] times03: don't assume process initial [us]time is
 0
In-Reply-To: <20180307104228.GB9871@rei>
References: <8385516ec732e57976aeef8789480c6bf0199bcb.1520411634.git.jstancek@redhat.com>
 <20180307104228.GB9871@rei>
Message-ID: <1678825917.5772447.1520425044614.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > times() runs immediately after fork(), but syscall alone
> > seems to be enough for some systems to already account ticks.
> > 
> > For example on arm64 with 4.14:
> >   tst_test.c:980: INFO: Timeout per run is 0h 05m 00s
> >   times03.c:102: PASS: buf1.tms_utime = 0
> >   times03.c:105: FAIL: buf1.tms_stime = 1
> >   ...
> > 
> > This patch drops the initial zero check for [us]time.
> 
> I wonder if we should drop only the system time counter check, since
> agruably the user time should be zero.

Current fork()/times() is likely not doing much in user-space, but
I'd rather not rely on that. If you want to keep the check, I'd
prefer to check for some small values.

Regards,
Jan

> Or if we should check that these
> values are small enough, i.e. < 5 (which should be somewhere between 5ms
> and 50ms depending on CONFIG_HZ).
> 
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
