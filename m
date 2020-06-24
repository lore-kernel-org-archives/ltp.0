From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Jun 2020 16:30:56 +0200
Subject: [LTP] [PATCH V4 02/17] syscalls/timer_settime: Add support for
 time64 tests
In-Reply-To: <db9669587a1c19b056a1cca6908fb8b5f316a76d.1590144577.git.viresh.kumar@linaro.org>
References: <cover.1590144577.git.viresh.kumar@linaro.org>
 <db9669587a1c19b056a1cca6908fb8b5f316a76d.1590144577.git.viresh.kumar@linaro.org>
Message-ID: <20200624143056.GB5181@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
So this test depends on the previous one since we are adding the tst_its
piece by piece, shouldn't we add all the functions into the tst_timer.h
in a separate patch?

-- 
Cyril Hrubis
chrubis@suse.cz
