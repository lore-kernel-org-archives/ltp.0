From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 16 Oct 2019 10:03:42 -0400 (EDT)
Subject: [LTP] [PATCH] lib: tst_taint: Ignore WARN taint flag if already
 set
In-Reply-To: <bc2f54f1-3be1-cf77-7475-3c08cbd24850@suse.de>
References: <20191016131506.17193-1-chrubis@suse.cz>
 <bc2f54f1-3be1-cf77-7475-3c08cbd24850@suse.de>
Message-ID: <1535033044.6472706.1571234622819.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi,
> 
> On 16.10.19 15:15, Cyril Hrubis wrote:
> > This commit changes the library so that it ignores the taint warn flag
> > if it was set prior to the test run. It turns out that the warn taint
> > flag is not well defined and could be easily set on a freshly booted
> > kernel for example when buggy BIOS is detected.>
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > CC: Jan Stancek <jstancek@redhat.com>
> > CC: Chang Yin <cyin@redhat.com>
> > ---
> > 
> > I haven't tested this, since I don't have a system where the flag is set
> > at hand, but it's simple enough so that it should work as expected.
> > 
> >  lib/tst_taint.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/tst_taint.c b/lib/tst_taint.c
> > index a5dbf77d2..3de6d72f4 100644
> > --- a/lib/tst_taint.c
> > +++ b/lib/tst_taint.c
> > @@ -82,8 +82,13 @@ void tst_taint_init(unsigned int mask)
> >  		tst_res(TCONF, "Kernel is too old for requested mask");
> >  
> >  	taint_mask = mask;
> > -
> >  	taint = tst_taint_read();
> > +
> > +	if (mask & TST_TAINT_W && taint & TST_TAINT_W) {
> > +		tst_res(TCONF, "Ignoring already set kernel warning taint");
> > +		mask &= ~TST_TAINT_W;
> > +	}
> > +
> >  	if ((taint & mask) != 0)
> >  		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
> >  }
> > 
> 
> Tests may rely on TAINT_W to decide the result.
> If we need TAINT_W, we can only run the test when it was not set before. For example,
> testcases/cve/cve-2017-17053.c relies on this.
> This may render this testcase unusable, or do I get this wrong?

Patch masks TAINT_W if that taint flag was set before test started. In such case,
test can't determine result accurately anyway.

I wonder if there is more specific way for cve-2017-17053 to determine
error condition. For example by inspecting new messages in dmesg.
