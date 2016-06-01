From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Jun 2016 11:27:57 +0200
Subject: [LTP] [PATCH 1/3] ltp-aiodio: report posix_memalign errors
 properly
In-Reply-To: <1464351304-31405-1-git-send-email-eguan@redhat.com>
References: <1464351304-31405-1-git-send-email-eguan@redhat.com>
Message-ID: <20160601092757.GA19762@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> From posix_memalign(3) the value of errno is indeterminate after a call
> to posix_memalign(). So TERRNO doesn't work in this case.
> dio_sparse    1  TBROK  :  dio_sparse.c:75: posix_memalign(): errno=SUCCESS(0): Success
> 
> Report posix_memalign() errors by calling strerror on the return value.
> dio_sparse    1  TBROK  :  dio_sparse.c:74: posix_memalign(): EINVAL

That is good catch but the *_sparse.c and dio_truncate.c does not use
the test library and hence the compilation fails on undeclared and
implicit declarations.

-- 
Cyril Hrubis
chrubis@suse.cz
