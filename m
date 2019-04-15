From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 15 Apr 2019 14:06:37 +0200
Subject: [LTP] [PATCH 1/1] tst_test.h: Include common headers to fix
 missing function declaration
In-Reply-To: <20190415113907.GA9404@rei>
References: <20190414130329.14607-1-pvorel@suse.cz> <20190415113907.GA9404@rei>
Message-ID: <20190415120637.GA11779@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> >  #include <unistd.h>
> >  #include <limits.h>
> > +#include <string.h>
> > +#include <strings.h>
> > +#include <stdlib.h>

> Can we please get rid of the deprecated functions from strings.h instead
> of simply including it?
Sure, I'll do it sooner or later :). I guess you're against <stdlib.h> as well
(I found only one file needing it so far), so I'll include just <string.h>
(which usage is massive), ok?

Kind regards,
Petr
