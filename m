From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 8 Jul 2021 19:38:36 +0800
Subject: [LTP] [PATCH] gethostid: Rewrite with newlib and use/test
 sethostid
In-Reply-To: <CAEemH2cTBd45n9F5Db+Xc3ZE0R8GyLVa1AVsgbEPYFB+2hVV5Q@mail.gmail.com>
References: <20210708080720.18997-1-xieziyao@huawei.com>
 <CAEemH2cTBd45n9F5Db+Xc3ZE0R8GyLVa1AVsgbEPYFB+2hVV5Q@mail.gmail.com>
Message-ID: <16e18b1d-93c7-9885-9485-c2d08c17c02d@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> I made some refine and pushed, thanks!
Thanks for your review. Besides, I noticed the CI fails to be compiled 
on Apine. The difference appears to be caused by the underlying libc 
implementation: glibc and Alpine's musl-libc.

Is there anything that needs to be modified for this patch? Or simply 
ignore it in the CI script.

> 
> -- 
> Regards,
> Li Wang

Kind Regards,
Ziyao
