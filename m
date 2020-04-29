From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Apr 2020 18:02:22 +0200
Subject: [LTP] [PATCH 4/4] syscalls/fanotify: New test for FAN_MODIFY_DIR
In-Reply-To: <20200421065002.12417-5-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
 <20200421065002.12417-5-amir73il@gmail.com>
Message-ID: <20200429160222.GC7754@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/*
> +	 * Create subdir and watch open events "on children" with name.
> +	 */
> +	if (mkdir(dname1, 0755) < 0) {
> +		tst_brk(TBROK | TERRNO,
> +				"mkdir('"DIR_NAME1"', 0755) failed");
> +	}

The rest of the tests are using SAFE_ macros to generate events, which
is basically the same these snippets do, but the code is a bit shorter.

Is there a reason not to use them in this test?

-- 
Cyril Hrubis
chrubis@suse.cz
