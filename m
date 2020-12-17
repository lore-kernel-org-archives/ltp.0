From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 17 Dec 2020 14:50:04 +0530
Subject: [LTP] [PATCH] module.mk: Remove build-in.a files as well during
 make clean
In-Reply-To: <X9siWpm84NICafIt@yuki.lan>
References: <a7007a68b6a11f84f6551d253563da2f37319e55.1608179175.git.viresh.kumar@linaro.org>
 <X9siWpm84NICafIt@yuki.lan>
Message-ID: <20201217092004.yxj2woxzaffqo3vh@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17-12-20, 10:18, Cyril Hrubis wrote:
> Hi!
> > Remove build-in.a files as well during make clean and also add it to
> > .gitignore.
> 
> It's actually built-in.a not build-in.a.

I copied the name from your earlier email, didn't apply much brain
after that as it wasn't generating for me :)

-- 
viresh
