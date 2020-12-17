From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Dec 2020 10:18:18 +0100
Subject: [LTP] [PATCH] module.mk: Remove build-in.a files as well during
 make clean
In-Reply-To: <a7007a68b6a11f84f6551d253563da2f37319e55.1608179175.git.viresh.kumar@linaro.org>
References: <a7007a68b6a11f84f6551d253563da2f37319e55.1608179175.git.viresh.kumar@linaro.org>
Message-ID: <X9siWpm84NICafIt@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Remove build-in.a files as well during make clean and also add it to
> .gitignore.

It's actually built-in.a not build-in.a. Anyways I've fixed that and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
