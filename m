From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 23 Sep 2020 06:02:26 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/recvmmsg01.c: Fix a compiler error
In-Reply-To: <20200923084422.13101-1-yangx.jy@cn.fujitsu.com>
References: <20200923084422.13101-1-yangx.jy@cn.fujitsu.com>
Message-ID: <938084292.15015367.1600855346871.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Use correct ts.type to fix the following compiler error:
> --------------------------------------------
> recvmmsg01.c:86:9: error: request for member ?type? in something not a
> structure or union
>   timeout.type = tv->ts_type;
> --------------------------------------------
> 
> Fixes: 135af8ededd4 ("syscalls/{send|recv}mmsg: add a test case for timeout
> and errno test")
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

