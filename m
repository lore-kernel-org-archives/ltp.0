From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jan 2016 17:28:46 +0100
Subject: [LTP] [PATCH 2/2] commands/insmod: Added new testcase to test
 insmod(8)
In-Reply-To: <1450422438-8798-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1450422438-8798-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1450422438-8798-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160127162845.GA1358@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +setup()
> +{
> +	tst_require_root
> +
> +	tst_check_cmds rmmod insmod
> +
> +	if ! [ -e ./test_insmod01.ko ]; then
> +		tst_brkm TCONF "'test_insmod01.ko' not found"
> +	fi

We should really copy the behavior of tst_module_exist() from C library
here, i.e. add a function to test.sh that will return a path to the
module in case that it exists. I can write the function if needed.

> diff --git a/testcases/commands/insmod/test_insmod01.c b/testcases/commands/insmod/test_insmod01.c

And I would prefix the module name with ltp_ as well so that it's clear
where it came from.


The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
