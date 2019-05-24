From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 May 2019 10:54:52 +0200
Subject: [LTP] [PATCH v2 1/2] OVL_MNT: add setup_overlay helper
In-Reply-To: <20190524043201.sxmkm6b7dixn2kuw@XZHOUW.usersys.redhat.com>
References: <20190503210005.GA18171@x230>
 <20190515092129.26336-1-xzhou@redhat.com>
 <20190515133102.GA5429@dell5510>
 <20190524043201.sxmkm6b7dixn2kuw@XZHOUW.usersys.redhat.com>
Message-ID: <20190524085452.GB29592@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Murphy,

> > > +	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
> > > +		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
> > > +	if (ret < 0) {
> > > +		if (errno == ENODEV) {
> > > +			tst_res(TINFO,
> > > +				"overlayfs is not configured in this kernel.");
> > > +			return 1;
> > First I thought we'd implement it as a test flag (member of struct tst_test).
> > When we have it as separate function I wonder whether we could TCONF on ENODEV
> > instead of TINFO and return. Maybe there could be here for int strict parameter,

> The return value is referenced in the testcase to determine whether to run
> tests in overlayfs. It's needed.

> If this strict parameter is only for different wording on NODEV. Is it
> necessary ?

I'll recap my suggestions:
1) I like having macros to help reduce some parameters, this does not block
functions being flexible (which requires parameters).
2) Having helper function create_overlay_dirs() used separately, than parameter
in single function (Amir [1] suggestion makes sense).

Something like this, just a suggestion:

int create_overlay_dirs()
{
	SAFE_MKDIR(OVL_LOWER, 0755);
	...
	return ret;
}

int mount_overlay(const char *file, const int lineno, int safe)
{
	...
	if (create_overlay_dirs())
		tst_brk(TCONF, "...");

	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
	if (ret < 0) {
		if (errno == ENODEV) {
			/*
			 * TODO: maybe safe is confusing as we use tst_brk(TBROK anyway),
			 * + sometimes tst_res(TCONF, ..) would be preferred over
			 * tst_brk(TCONF, ...)
			 */
			if (safe)
				tst_brk(TCONF,
					"overlayfs is not configured in this kernel.");
			} else {
				tst_res(TINFO,
					"overlayfs is not configured in this kernel.");
				return 1;
			}
		}
		tst_brk(TBROK | TERRNO, "overlayfs mount failed");
	}
}

#define SAFE_MOUNT_OVERLAY() \
	mount_overlay(__FILE__, __LINE__, 1);

#define TST_MOUNT_OVERLAY() \
	mount_overlay(__FILE__, __LINE__, 0);

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2019-May/011983.html
