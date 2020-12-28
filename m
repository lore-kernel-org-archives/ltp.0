From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 Dec 2020 21:01:20 +0100
Subject: [LTP] [PATCH] af_alg07: Add linux-git reference to more general
 fix
In-Reply-To: <20201223113636.9617-1-rpalethorpe@suse.com>
References: <20201223113636.9617-1-rpalethorpe@suse.com>
Message-ID: <20201228200120.GA17392@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> While trying to reintroduce this error on kernel 5.10 I found that a
> secondary fix has been applied which fixes many more socket types and
> may obsolete the original fix. Ideally we would create a new test
> based on Eric's reproducer, but for now I will just include a
> reference to the second fix.
+1

Thanks, merged!

Kind regards,
Petr
