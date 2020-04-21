From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Apr 2020 17:40:06 +0200
Subject: [LTP] [PATCH V3 1/2] tst_timer: Add support for kernel's 64 bit
 timespec
In-Reply-To: <08a307591b531593bbaa5b1e8a4c841e80493937.1587033556.git.viresh.kumar@linaro.org>
References: <cover.1587033556.git.viresh.kumar@linaro.org>
 <08a307591b531593bbaa5b1e8a4c841e80493937.1587033556.git.viresh.kumar@linaro.org>
Message-ID: <20200421154006.GA14036@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've cleaned up and simplified these changes + wrote a simple test and
pushed the result, thanks a lot for your effors.

Can you please rebase the test changes on the top of these changes? It
should be merely cosmetical, function names have changes etc.

-- 
Cyril Hrubis
chrubis@suse.cz
