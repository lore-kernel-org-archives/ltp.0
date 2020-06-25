From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 25 Jun 2020 15:26:10 +0530
Subject: [LTP] [PATCH V4 02/17] syscalls/timer_settime: Add support for
 time64 tests
In-Reply-To: <20200624143056.GB5181@yuki.lan>
References: <cover.1590144577.git.viresh.kumar@linaro.org>
 <db9669587a1c19b056a1cca6908fb8b5f316a76d.1590144577.git.viresh.kumar@linaro.org>
 <20200624143056.GB5181@yuki.lan>
Message-ID: <20200625095610.6g5p3tsfsmfl6zrh@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24-06-20, 16:30, Cyril Hrubis wrote:
> Hi!
> So this test depends on the previous one since we are adding the tst_its
> piece by piece, shouldn't we add all the functions into the tst_timer.h
> in a separate patch?

You mean functions related only to "its" ? Or all the wrappers for
various syscalls that are getting added to tst_timer.h ?

-- 
viresh
