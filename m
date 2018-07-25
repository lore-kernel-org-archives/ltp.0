From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Jul 2018 15:48:29 +0200
Subject: [LTP] [PATCH 1/3] syscalls/alarm02: Rewrite to new library
In-Reply-To: <1532431855-18452-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1532431855-18452-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180725134828.GB23890@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static struct tcase {
> +	char *buf;
> +	unsigned long int sec;
> +} tcases[] = {
> +	{"-1", -1},
> +	{"ULONG_MAX", ULONG_MAX},
> +	{"ULONG_MAX+1", ULONG_MAX + 1},
> +};

Looking at these values these seems to be a bit bogus, the alarm
prototype is defined with unsigned int, so the only value that makes
sense here would he UINT_MAX.

The -1 == ULONG_MAX when converted to unsigned int and ULONG_MAX + 1
would end up as 0.

Also alarm() returns the number of seconds remaining for the alarm, so
we should really do something as:

* call alarm(UINT_MAX);
* check the return value was 0
* call alarm(0);
* check that the return value was either UINT_MAX or UINT_MAX - 1

-- 
Cyril Hrubis
chrubis@suse.cz
