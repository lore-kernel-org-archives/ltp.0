From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Jul 2019 11:33:49 +0200
Subject: [LTP] [PATCH] syscalls/clock_adjtime: Fix unsupported WARN
In-Reply-To: <20190621095134.12604-1-pifang@redhat.com>
References: <20190621095134.12604-1-pifang@redhat.com>
Message-ID: <20190704093349.GA6802@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

>  static long hz;
>  static struct timex saved, ttxc;
> +static int support = 0;

Global variables are initialized to 0, there is no point in adding the
assignment here. I also renamed the support to supported, it's not that
longer and describes the situation better.

-- 
Cyril Hrubis
chrubis@suse.cz
