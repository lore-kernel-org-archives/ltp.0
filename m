From: Murphy Zhou <xzhou@redhat.com>
Date: Fri, 24 May 2019 12:32:01 +0800
Subject: [LTP] [PATCH v2 1/2] OVL_MNT: add setup_overlay helper
In-Reply-To: <20190515133102.GA5429@dell5510>
References: <20190503210005.GA18171@x230>
 <20190515092129.26336-1-xzhou@redhat.com>
 <20190515133102.GA5429@dell5510>
Message-ID: <20190524043201.sxmkm6b7dixn2kuw@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 15, 2019 at 03:31:02PM +0200, Petr Vorel wrote:
> Hi Murphy,
> 
> > To create overlayfs dirs, and mount overlayfs if needed.
> 
> ...
> > +int setup_overlay(int mountovl)
> > +{
> > +	int ret;
> > +
> > +	/* Setup an overlay mount with lower dir and file */
> > +	SAFE_MKDIR(OVL_LOWER, 0755);
> > +	SAFE_MKDIR(OVL_UPPER, 0755);
> > +	SAFE_MKDIR(OVL_WORK, 0755);
> > +	SAFE_MKDIR(OVL_MNT, 0755);
> > +
> > +	/* Only create dirs, do not mount */
> > +	if (mountovl == 0)
> > +		return 0;
> Instead of having int parameter, there could be create_overlay_dirs()
> and mount_overlay(), which would call create_overlay_dirs().
> (no need to lookup meaning of parameter).
> 
> > +
> > +	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
> > +		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
> > +	if (ret < 0) {
> > +		if (errno == ENODEV) {
> > +			tst_res(TINFO,
> > +				"overlayfs is not configured in this kernel.");
> > +			return 1;
> First I thought we'd implement it as a test flag (member of struct tst_test).
> When we have it as separate function I wonder whether we could TCONF on ENODEV
> instead of TINFO and return. Maybe there could be here for int strict parameter,

The return value is referenced in the testcase to determine whether to run
tests in overlayfs. It's needed.

If this strict parameter is only for different wording on NODEV. Is it
necessary ?

Murphy

> where 1 would be force safe (i.e. TCONF), otherwise only TINFO.
> This could also to have SAFE_MOUNT_OVERLAY() macro which would use mount_overlay().
> Similar approach as SAFE_SEND() and safe_send().
> 
> > +		}
> > +		tst_brk(TBROK | TERRNO, "overlayfs mount failed");
> > +	}
> > +	return 0;
> > +}
> 
> Kind regards,
> Petr
