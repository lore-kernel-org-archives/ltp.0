From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 May 2020 13:38:17 +0200
Subject: [LTP] [PATCH v4 1/2] pty04: Use guarded buffers for transmission
In-Reply-To: <1352538726.11479675.1588763647954.JavaMail.zimbra@redhat.com>
References: <20200505101625.25020-1-rpalethorpe@suse.com>
 <20200505133746.GB21884@dell5510>
 <87d07isaka.fsf@our.domain.is.not.set>
 <877dxpsb4n.fsf@our.domain.is.not.set>
 <1106041841.11477901.1588762195733.JavaMail.zimbra@redhat.com>
 <CAEemH2coDuWHPt8SMosAtpjNd4VxmkGw3FWWajUOYXaNN7o0og@mail.gmail.com>
 <1352538726.11479675.1588763647954.JavaMail.zimbra@redhat.com>
Message-ID: <20200506113817.GA5409@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> > > > Probably the best thing todo for now is to remove the test before the
> > > > release as this requires some more investigation.

> > > We can keep it in tree, I'd just disable it in runtest file(s), so it's not
> > > run by default.


> > But we still facing the compiled errors in the old kernels, that will break
> > the LTP build in the compiling phase.

> I see, that will fail on anything older than 4.10. I don't have strong
> preference how to deal with that, just want to avoid running pty04 for now.

> diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
> index eaf172504a64..55923a0af006 100644
> --- a/testcases/kernel/pty/pty04.c
> +++ b/testcases/kernel/pty/pty04.c
> @@ -38,7 +38,10 @@
>  #include "tst_buffers.h"
>  #include "config.h"

> -#if defined(HAVE_LINUX_IF_PACKET_H) && defined(HAVE_LINUX_IF_ETHER_H)
> +#include <linux/version.h>
Shouldn't we also check for <linux/version.h> with autotools? Or are kernel
headers mandatory for LTP build?

> +
> +#if defined(HAVE_LINUX_IF_PACKET_H) && defined(HAVE_LINUX_IF_ETHER_H) \
> +       && LINUX_VERSION_CODE >= KERNEL_VERSION(4, 10, 0)

>  #include <linux/if_packet.h>
>  #include <linux/if_ether.h>
> @@ -373,6 +376,6 @@ static struct tst_test test = {

>  #else

> -TST_TEST_TCONF("Need <linux/if_packet.h> and <linux/if_ether.h>");
> +TST_TEST_TCONF("Need <linux/if_packet.h> and <linux/if_ether.h> and 4.10+");

+1.

BTW, why this tests requires 4.10 for runtime?


Kind regards,
Petr
