From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Aug 2020 14:53:12 +0200
Subject: [LTP] [PATCH v2 1/1] tst_kvcmp: Strip double quotes when
 parsing /etc/os-release
In-Reply-To: <20200820124959.GB5065@dell5510>
References: <20200820120051.331-1-pvorel@suse.cz>
 <20200820122538.GC9000@yuki.lan> <20200820124959.GB5065@dell5510>
Message-ID: <20200820125312.GD9000@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
> > > index 185a5c39c..dfd81ac83 100644
> > > --- a/lib/tst_kvercmp.c
> > > +++ b/lib/tst_kvercmp.c
> > > @@ -148,6 +148,12 @@ const char *tst_kvcmp_distname(const char *kver)
> > >  	if (access(OSRELEASE_PATH, F_OK) != -1) {
> > >  		SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
> 
> > > +		if (p[0] == '"')
> > > +			memmove(p, p + 1, strlen(p));
> 
> > Why can't we just do distname++ and move the p = distname after this
> > condition?
> OK, distname is char[], not a pointer, I guess I have to use memmove().

In that case you just need to do char *ret = distname + 1; p = ret; ....
return ret;

-- 
Cyril Hrubis
chrubis@suse.cz
