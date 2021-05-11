From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 May 2021 14:40:12 +0200
Subject: [LTP] [RFC PATCH v2 1/1] netns_netlink: Rewrite into new API
In-Reply-To: <YJpF5mq0oftICi+u@yuki>
References: <20210401141210.9536-1-pvorel@suse.cz>
 <YJpF5mq0oftICi+u@yuki>
Message-ID: <YJp7LBc0IxKuwNh2@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > Remove check for iproute 100519 (v2.6.34 => old enough to drop this check).

> I guess that this is fine, it seems to be more than 10 years old now.

> > Remove check for unshare() CLONE_NEWNET support (since 2.6.24, old enough).

> Actually there are CONFIG_FOO_NS variables in kernel .config and
> individual namespaces can be turned on/off. So we have to check if
> network namespaces have been compiled into kernel or not. I guess that
> simplest solution here would be adding .needs_kconfig field with
> "CONFIG_NET_NS=y".
Oh yes, there are other tests which use CONFIG_NET_NS=y.

BTW I guess sooner or later we should introduce variable to print only info that
config file is not available (for these embedded platforms and old android).

...
> >  int child_func(void)

> static int child_func(void)
+1

> >  {
> > @@ -71,8 +48,7 @@ int child_func(void)
> >  	char buffer[4096];
> >  	struct nlmsghdr *nlh;

> > -	/* child will listen to a network interface create/delete/up/down
> > -	 * events */
> > +	/* child will listen to a network interface create/delete/up/down events */
> >  	memset(&sa, 0, sizeof(sa));
> >  	sa.nl_family = AF_NETLINK;
> >  	sa.nl_groups = RTMGRP_LINK;
> > @@ -89,7 +65,7 @@ int child_func(void)
> >  	}

> >  	/* waits for parent to create an interface */
> > -	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> > +	TST_CHECKPOINT_WAIT(0);

> >  	/* To get rid of "resource temporarily unavailable" errors
> >  	 * when testing with -i option */
> > @@ -121,60 +97,49 @@ int child_func(void)
> >  	return 0;
> >  }


> We can simplify the code here by using SAFE_MACROS() which is allowed in
> new library.

> > -static void test(void)
> > +static void test_netns_netlink(void)
> >  {
> >  	pid_t pid;
> >  	int status;

> >  	/* unshares the network namespace */
> > -	if (unshare(CLONE_NEWNET) == -1)
> > -		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
> > +	SAFE_UNSHARE(CLONE_NEWNET);

> > -	pid = tst_fork();
> > -	if (pid < 0) {
> > -		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
> > -	}
> > +	pid = SAFE_FORK();
> >  	if (pid == 0) {
> >  		_exit(child_func());

> No need for _exit() here, _exit() is to be used from signal handlers.
+1

> >  	}

> >  	/* creates TAP network interface dummy0 */
> >  	if (WEXITSTATUS(system("ip tuntap add dev dummy0 mode tap")))
> > -		tst_brkm(TBROK, cleanup, "system() failed");
> > +		tst_brk(TBROK, "system() failed");

> >  	/* removes previously created dummy0 device */
> >  	if (WEXITSTATUS(system("ip tuntap del mode tap dummy0")))
> > -		tst_brkm(TBROK, cleanup, "system() failed");
> > +		tst_brk(TBROK, "system() failed");

> >  	/* allow child to continue */
> > -	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> > -
> > +	TST_CHECKPOINT_WAKE(0);

> > -	SAFE_WAITPID(cleanup, pid, &status, 0);
> > +	SAFE_WAITPID(pid, &status, 0);
> >  	if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
> > -		tst_resm(TFAIL, "netlink interface fail");
> > +		tst_res(TFAIL, "netlink interface fail");
> >  		return;
> >  	}

> We can also get rid of this result propagation as we can:

> - use SAFE_MACROS in child
> - use tst_res() in child as:

> static void child_func(void)
> {
> 	...

> 	if (event_found)
> 		tst_res(TPASS, "...");
> 	else
> 		tst_res(TFAIL, "...");

> 	exit(0);
> }

> And with that all we have to do is a call to tst_reap_children()

Oh yes, that makes sense. Sorry for not catching obvious error not using safe
macros.

Sending v3 now.

Kind regards,
Petr
