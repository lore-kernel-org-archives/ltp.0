From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Aug 2021 17:35:55 +0200
Subject: [LTP] [PATCH 4/4 v2] epoll_create: Add test for epoll_create02
In-Reply-To: <OSZP286MB0871452D0FEE65A20447AAB1CCC69@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
References: <20210825153932.138396-1-ziyaoxie@outlook.com>
 <OSZP286MB0871452D0FEE65A20447AAB1CCC69@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <YSe021+kRN7NqlnA@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * Verify that epoll_create returns -1 and set errno to EINVAL if size is not
> + * positive.

I've changed the 'positive' here to 'greater than zero' to make it
clearer.

And pushed the two test for epoll_create, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
