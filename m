From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Dec 2018 13:42:59 +0100
Subject: [LTP] [PATCH v4] syscalls/statx: Add test for sync flags
In-Reply-To: <20181207155220.GA14562@dell5510>
References: <1544172141-1676-1-git-send-email-vaishnavi.d@zilogic.com>
 <20181207155220.GA14562@dell5510>
Message-ID: <20181210124259.GC9930@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +#include "old_tmpdir.h"
> I think, we don't want to use old_*.h headers (although library itself
> lib/tst_test.c uses it). IMHO previous version with getcwd() was better.

My bad it does not seem to be exported to the new library, I thought it
was. I will fix the headers so that it's exported and remove this
include before applying this patch.

-- 
Cyril Hrubis
chrubis@suse.cz
