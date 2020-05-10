From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 10 May 2020 10:21:51 +0200
Subject: [LTP] [PATCH] nm01: fix regex matching internal symbols
In-Reply-To: <797dd5eeadd81fae30635dd66d0a715cc213c51e.1588942651.git.jstancek@redhat.com>
References: <797dd5eeadd81fae30635dd66d0a715cc213c51e.1588942651.git.jstancek@redhat.com>
Message-ID: <20200510082151.GA13961@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Current regex matches any word character followed by space
> and one of letters "abdft". So it doesn't match only symbol type,
> but can match for example value and size:
>   $ grep "\w [a,b,d,f,t]" nm.out
>   __libc_csu_init T 10000640 b4
>                    matches ^ ^

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Good catch, Jan.

Kind regards,
Petr
