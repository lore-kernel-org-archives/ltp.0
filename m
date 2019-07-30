From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 30 Jul 2019 13:18:46 +0800
Subject: [LTP] [PATCH v2 1/2] m4: remove some useless m4
In-Reply-To: <20190729144227.GA8824@dell5510>
References: <1b8b7f73-fd31-58d2-5162-3648fa9729a5@163.com>
 <1563789167-2328-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190729122621.GB5872@dell5510> <20190729131619.GB27006@rei.lan>
 <20190729144227.GA8824@dell5510>
Message-ID: <5D3FD336.6080409@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> Hi,
>
>>>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>>> Acked-by: Petr Vorel<pvorel@suse.cz>
>>> Although I wonder whether mixing 4 changes (even related to autoconf)
>>> in single commit is a good idea (makes it a bit hard to review).
>> Yes please, at least the SPDX conversion has to be in a separate patch.
> +1
>
> BTW m4/ltp-signalfd.m4 would require cleanup as well.
Hi Cyril ,Petr

Sorry. This patch looks a little mess.

I will split it into five patches, as below:

v3-0001-m4-remove-useless-ltp-securebits.m4.patch
v3-0002-m4-remove-useless-ltp-time.m4.patch
v3-0003-m4-remove-useless-ltp-fs_ioc_flags.m4.patch
V3-0004-m4-remove-useless-ltp-cgroupstats.m4.patch
v3-0005-m4-clean-up-ltp-signalfd.m4.patch


Also, SPDX conversion for setxattr03.c, I will cleanup this case after this patchset merged.

Thanks
Yang Xu

> Kind regards,
> Petr
>
>
> .
>



