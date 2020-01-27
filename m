From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Jan 2020 14:42:57 +0100
Subject: [LTP] [PATCH V4 2/2] syscalls/pidfd_open
In-Reply-To: <169e5dfcac201330511347e38a25f373fc698c92.1580114160.git.viresh.kumar@linaro.org>
References: <007f89609cfe05cc4f7f0f310f05fc4bb0be829d.1580114160.git.viresh.kumar@linaro.org>
 <169e5dfcac201330511347e38a25f373fc698c92.1580114160.git.viresh.kumar@linaro.org>
Message-ID: <20200127134256.GA30831@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include "tst_test.h"
> +#include "lapi/pidfd_open.h"
> +
> +#define INVALID_PID	-1

I've removed this now unused macro and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
