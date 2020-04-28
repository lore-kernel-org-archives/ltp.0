From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Apr 2020 08:22:43 +0200
Subject: [LTP] [PATCH] common_timers: staticize all definitions
In-Reply-To: <90ea553dfdea21683c517a7f47b2a5d3c2dba77f.1588050000.git.viresh.kumar@linaro.org>
References: <20200427145212.GA5678@dell5510>
 <90ea553dfdea21683c517a7f47b2a5d3c2dba77f.1588050000.git.viresh.kumar@linaro.org>
Message-ID: <20200428062243.GA2879@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> Staticize all variable and function definitions to avoid build failures
> in the future if this gets included by multiple files.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for a quick fix.

BTW for library files we prefer to have in header include/tst_foo.h just
function signatures and the implementations have in lib/tst_foo.c. Because also
having implementations in include files sometimes bring problems. But for lapi
files (which are included only for some tests) it's perfectly ok.

Kind regards,
Petr
