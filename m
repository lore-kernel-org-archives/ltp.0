From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 24 Jul 2020 15:48:07 +0530
Subject: [LTP] [PATCH V3] syscalls/timer_settime01: Make sure the timer
 fires
In-Reply-To: <f9289166-5698-e2ec-ecc8-531fbcbd60c5@cn.fujitsu.com>
References: <ede8d1c6a1ad1b23d8dca2297c740c301b329e37.1593743927.git.viresh.kumar@linaro.org>
 <47e40724c2a7a9612aca0265e493e62c69d65996.1594204153.git.viresh.kumar@linaro.org>
 <20200714142843.GA14905@yuki.lan>
 <d008820f-22d2-078d-3a62-f1fa20e6750b@cn.fujitsu.com>
 <20200724033732.gwzu2zdhdziwtbtz@vireshk-mac-ubuntu>
 <f9289166-5698-e2ec-ecc8-531fbcbd60c5@cn.fujitsu.com>
Message-ID: <20200724101807.dtf46ydpegj3w43d@vireshk-mac-ubuntu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24-07-20, 13:07, Yang Xu wrote:
> Yes, only _ALARM fails.

Right. So this seems this is rather a kernel issue. And I am not
really sure how to handle these.

Cyril, Any ideas ? Do we even try to support 3.10 here ?

-- 
viresh
