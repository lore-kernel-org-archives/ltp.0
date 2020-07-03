From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Jul 2020 15:58:12 +0200
Subject: [LTP] [PATCH V7 09/19] syscalls/sigwaitinfo: Migrate to new
 test framework
In-Reply-To: <18d8603306f51f243faca04cf63bcaf2c7168d56.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <18d8603306f51f243faca04cf63bcaf2c7168d56.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200703135812.GC2308@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Honestly I'm not sure what we should do about this test. Obviously this
is a step into right direction but it still keeps the SUCCEED_OR_DIE()
macro that produces many warnings.

I'm also not happy about the fact that we compile different test based
on ifdefs and that there are empty directories where binaries are
magically appear during the build. I would be much happier if we had a
real test sources there and share the large enough common bits in a
different way.

-- 
Cyril Hrubis
chrubis@suse.cz
