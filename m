From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Oct 2018 09:46:23 +0200
Subject: [LTP] [PATCH v2 2/5] tst_safe_macros: add SAFE_GETGRGID()
In-Reply-To: <43441f97-3b86-e646-2693-4f396fa40ff6@suse.de>
References: <20180910141901.20541-1-cfamullaconrad@suse.de>
 <20180910141901.20541-2-cfamullaconrad@suse.de>
 <20181002142047.GK24796@rei>
 <43441f97-3b86-e646-2693-4f396fa40ff6@suse.de>
Message-ID: <20181003074623.GC23398@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +	rval = getgrgid(gid);
> >> +	if (rval == NULL) {
> >> +		tst_brk_(file, lineno, TBROK | TERRNO,
> >> +			"getgrgid(%li) failed", (long)gid);
> >> +	}
> > 
> > I also wonder if it's okay to break the test in case that the entry
> > wasn't found (the return value would be NULL and errno would be
> > untouched) but I guess that it's OK for most of the cases.
> 
> I think so too. Also I thought these safe_* functions are more for
> setting up the test, where it is more likely requesting existing groups.
> 
> Maybe for the fallback approach it could be handy. But if we really need
> more then two options, I think passing a array would do it.
> Or should we go with an array now?

Unless there is a case for it I woudln't bother at this point.

-- 
Cyril Hrubis
chrubis@suse.cz
