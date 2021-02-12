From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Feb 2021 19:59:33 +0100
Subject: [LTP] [PATCH 1/2] lib: Add function to detect FIPS mode
In-Reply-To: <YCamFRCWW6a4zgLv@yuki.lan>
References: <20210202130441.17861-1-pvorel@suse.cz> <YCamFRCWW6a4zgLv@yuki.lan>
Message-ID: <YCbQFWEUUpU3IIY/@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Hi!
> > +#ifndef TST_FIPS_H__
> > +#define TST_FIPS_H__
> > +
> > +#define PATH_FIPS	"/proc/sys/crypto/fips_enabled"

> I'm not sure that this belongs to the header, at least it's not prefixed
> with TST_.
Good catch. As it's not needed I'll move it to C source, because it's not needed
for other tests so far.

BTW the same problem is with PATH_LOCKDOWN from tst_lockdown.[ch].
It'd be better to move them to tst_lockdown.c as well.

> Other than that Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Thanks!

Kind regards,
Petr
