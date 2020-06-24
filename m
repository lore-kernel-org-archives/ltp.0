From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 24 Jun 2020 08:33:41 -0400 (EDT)
Subject: [LTP] [PATCH 2/2] Add test for CVE 2017-1000405
In-Reply-To: <20200619162922.20465-2-mdoucha@suse.cz>
References: <20200619162922.20465-1-mdoucha@suse.cz>
 <20200619162922.20465-2-mdoucha@suse.cz>
Message-ID: <2069023850.18523445.1593002021924.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> +
> +#include <sys/mman.h>
> +
> +#include "tst_test.h"
> +#include "tst_fuzzy_sync.h"

We should also include lapi/mmap.h, and check MADV_HUGEPAGE support
at runtime, since older distros might not have it.

Other than that, it looks good to me.

