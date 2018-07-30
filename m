From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Jul 2018 14:19:41 +0200
Subject: [LTP] [PATCH] ltp-pan: Increase allowed width of test name in
	logs
In-Reply-To: <20180726155139.11246-1-punit.agrawal@arm.com>
References: <20180726155139.11246-1-punit.agrawal@arm.com>
Message-ID: <20180730121941.GB14198@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static char *result_fmt = "%-50s %-10.10s %-10.10s\n";

This should be a macro otherwise the compilation will fail for some
compilers since the format string passed to fprintf() is not a static
string.


Other than that it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
