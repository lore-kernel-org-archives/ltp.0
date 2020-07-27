From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Jul 2020 11:17:49 +0200
Subject: [LTP] [PATCH V7 13/19] syscalls/ppoll: Add support for time64
 tests
In-Reply-To: <a014d7718d2a1c08cdf0dd07849f550d42a2db22.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <a014d7718d2a1c08cdf0dd07849f550d42a2db22.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200727091749.GA7863@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two minor changes, thanks.

* Added LTP_ATTRIBUTE_UNUSED to the libc wrapper to silence a warning

* Shortened the short ts in order to speed up the test a little

-- 
Cyril Hrubis
chrubis@suse.cz
