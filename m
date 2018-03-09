From: Michael Moese <mmoese@suse.de>
Date: Fri, 9 Mar 2018 11:33:10 +0100
Subject: [LTP] [PATCH] Add regression test for CVE-2017-16939
In-Reply-To: <20180307170529.GC2607@rei>
References: <20180206140359.18387-1-mmoese@suse.de> <20180307170529.GC2607@rei>
Message-ID: <20180309103310.qx3oac43twii7wvh@linux.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

On Wed, Mar 07, 2018 at 06:05:29PM +0100, Cyril Hrubis wrote:
> Hi!

> > +static void do_run(void)
> > +{
> > +	struct msg_policy *p;
> > +
> > +	create_ns();
> > +	create_nl_socket();
> > +	p = init_policy_dump();
> > +	do_setsockopt();
> > +	send_msg(fd, &p->msg);
> > +	p = init_policy_dump();
> 
> Do we have to initialize the policy here for a second time?
> (does the fact that the p is a different pointe here matters?)
> 
> Also we should probably allocate these once in the test setup so that we
> do not waste memory when the test is executed with the -i option.
I was trying to keep as close as possible to the reproducer. I can check if
this can be moved to setup, and maybe only initialize once. However, I think
it is not a big waste of memory, after all the test does not loop or fork 
or anything like this.

> > +	pid = SAFE_FORK();
> > +	if (pid == 0) {
> > +		do_run();
> > +	} else {
> > +		usleep(250000);
>                 ^
> 		Why the usleep here? Should just the waitpid() below
> 		suffice in waiting for the child to exit?
> 
Well, this is something asynchronous happening in the kernel. When we don't 
wait for a while, the crash happens way after we reported a PASS.. but maybe
the usleep makes more sense after the waitpid(). 

Michael

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
