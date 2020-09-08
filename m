From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 8 Sep 2020 13:17:28 +0530
Subject: [LTP] [PATCH 2/3] syscalls: select: Rename select04.c to
 select02.c
In-Reply-To: <a68a049a-c362-ae0e-3cc8-19cac4cfd741@cn.fujitsu.com>
References: <728ce5d6b7e0f3eba8015c078bfc23ec144ce1c2.1599115178.git.viresh.kumar@linaro.org>
 <f7855857470b26fdbebcfe4adf1cd4779852f7ff.1599115178.git.viresh.kumar@linaro.org>
 <a68a049a-c362-ae0e-3cc8-19cac4cfd741@cn.fujitsu.com>
Message-ID: <20200908074728.imbxcswztx3h5ssd@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08-09-20, 15:39, Yang Xu wrote:
> Hi Viresh
> 
> IMO, we don't need to rename select04 to select02. The later new case can
> use select02 name. It makes select history more clean.

Why keeping such history is important ? I think it will look rather
confusing why we have files named as 01 and then 04.

Anyway, I will keep the patch in the series and will leave it for
Cyril to decide if he wants to pick the patch or not.

Thanks Yang.

-- 
viresh
