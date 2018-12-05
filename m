From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 Dec 2018 21:50:54 +0100
Subject: [LTP] [PATCH] cve/stack_clash: inhibit test-breaking
 optimizations
In-Reply-To: <20181204182353.86453-1-ghackmann@google.com>
References: <20181204182353.86453-1-ghackmann@google.com>
Message-ID: <20181205205054.GB21236@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Greg,

> stack_clash relies on the compiler doing fairly specific things with the
> stack pointer.  We've run into a couple of places where clang optimized
> away the intended behavior:
...

> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> ---
>  testcases/cve/Makefile      | 2 ++
>  testcases/cve/stack_clash.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Thanks for your patch, pushed.


Kind regards,
Petr
