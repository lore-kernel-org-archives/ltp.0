From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Jul 2020 14:24:51 +0200
Subject: [LTP] [PATCH V7 04/19] syscalls/timerfd: Add support for time64
 tests
In-Reply-To: <657d473ec91c2d43e241ebc4a1ba20679fd4ef9a.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <657d473ec91c2d43e241ebc4a1ba20679fd4ef9a.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200702122451.GA9101@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

I've added a few more tst_its helpers and made use of them in the test
to make the code a bit more readable.

Also I've removed one useless TCID from newlib tests and added a few
missing TERRNOs.

-- 
Cyril Hrubis
chrubis@suse.cz
