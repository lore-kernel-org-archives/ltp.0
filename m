From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Nov 2018 11:07:33 +0100
Subject: [LTP] [PATCH] [WIP] Add fanout01 CVE-2017-15649
In-Reply-To: <20180910122121.26752-1-rpalethorpe@suse.com>
References: <20180910122121.26752-1-rpalethorpe@suse.com>
Message-ID: <20181127100733.GA4792@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---

> +#include <errno.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/ioctl.h>
> +#include <net/if.h>
> +#include <linux/if_packet.h>

These headers can be omitted:
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/ioctl.h>


Kind regards,
Petr
