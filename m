From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Mar 2019 10:38:38 +0100
Subject: [LTP] [PATCH 1/6] lib: add tst_af_alg lib
In-Reply-To: <20190221053026.18489-2-ebiggers@kernel.org>
References: <20190221053026.18489-1-ebiggers@kernel.org>
 <20190221053026.18489-2-ebiggers@kernel.org>
Message-ID: <20190315093838.GB4990@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Eric,

> From: Eric Biggers <ebiggers@google.com>

> Add helper functions for creating and using AF_ALG sockets.  AF_ALG is
> the userspace interface to algorithms in the Linux kernel's crypto API.
> See https://www.kernel.org/doc/html/latest/crypto/userspace-if.html for
> more information about this interface.

AF_ALG is not defined in old distros [1]:
/usr/src/ltp/lib/tst_af_alg.c: In function 'tst_alg_create':
/usr/src/ltp/lib/tst_af_alg.c:15: error: 'AF_ALG' undeclared (first use in this function)

We should add it (not sure whether to new lapi/if_alg.h or to lapi/socket.h).

Kind regards,
Petr

[1] https://api.travis-ci.org/v3/job/506663263/log.txt
