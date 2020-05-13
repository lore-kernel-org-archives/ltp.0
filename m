From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 May 2020 12:42:22 -0400 (EDT)
Subject: [LTP] [PATCH v3] pty04: Retry reads when short and wait longer
In-Reply-To: <20200513123944.31411-1-rpalethorpe@suse.com>
References: <20200513123944.31411-1-rpalethorpe@suse.com>
Message-ID: <1294007425.12313251.1589388142490.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Even though reads are blocking and packets are flipped into the netdevice
> buffer whole, it seems read may return before a full packet is read into user
> land. Retrying read should prevent timeouts and read failures on some
> machines.
> 
> Also this increases the timeout to wait for the checkpoint to a large value
> because sometimes the kernel stalls, possibly while trying to (re)claim
> memory, and this causes the checkpoint wait to timeout and everything to be
> cleaned up. If the kernel is left in a stalled state, this can result in a
> stack trace which is more useful.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Cc: Petr Vorel <pvorel@suse.cz>
> ---
> 
> V3:
> * Increase the timeout on the wait for the reason described above
> * Add some more info to read and write results

Looks good to me as well, ack.

