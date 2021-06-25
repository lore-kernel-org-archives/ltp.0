From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 25 Jun 2021 11:27:18 +0200
Subject: [LTP] [PATCH 1/2] lib/tst_test: setup TCID earlier in do_setup()
In-Reply-To: <20210624081500.11715-1-aleksei.kodanev@bell-sw.com>
References: <20210624081500.11715-1-aleksei.kodanev@bell-sw.com>
Message-ID: <YNWhdgAUp5e/hNwx@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> TCID can be NULL in tst_tmpdir() because it is set after do_setup():
> 
>     tst_run_tcases()
>         do_setup()
>             ...
>             tid = get_tid();
>             ...
>             tst_tmpdir()  /* using TCID here */
>         TCID = tid;

Good catch, I wonder how we missed this for so long...

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
