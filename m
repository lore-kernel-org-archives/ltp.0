From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 2 Dec 2019 04:29:36 +0100
Subject: [LTP] [PATCH] Unshare KSM pages before setting max_page_sharing
In-Reply-To: <20191128163147.4377-1-mdoucha@suse.cz>
References: <20191128163147.4377-1-mdoucha@suse.cz>
Message-ID: <20191202032936.GA32335@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Setting max_page_sharing is possible only when there are no KSM shared pages
> in the system. Otherwise writing to max_page_sharing SysFS file will fail
> with EBUSY.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Good catch!

BTW at least ksm01 will fail on VM host with running VMs,
but that's another story not related to this patch.

mem.c:251: FAIL: pages_shared is not 1 but 3629.
mem.c:251: FAIL: pages_sharing is not 98302 but 113789.
mem.c:251: FAIL: pages_volatile is not 0 but 12.
mem.c:251: FAIL: pages_unshared is not 1 but 48519.

Kind regards,
Petr
