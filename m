From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 9 Mar 2020 16:10:48 +0800
Subject: [LTP] [PATCH v1 2/2] syscalls/settimeofday02: convert to new
 library
In-Reply-To: <20200309080931.GC299736@x230>
References: <1583311467-2379-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1583311467-2379-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200309080931.GC299736@x230>
Message-ID: <eec6ee99-d7d0-5386-cfde-58760046898b@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr


> Hi Xu,
> 
>>   #define	VAL_SEC		100
>>   #define	VAL_MSEC	100
> These 2 definitions aren't needed any more.
Yes. I forgot to delete...

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
> 


