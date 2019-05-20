From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 May 2019 17:34:11 +0200
Subject: [LTP] [PATCH 2/2] tst_net_vars.c: Enlarge buffer to fix format
 overflow warnings
In-Reply-To: <20190509164125.619-2-pvorel@suse.cz>
References: <20190509164125.619-1-pvorel@suse.cz>
 <20190509164125.619-2-pvorel@suse.cz>
Message-ID: <20190520153411.GA14132@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

> tst_net_vars.c:230:18: warning: ‘.0.0’ directive writing 4 bytes into a region of size between 1 and 128 [-Wformat-overflow=]
>   sprintf(buf, "%s.0.0", net_unused);
>                   ^~~~
> In file included from /usr/include/stdio.h:867,
>                  from tst_net_vars.c:26:
> /usr/include/bits/stdio2.h:36:10: note: ‘__builtin___sprintf_chk’ output between 5 and 132 bytes into a destination of size 128

> tst_net_vars.c:294:18: warning: ‘::’ directive writing 2 bytes into a region of size between 1 and 128 [-Wformat-overflow=]
>   sprintf(buf, "%s::", net_unused);
>                   ^~
> In file included from /usr/include/stdio.h:867,
>                  from tst_net_vars.c:26:
> /usr/include/bits/stdio2.h:36:10: note: ‘__builtin___sprintf_chk’ output between 3 and 130 bytes into a destination of size 128

> Fixes: d18e135d0 ("network: Add tools for setup IP related environment
> variables")

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net_vars.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Both commits pushed.

Kind regards,
Petr
