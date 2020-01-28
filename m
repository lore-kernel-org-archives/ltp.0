From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Jan 2020 14:40:37 +0100
Subject: [LTP] [PATCH V4 2/2] syscalls/io_pgetevents: New tests
In-Reply-To: <cc9d0f47db41cad97c590cf7b58e8d662a437a91.1580180304.git.viresh.kumar@linaro.org>
References: <2d23f3a542bbd04179aba828e28d37f5c7be7b45.1579859350.git.viresh.kumar@linaro.org>
 <cc9d0f47db41cad97c590cf7b58e8d662a437a91.1580180304.git.viresh.kumar@linaro.org>
Message-ID: <20200128134037.GB26365@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with one minor adjustement, thanks.

I've removed the tst_test.h include from the lapi header and put it into
the two test sources. Since that is the main header the tests should
include it's better when they include it explicitely.

-- 
Cyril Hrubis
chrubis@suse.cz
