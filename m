From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Dec 2018 21:27:56 +0100
Subject: [LTP] [PATCH] mem/overcommit_memory.c: Fix "CommitLimit <
 Committed_AS" error in some situations
In-Reply-To: <1539938660-18786-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1539938660-18786-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20181203202755.GA8919@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> By default, system with overcommit_memory=2 will ensure "CommitLimit >=
> Committed_AS" when setting overcommit_ratio.  But we change overcommit_ratio
> to a random value forcely, so it's possible to decrease CommitLimit less
> than current Committed_AS when setting overcommit_ratio to a quite small
> value(e.g. 0).

> For example, there are 5G physical memory, 4G swap and 5G allocated memory
> (i.e. Committed_AS) on system, and then running overcommit_memory02(i.e.
> overcommit_memory -R 0) always triggers the "CommitLimit < Committed_AS"
> error:
> ----------------------------------------------------------------------
> mem.c:839: INFO: set overcommit_ratio to 0
> mem.c:839: INFO: set overcommit_memory to 2
> overcommit_memory.c:235: INFO: CommitLimit is 4194300, Committed_AS is 5405908
> overcommit_memory.c:237: BROK: Unexpected error: CommitLimit < Committed_AS
> ----------------------------------------------------------------------

> We try to skip test if setting a small value of overcommit_ratio results in
> "CommitLimit < Committed_AS".

> Fix: #215

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> ---
>  .../kernel/mem/tunable/overcommit_memory.c    | 30 ++++++++++++-------
>  1 file changed, 20 insertions(+), 10 deletions(-)


Kind regards,
Petr
