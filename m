From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Oct 2020 14:15:09 +0200
Subject: [LTP] [PATCH V3 3/3] syscalls: select: Rename select04.c to
 select02.c
In-Reply-To: <e9bcd007772ffadd6326dca29532bb4d3f8e7f0a.1599558175.git.viresh.kumar@linaro.org>
References: <6fbfc6919c0000e7a7745afbc3c94baab02603fa.1599558175.git.viresh.kumar@linaro.org>
 <e9bcd007772ffadd6326dca29532bb4d3f8e7f0a.1599558175.git.viresh.kumar@linaro.org>
Message-ID: <20201014121509.GE31816@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
We will have to implement a test for the errors as well, so I wouldn't
rename the test like this yet.

-- 
Cyril Hrubis
chrubis@suse.cz
