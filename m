From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Nov 2016 12:13:30 +0100
Subject: [LTP] [PATCH v2 1/1] syscalls/mq_notify01: cleanup
In-Reply-To: <20161124111116.24258-1-pvorel@suse.cz>
References: <20161124111116.24258-1-pvorel@suse.cz>
Message-ID: <20161124111330.cf5qdxvkdtglofc7@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * deadlock prevention: copy the siginfo_t structure into an global variable and
> examine/print it in the main thread.
> * variables changed in signal handlers are defined volatile
> * removed redundant opt_debug (+ setup function)
> * not using tmpdir
> * formating cleanup

Grr, some cleanup forgotten, please ignore this version.

Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161124/e4db5a1c/attachment.sig>
