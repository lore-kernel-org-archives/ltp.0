From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 Dec 2018 21:33:21 +0100
Subject: [LTP] [PATCH v2] getrlimit/getrlimit03: add configure-time
 check for struct ulimit64
In-Reply-To: <20181205181913.214565-1-ghackmann@google.com>
References: <20181205181913.214565-1-ghackmann@google.com>
Message-ID: <20181205203321.GA21236@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Greg,

> The kernel's UAPI headers export a definition of struct ulimit64 which
> can conflict with the open-coded one in getrlimit03.  Depending on the
> libc implementation, this may only be visible when _LARGEFILE64_SOURCE
> is defined.  Fix this by moving getrlimit03's definition behind a
> configure-time check.

Thanks for your patch, pushed.


Kind regards,
Petr
