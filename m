From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Nov 2020 13:36:16 +0100
Subject: [LTP] [PATCH v3] tcp_cmds/ping/ping02: Make it compatible with
 Busybox
In-Reply-To: <20201110122854.GA30193@pevik>
References: <20201109191618.4442-1-kory.maincent@bootlin.com>
 <20201110122854.GA30193@pevik>
Message-ID: <20201110123616.GA31347@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory, Alexey,

> -i option was added in busybox 1.30 (2 years old), it'd be good to note that in
> the commit message.
Actually, maybe also test -i option and if even -i not working run?

tst_brk TCONF "unsupported ping version (old busybox?)"

Kind regards,
Petr
