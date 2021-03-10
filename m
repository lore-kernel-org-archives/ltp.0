From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Mar 2021 15:28:47 +0100
Subject: [LTP] [PATCH 1/3] lib: Add proper filesystem skiplist
In-Reply-To: <YEjCfVLhoLPMDEgu@pevik>
References: <20210310122625.25425-1-chrubis@suse.cz>
 <20210310122625.25425-2-chrubis@suse.cz> <YEjCfVLhoLPMDEgu@pevik>
Message-ID: <YEjXn0FN25d6K0Lv@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > -static int has_kernel_support(const char *fs_type, int flags)
> > +int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist)
> > +{
> > +	unsigned int i;
> > +
> > +	if (!skiplist)
> > +		return 0;
> > +
> > +	for (i = 0; skiplist[i]; i++) {
> > +		if (!strcmp(fs_type, skiplist[i])) {
> > +			tst_res(TINFO,
> It'd be nice if skipping message could be TCONF to avoid:
> tst_supported_fs_types.c:57: TINFO: Skipping tmpfs as requested by the test
> tst_test.c:1056: TCONF: Skipping due to unsupported filesystem
> 
> but understand why - it'd make code more complicated (has_kernel_support() which
> is used in tst_fs_is_supported() should not emit TCONF).

I can make a internal wrapper for the tst_fs_is_supported() that prints
the TINFO message and use that in the tst_supported_fs_types, which
would make it silent in the case it's called from the test library...

-- 
Cyril Hrubis
chrubis@suse.cz
