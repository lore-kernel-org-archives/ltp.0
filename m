From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 10 Jun 2020 09:28:47 +0800
Subject: [LTP] [PATCH v2] LIB: Use INTERNAL_LIB for ltp lib
In-Reply-To: <57a1c19e-d8e5-4389-8565-20e49f144657@G08CNEXMBPEKD05.g08.fujitsu.local>
References: <57a1c19e-d8e5-4389-8565-20e49f144657@G08CNEXMBPEKD05.g08.fujitsu.local>
Message-ID: <78176e41-03c4-e75b-594b-20731b2d4dfd@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

Nothing blocks this simple patch, I guess we can directly push this 
patch(don't forget jan's acked-by).

Best Regards
Yang Xu
> Hi petr
> just reply for your ?Given Jan acked v1, I'd be also for merge?? v2 is OK.
> 
> Best Regards
> Yang Xu
> 
> 
> ---Original---
> *From:* "Petr Vorel"<pvorel@suse.cz>
> *Date:* Mon, Jun 8, 2020 19:41 PM
> *To:* "Yang Xu"<xuyang2018.jy@cn.fujitsu.com>;
> *Cc:* "ltp"<ltp@lists.linux.it>;
> *Subject:* Re: [LTP] [PATCH v2] LIB: Use INTERNAL_LIB for ltp lib
> 
> Hi?Xu,
> 
>  >?>?Cyril?concerned?3rd?party?use?of?lib/libltp.a,?but?nobody?complained.
>  >?>?Given?Jan?acked?v1,?I'd?be?also?for?merge.
> 
>  >??We?also?should?include?android_libpthread?and?android_librt?Makefile.
> Not?sure?what?you?mean.?You?did?the?change?in?android_libpthread?and
> android_librt?Makefile?(this?is?v2?thread),?thus?I?consider?this?patch?ready.
> Or?am?I?missing?something?
> 
> Kind?regards,
> Petr
> 
> -- 
> Mailing?list?info:?https://lists.linux.it/listinfo/ltp


