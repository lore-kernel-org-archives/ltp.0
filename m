From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Aug 2018 17:54:33 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/alarm02: Rewrite to new library
In-Reply-To: <1532583167-8455-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <20180725134828.GB23890@rei>
 <1532583167-8455-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180802155433.GB21827@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +} tcases[] = {
> +	{"-1", -1},
> +	{"UINT_MAX", UINT_MAX},
> +	{"UINT_MAX + 1", UINT_MAX + 1},
> +};

Can we get rid of the -1 and 0 (aka UINT_MAX + 1), or replace them with
something more meaningful?

I would probably go for UINT_MAX and UINT_MAX/2 or something similar, as
it is the overflows that these numbers are causing are very confusing.

-- 
Cyril Hrubis
chrubis@suse.cz
