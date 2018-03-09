From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Mar 2018 14:18:17 +0100
Subject: [LTP] [PATCH v2 2/3] remove old tst_flush()
In-Reply-To: <20180309092701.8161-2-mmoese@suse.de>
References: <20180309092701.8161-1-mmoese@suse.de>
 <20180309092701.8161-2-mmoese@suse.de>
Message-ID: <20180309131817.GA5667@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The old tst_flush() was renamed to tst_old_flush(), and tst_flush()
> was removed from tstapicmd.c.
> The new tst_flush() has the same prototype as the old one, so any test
> using it should still be fine.

There are calls to tst_flush() in the lib/tst_res.c as well as in the
oldlib tests, these have to call the tst_old_flush().

Also this patch should be first in the series since ideally the git tree
should be compileable after each patch so that we do not break
bisections.

-- 
Cyril Hrubis
chrubis@suse.cz
