From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 7 Jan 2019 09:28:40 -0500 (EST)
Subject: [LTP] [PATCH v3 3/3] lib/tst_test.c: Convert TFAIL to TWARN in
 test cleanup
In-Reply-To: <20190107133447.GB15221@rei.lan>
References: <20181211151733.GC1180@rei>
 <1544690160-13900-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1544690160-13900-3-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190107133447.GB15221@rei.lan>
Message-ID: <805797519.93649036.1546871320619.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> Hi!
> > 1) Both TBROK and TFAIL should be converted to TWARN in test cleanup.
> 
> Do we actually produce TFAIL somewhere in the test cleanups?
> 
> Actually producing TPASS or TFAIL in test cleanup sounds wrong to me.
> 
> > 2) Add a hint for the conversion.
> 
> I do not think that this very useful. Jan what do you think?

I'd rather not add more conversions.

Actually if we introduce results->broken counter as 2/3 is proposing,
then maybe we can drop current conversion too?

Regards,
Jan
