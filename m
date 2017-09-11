From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Sep 2017 13:53:49 +0200
Subject: [LTP] [PATCH] syscalls/shmat01: avoid dumping corefile for
 expected crash
In-Reply-To: <8df1dcaee102405b65fb575744323b3dfb348de1.1505129509.git.jstancek@redhat.com>
References: <8df1dcaee102405b65fb575744323b3dfb348de1.1505129509.git.jstancek@redhat.com>
Message-ID: <20170911115349.GA22586@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I guess that this is optimization that speeds up the test, right?

> -static void do_child(int *in_addr)
> +static void do_child(int *in_addr, int expect_crash)
>  {
> +	if (expect_crash) {
> +		/* crash is expected, avoid dumping corefile */
> +		struct rlimit r;
> +
> +		r.rlim_cur = 1;
> +		r.rlim_max = 1;
> +		SAFE_SETRLIMIT(RLIMIT_CORE, &r);

Hmm, why not 0?

The manual says that when we set it to 0 no core file are created. I
find that better than setting it to 1 which supposedly creates 1 byte
file...

-- 
Cyril Hrubis
chrubis@suse.cz
