From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 May 2020 17:49:35 +0200
Subject: [LTP] [PATCH 2/2] pty04: Retry reads when short
In-Reply-To: <20200512142824.13063-2-rpalethorpe@suse.com>
References: <20200512142824.13063-1-rpalethorpe@suse.com>
 <20200512142824.13063-2-rpalethorpe@suse.com>
Message-ID: <20200512154935.GA24478@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> Even though reads are blocking and packets are flipped into the netdevice
> buffer whole, it seems read may return before a full packet is read into user
> land. Retrying read should prevent timeouts and read failures on some
> machines.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Cc: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for taking care of this.
It's still possible to reproduce timeout just with higher -i (-i10),
but it's an improvement.

Kind regards,
Petr
