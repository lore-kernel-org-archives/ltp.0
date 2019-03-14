From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Mar 2019 15:04:00 +0100
Subject: [LTP] [PATCH 1/3] syscalls/tgkill01: add new test
In-Reply-To: <1551943728-16222-2-git-send-email-sumit.garg@linaro.org>
References: <1551943728-16222-1-git-send-email-sumit.garg@linaro.org>
 <1551943728-16222-2-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190314140400.GB2536@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void run(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < n_threads; i++)
> +		threads[i].tid = -1;
> +
> +	test_running = 1;
> +	for (i = 0; i < n_threads; i++)
> +		start_thread(&threads[i]);

Just a minor nit these threads should actully be started in the test
setup() since we stop them in the test cleanup(), otherwise the test
breaks with the looping -i option.

-- 
Cyril Hrubis
chrubis@suse.cz
