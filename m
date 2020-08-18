From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 18 Aug 2020 09:54:36 -0400 (EDT)
Subject: [LTP] [PATCH 1/4] Integrate tst_taint_check() into main LTP
 library
In-Reply-To: <20200811130502.12010-1-mdoucha@suse.cz>
References: <20200811130502.12010-1-mdoucha@suse.cz>
Message-ID: <1124120972.9071386.1597758876284.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
>  static void do_test_setup(void)
> @@ -1279,6 +1282,9 @@ static int fork_testrun(void)
>  	alarm(0);
>  	SAFE_SIGNAL(SIGINT, SIG_DFL);
>  
> +	if (tst_test->taint_check && tst_taint_check())
> +		tst_brk(TBROK, "Kernel is now tainted.");
> +

Shouldn't this be TFAIL?

