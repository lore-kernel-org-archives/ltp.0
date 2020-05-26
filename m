From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 May 2020 04:58:31 -0400 (EDT)
Subject: [LTP] [PATCH] lib: use TCONF if hpage reserve failed in retry
In-Reply-To: <20200526070901.12957-1-liwang@redhat.com>
References: <20200526070901.12957-1-liwang@redhat.com>
Message-ID: <2000957070.13598874.1590483511876.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Test still easy to get fail in?hpages?reserving (only 80% of
> max_hpages) because of memory fragmentation.
>  ?
>   tst_hugepage.c:46: BROK: nr_hugepages = 171, but expect 255
> ? ?
> But it seems unkind and useless to exit with TBROK when failed
> in hpage reserve retrying. This patch proposes to use TCONF for
> better log review.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Jan Stancek <jstancek@redhat.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

