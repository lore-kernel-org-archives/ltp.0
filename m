From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 Jun 2019 15:54:36 +0200
Subject: [LTP] [PATCH v2 3/4] syscalls/pidfd_send_signal02
In-Reply-To: <20190604114702.28255-2-camann@suse.com>
References: <20190604114702.28255-1-camann@suse.com>
 <20190604114702.28255-2-camann@suse.com>
Message-ID: <20190612135436.GA15090@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

> Add test to check basic error handling of the syscall.

> Signed-off-by: Christian Amann <camann@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +#define _GNU_SOURCE
Again, if not needed, remove it.

> +
> +#include <signal.h>
> +#include "pwd.h"
#include <pwd.h">

The rest LGTM.

Kind regards,
Petr
