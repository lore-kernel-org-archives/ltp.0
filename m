From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Nov 2020 13:28:54 +0100
Subject: [LTP] [PATCH v3] tcp_cmds/ping/ping02: Make it compatible with
 Busybox
In-Reply-To: <20201109191618.4442-1-kory.maincent@bootlin.com>
References: <20201109191618.4442-1-kory.maincent@bootlin.com>
Message-ID: <20201110122854.GA30193@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory, Alexey,

> The ping from busybox does not have -f parameter, use -i parameter instead.
> BusyBox does not accept pattern longer than 2 bytes.

> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

> Changes since v1:
>  - Use "-i 0.01 -p aa" parameter instead of "-f"

> Changes since v2:
>  - Use "-i 0.01 -p aa" only in the case of "-f" parameter is not valid

Reviewed-by: Petr Vorel <pvorel@suse.cz>

-i option was added in busybox 1.30 (2 years old), it'd be good to note that in
the commit message.

I have in my TODO list C/shell API helper which would help to verify command
version.

Kind regards,
Petr
