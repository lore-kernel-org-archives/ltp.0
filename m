From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 24 Jul 2020 18:27:03 +0800
Subject: [LTP] [PATCH V3] syscalls/timer_settime01: Make sure the timer
 fires
In-Reply-To: <20200724101807.dtf46ydpegj3w43d@vireshk-mac-ubuntu>
References: <ede8d1c6a1ad1b23d8dca2297c740c301b329e37.1593743927.git.viresh.kumar@linaro.org>
 <47e40724c2a7a9612aca0265e493e62c69d65996.1594204153.git.viresh.kumar@linaro.org>
 <20200714142843.GA14905@yuki.lan>
 <d008820f-22d2-078d-3a62-f1fa20e6750b@cn.fujitsu.com>
 <20200724033732.gwzu2zdhdziwtbtz@vireshk-mac-ubuntu>
 <f9289166-5698-e2ec-ecc8-531fbcbd60c5@cn.fujitsu.com>
 <20200724101807.dtf46ydpegj3w43d@vireshk-mac-ubuntu>
Message-ID: <480f566f-0354-16ef-4ffb-855a2e367cf0@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh


> On 24-07-20, 13:07, Yang Xu wrote:
>> Yes, only _ALARM fails.
> 
> Right. So this seems this is rather a kernel issue. And I am not
> really sure how to handle these.
> 
> Cyril, Any ideas ? Do we even try to support 3.10 here ?

ltp supports kernel 3.10. minimal supported kernel and (g)libc version 
discussion is here[1].  I don't know this is a backport bug or a 
upstream kernel bug(has fixed). I will figure out this on next week.

[1]https://github.com/linux-test-project/ltp/issues/657
> 


