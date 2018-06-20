From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Jun 2018 14:26:23 +0200
Subject: [LTP] [PATCH 1/3] lib: Add SAFE_CHROOT(path) macro
In-Reply-To: <20180620100447.GB21435@rei>
References: <20180620075917.21056-1-pvorel@suse.cz>
 <20180620100447.GB21435@rei>
Message-ID: <20180620122623.n2jabbawrgdyivri@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > +++ b/include/safe_macros_fn.h
> > @@ -30,6 +30,9 @@ char* safe_basename(const char *file, const int lineno,
> >  int safe_chdir(const char *file, const int lineno,
> >                 void (*cleanup_fn)(void), const char *path);

> > +int safe_chroot(const char *file, const int lineno,
> > +               void (*cleanup_fn)(void), const char *path);

> Can we pretty please avoid adding the function prototypes with the
> unused cleanup pointer?

> The safe_macros_fn.h file exists only for a historical reasons, new safe
> macros should be added to the tst_safe_macros.h file only, both macro
> and function prototype should go there.

Sure. I'm sorry, for not carefully checking my patches.
I created this part long time ago and I this is exactly what I fixed in Jinhui
Huang's SAFE_GETGRNAM patchset.


Kind regards,
Petr
