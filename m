From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 7 May 2020 17:19:58 +0200
Subject: [LTP] [PATCH 2/8] syscalls/futex: Add support for time64 tests
In-Reply-To: <379f4d58e86b5249f56ff58e1907dee69d67e451.1588669892.git.viresh.kumar@linaro.org>
References: <7e037dacaeb0c7f3bfd73cd11d80f3e1567dc052.1588669892.git.viresh.kumar@linaro.org>
 <379f4d58e86b5249f56ff58e1907dee69d67e451.1588669892.git.viresh.kumar@linaro.org>
Message-ID: <20200507151958.GC24733@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> This adds support for time64 tests to the existing futex() syscall
> tests.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Nice!

I'd personally drop that bogus GPL text and replace it with SPDX,
but that's unimportant and can be done later.

BTW I guess it's already git freeze before release, otherwise I'd merge these
two.

Kind regards,
Petr
