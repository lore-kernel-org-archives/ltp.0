From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 5 Dec 2016 19:17:24 +0100
Subject: [LTP] [PATCH v5 1/1] syscalls/mq_unlink: convert to use new
 test library API
In-Reply-To: <20161205161351.GL22344@rei.lan>
References: <20161205143258.8102-1-pvorel@suse.cz>
 <20161205144943.GI22344@rei.lan> <20161205161351.GL22344@rei.lan>
Message-ID: <20161205181724.tfp3bzb4z6is4deh@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

> The test will fail to unlink the queue at the end of the do_test() in
> this case. That is the reason the euid is reset to root back again as
> the first thing after we jump to EXIT: label.
Right :-). It's kept in v5.


Kind regards,
Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161205/c281c327/attachment.sig>
