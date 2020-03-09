From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Mar 2020 09:09:31 +0100
Subject: [LTP] [PATCH v1 2/2] syscalls/settimeofday02: convert to new
 library
In-Reply-To: <1583311467-2379-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1583311467-2379-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1583311467-2379-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200309080931.GC299736@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

>  #define	VAL_SEC		100
>  #define	VAL_MSEC	100
These 2 definitions aren't needed any more.

Kind regards,
Petr
