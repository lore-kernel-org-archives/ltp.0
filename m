From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Dec 2016 15:42:49 +0100
Subject: [LTP] [PATCH 1/2] syscalls/mq_timedsend: convert to new API
In-Reply-To: <20161214221713.4460-1-pvorel@suse.cz>
References: <20161214221713.4460-1-pvorel@suse.cz>
Message-ID: <20161215144249.ccotszsqja5o2rae@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>  .../kernel/syscalls/mq_timedsend/mq_timedsend01.c  | 649 ++++++++-------------

It's a crap, sorry. Both mq_timedsend and mq_timedreceive need to be improved, in similar
way as mq_open.

Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161215/8f2af4fe/attachment.sig>
