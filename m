From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Feb 2021 20:10:14 +0100
Subject: [LTP] [PATCH 2/2] keyctl05: TCONF on FIPS mode
In-Reply-To: <YCamj5IAuyPMOcBo@yuki.lan>
References: <20210202130441.17861-1-pvorel@suse.cz>
 <20210202130441.17861-2-pvorel@suse.cz> <YCamj5IAuyPMOcBo@yuki.lan>
Message-ID: <YCbSlgcTS8XM5yp/@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > +	int is_asymmetric = !strcmp(type, "asymmetric");
> > +
> >  	TEST(add_key(type, "desc", payload, plen, KEY_SPEC_SESSION_KEYRING));
> >  	if (TST_RET < 0) {
> > +		if (TST_ERR == EINVAL && is_asymmetric && tst_fips_enabled()) {
>                                                           ^
> 							  I guess that
> 							  we can save
> 							  the value in
> 							  test setup
> 							  instead of
> 							  re-reading it
> 							  on every
> 							  iteration.

> Other than that it looks good to me.
Good point, thanks! Moved to variable set at setup and merged.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


Kind regards,
Petr
