From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 May 2020 15:37:46 +0200
Subject: [LTP] [PATCH v4 1/2] pty04: Use guarded buffers for transmission
In-Reply-To: <20200505101625.25020-1-rpalethorpe@suse.com>
References: <20200505101625.25020-1-rpalethorpe@suse.com>
Message-ID: <20200505133746.GB21884@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---

Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW Every second run with this patch it blocks after pty04.c:214: PASS: Read netdev 1
and then:
tst_checkpoint.c:147: BROK: pty04.c:249: tst_checkpoint_wait(0, 10000): ETIMEDOUT (110)
tst_test.c:373: BROK: Reported by child (26650)
safe_macros.c:258: BROK: pty04.c:215: read(5,0x7efebc306001,8191) failed, returned -1: ENETDOWN (100)
pty04.c:139: PASS: Writing to PTY interrupted by hangup
tst_test.c:373: WARN: Reported by child (26648)

Tested on 5.7.0-rc3 in Tumbleweed.
But it looks this is not caused by this change, but was here before, because the
same behavior I see when testing pty04 *without* this patch on various kernels
(5.3.7, 5.6.0-rc5) and some of the never SLES (4.12 based).

Kind regards,
Petr
