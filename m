From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 1 Dec 2020 09:26:58 +0100
Subject: [LTP] [PATCH 2/2] lib: Add test library design document
In-Reply-To: <20201201074243.GA6306@janakin.usersys.redhat.com>
References: <20201127163150.22903-1-chrubis@suse.cz>
 <20201127163150.22903-3-chrubis@suse.cz>
 <20201201074243.GA6306@janakin.usersys.redhat.com>
Message-ID: <20201201082658.GA20076@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Looks good to me.

Thanks.

> What do you think about adding a small ascii picture(s)?
> For example, one that shows outline of what's called in
> library vs. test process:
> 
>         lib process                                                                                    
>         +----------------------------+                                                                 
>         | main                       |                                                                 
>         |  tst_run_tcases            |                                                                 
>         |   do_setup                 |                                                                 
>         |   for_each_variant         |                                                                 
>         |    for_each_filesystem     |          test process                                           
>         |     fork_testrun ---------------------+--------------------------------------------+         
>         |      waitpid               |          | testrun                                    |         
>         |                            |          |  do_test_setup                             |         
>         |                            |          |   tst_test->setup                          |         
>         |                            |          |  run_tests                                 |         
>         |                            |          |   tst_test->test(i) or tst_test->test_all  |         
>         |                            |          |  do_test_cleanup                           |         
>         |                            |          |   tst_test->cleanup                        |         
>         |                            |          |  exit(0)                                   |         
>         |   do_exit                  |          +--------------------------------------------+         
>         |    do_cleanup              |                                                                 
>         |     exit(ret)              |                                                                 
>         +----------------------------+                                                                 

I would love that, feel free to send v2 based on my patch.

-- 
Cyril Hrubis
chrubis@suse.cz
