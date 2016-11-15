From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Nov 2016 10:59:43 +0100
Subject: [LTP] [PATCH 1/1] syscalls/clock_getres01: convert to use new
 test library API
In-Reply-To: <20161115095307.27985-1-pvorel@suse.cz>
References: <20161115095307.27985-1-pvorel@suse.cz>
Message-ID: <20161115095943.gi2iznk7x7su3r3n@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi there,

> -static void setup(void)
> -{
> -	TEST_PAUSE;

I suppose TEST_PAUSE is somehow deprecated as it's in include/old/usctest.h.

Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161115/004e1e0b/attachment.sig>
