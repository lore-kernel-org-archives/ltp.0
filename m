From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Jun 2020 22:37:56 +0200
Subject: [LTP] [PATCH] clocks/invaliddates.c: relax acceptable delta
In-Reply-To: <53a3e9975f00c50c78528994472ec7e9f8adeb90.1592475774.git.jstancek@redhat.com>
References: <53a3e9975f00c50c78528994472ec7e9f8adeb90.1592475774.git.jstancek@redhat.com>
Message-ID: <20200618203756.GC175579@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> Test allows just 5ms delta for PASS, and test randomly fails in
> environments with shared resources and increased steal time.
Good.

> Relax the condition and also print deltas if test fails.
> Remove DEBUG ifdefs and main parameters to avoid unused variable
> warning.
Also thanks for cleanup.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
