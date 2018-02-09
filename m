From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Feb 2018 16:51:12 +0100
Subject: [LTP] [COMMITTED 1/1] Replace __BEGIN_DECLS and __END_DECLS to
 with expanded macros
In-Reply-To: <20180209140553.17453-1-pvorel@suse.cz>
References: <20180209140553.17453-1-pvorel@suse.cz>
Message-ID: <20180209155112.GA17594@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  testcases/kernel/syscalls/epoll2/include/epoll.h |    8 +-
>  utils/ffsb-6.0-rc2/config.h.in                   |   49 +-
>  utils/ffsb-6.0-rc2/configure                     | 5937 ++++++++++------------
      ^
      This does not look like intended change, can you please revert the
      patch and apply clean version?

(Have you used git commit -a by mistake?)

-- 
Cyril Hrubis
chrubis@suse.cz
