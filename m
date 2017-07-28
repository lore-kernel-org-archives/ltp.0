From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 28 Jul 2017 11:59:51 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/epoll_wait01: cleanup data
 structure usage
In-Reply-To: <20170727190647.116088-2-smuckle.linux@gmail.com>
References: <20170727190647.116088-1-smuckle.linux@gmail.com>
 <20170727190647.116088-2-smuckle.linux@gmail.com>
Message-ID: <20170728095951.GA27508@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  		if (TEST_RETURN <= 0) {
>  			tst_resm(TFAIL | TTERRNO, "epoll_wait() returned %i",
                                                                          ^
							The TEST_RETURN
							is long hence
							this has to be
							%li

I've ammended this changed to this patch and pushed both, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
