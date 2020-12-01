From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 1 Dec 2020 05:47:12 -0500 (EST)
Subject: [LTP] [PATCH v2 2/2] lib: Add test library design document
In-Reply-To: <20201201092040.GB20076@yuki.lan>
References: <20201127163150.22903-3-chrubis@suse.cz>
 <0f8ede1f55d67b7ff4fd17c38f9bfc6a835b43a3.1606813521.git.jstancek@redhat.com>
 <20201201092040.GB20076@yuki.lan>
Message-ID: <738639647.26717511.1606819632601.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > +## High-level picture
> > +
> > +    library process
> > +    +----------------------------+
> > +    | main                       |
> > +    |  tst_run_tcases            |
> > +    |   do_setup                 |
> > +    |   for_each_variant         |
> > +    |    for_each_filesystem     |   test process
> > +    |     fork_testrun
> > ------------->+--------------------------------------------+
> > +    |      waitpid               |   | testrun
> > |
> > +    |                            |   |  do_test_setup
> > |
> > +    |                            |   |   tst_test->setup
> > |
> > +    |                            |   |  run_tests
> > |
> > +    |                            |   |   tst_test->test(i) or
> > tst_test->test_all  |
> > +    |                            |   |  do_test_cleanup
> > |
> > +    |                            |   |   tst_test->cleanup
> > |
> > +    |                            |   |  exit(0)
> > |
> > +    |   do_exit                  |
> > +--------------------------------------------+
> > +    |    do_cleanup              |
> > +    |     exit(ret)              |
> > +    +----------------------------+
> 
> Shouldn't we wrap this to ``` so that it renders nicely on the web?

I thought the 4 spaces prefix will already do that. I was testing
it online on dillinger.io and stackedit.io. But I'm fine with adding ```,
if that's better for github.



