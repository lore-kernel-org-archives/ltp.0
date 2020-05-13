From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 May 2020 15:04:09 +0200
Subject: [LTP] [PATCH v3] pty04: Retry reads when short and wait longer
In-Reply-To: <20200513123944.31411-1-rpalethorpe@suse.com>
References: <20200513123944.31411-1-rpalethorpe@suse.com>
Message-ID: <20200513130409.GA21234@dell5510>
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

> Also this increases the timeout to wait for the checkpoint to a large value
> because sometimes the kernel stalls, possibly while trying to (re)claim
> memory, and this causes the checkpoint wait to timeout and everything to be
> cleaned up. If the kernel is left in a stalled state, this can result in a
> stack trace which is more useful.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Cc: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Great fix, thanks!

Tested on various kernels (5.7.0-rc4, 5.6, 5.3, 4.12, 4.4, 3.16, 3.10, 2.6.32)
on various distros and it got stack only on 2.6.32.

Going to wait little longer for a feedback and then merge.

Kind regards,
Petr
