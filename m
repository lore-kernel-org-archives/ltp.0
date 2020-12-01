From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 1 Dec 2020 10:20:40 +0100
Subject: [LTP] [PATCH v2 2/2] lib: Add test library design document
In-Reply-To: <0f8ede1f55d67b7ff4fd17c38f9bfc6a835b43a3.1606813521.git.jstancek@redhat.com>
References: <20201127163150.22903-3-chrubis@suse.cz>
 <0f8ede1f55d67b7ff4fd17c38f9bfc6a835b43a3.1606813521.git.jstancek@redhat.com>
Message-ID: <20201201092040.GB20076@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +## High-level picture
> +
> +    library process
> +    +----------------------------+
> +    | main                       |
> +    |  tst_run_tcases            |
> +    |   do_setup                 |
> +    |   for_each_variant         |
> +    |    for_each_filesystem     |   test process
> +    |     fork_testrun ------------->+--------------------------------------------+
> +    |      waitpid               |   | testrun                                    |
> +    |                            |   |  do_test_setup                             |
> +    |                            |   |   tst_test->setup                          |
> +    |                            |   |  run_tests                                 |
> +    |                            |   |   tst_test->test(i) or tst_test->test_all  |
> +    |                            |   |  do_test_cleanup                           |
> +    |                            |   |   tst_test->cleanup                        |
> +    |                            |   |  exit(0)                                   |
> +    |   do_exit                  |   +--------------------------------------------+
> +    |    do_cleanup              |
> +    |     exit(ret)              |
> +    +----------------------------+

Shouldn't we wrap this to ``` so that it renders nicely on the web?

-- 
Cyril Hrubis
chrubis@suse.cz
