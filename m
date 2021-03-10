From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Mar 2021 17:22:04 +0100
Subject: [LTP] [PATCH 1/3] lib: Add proper filesystem skiplist
In-Reply-To: <30fec758-5e18-fceb-ec23-646253ba0e46@suse.cz>
References: <20210310122625.25425-1-chrubis@suse.cz>
 <20210310122625.25425-2-chrubis@suse.cz>
 <30fec758-5e18-fceb-ec23-646253ba0e46@suse.cz>
Message-ID: <YEjyLBZQ+D1CHqnq@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static int has_kernel_support(const char *fs_type, const char *const *skiplist)
> >  {
> >  	static int fuse_supported = -1;
> >  	const char *tmpdir = getenv("TMPDIR");
> >  	char buf[128];
> >  	int ret;
> >  
> > +	if (tst_fs_in_skiplist(fs_type, skiplist))
> > +		return 0;
> > +
> >  	if (!tmpdir)
> >  		tmpdir = "/tmp";
> >  
> > @@ -84,26 +105,24 @@ static int has_kernel_support(const char *fs_type, int flags)
> >  		return 0;
> >  	}
> >  
> > -	if (flags & TST_FS_SKIP_FUSE) {
> > -		tst_res(TINFO, "Skipping FUSE as requested by the test");
> > +	if (tst_fs_in_skiplist("fuse", skiplist))
> >  		return 0;
> > -	}
> >  
> >  	tst_res(TINFO, "FUSE does support %s", fs_type);
> >  	return 1;
> >  }
> 
> I don't think that has_kernel_support() should look at the skiplist at
> all. The entire skiplist logic should be handled in
> tst_get_supported_fs_types(). But has_kernel_support() could return
> different (non-zero) values for native support and for FUSE support.

I do not agree, that would add more complexity to an internal function
that is not exported outside the library.

-- 
Cyril Hrubis
chrubis@suse.cz
