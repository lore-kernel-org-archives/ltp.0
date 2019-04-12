From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Apr 2019 11:46:46 +0200
Subject: [LTP] [RFC PATCH 2/3] Add more missing <string.h> and
 <strings.h> includes
In-Reply-To: <20190412094518.GC28648@haruka.lan>
References: <20190411233115.32744-1-pvorel@suse.cz>
 <20190411233115.32744-3-pvorel@suse.cz>
 <b9e58aac-eb0f-965a-c411-ef44c6a3ef27@xiaopeng.com>
 <20190412084932.GA28648@haruka.lan> <20190412084853.GB19937@x230>
 <806382ed-953c-f5f4-4629-15c5093b240f@xiaopeng.com>
 <20190412094518.GC28648@haruka.lan>
Message-ID: <20190412094646.GA5629@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Zhengwang,

> > > Agree, that'd be the easiest way :). NOTE: not sure what requires that, but
> > > sometimes is <strings.h> needed as well.

> > As I know, calls likes str*, mem*, such as, strncpy, memset, requires 
> > <string.h>,?? but bzero requires <strings.h>. Fortunately <strings.h> are 
> > not used as often as <string.h>. See my another review thread. :-)

> bzero() has been deprecated for quite some time, ideally we should
> replace it with memset().

That explains, why <strings.h> is not much used nowadays.


Kind regards,
Petr
