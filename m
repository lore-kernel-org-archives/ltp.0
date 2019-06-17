From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Jun 2019 14:21:55 +0200
Subject: [LTP] [PATCH] net/tst_net_vars: Fix IPv4 network computing on
 big endianness
In-Reply-To: <20190614122716.2383-1-pvorel@suse.cz>
References: <20190614122716.2383-1-pvorel@suse.cz>
Message-ID: <20190617122155.GA8603@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> by converting IP to network byte order and adjust printing.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net_vars.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Merged.

Kind regards,
Petr
