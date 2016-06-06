From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Jun 2016 15:22:16 +0200
Subject: [LTP] [PATCH] tst_test.h: include tst_kvercmp.h
In-Reply-To: <1464956996-26578-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1464956996-26578-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160606132216.GB21264@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> tst_kvercmp.h is included in test.h, but is not included in tst_test.h.
> Fixed it.

We should remove the include from lib/tst_test.c in this patch as well.

Other than that acked.

-- 
Cyril Hrubis
chrubis@suse.cz
