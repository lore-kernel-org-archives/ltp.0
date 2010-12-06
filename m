Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PPeCA-0005LV-MH
	for ltp-list@lists.sourceforge.net; Mon, 06 Dec 2010 16:45:46 +0000
Date: Mon, 6 Dec 2010 17:59:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101206165907.GD6562@saboteur.suse.cz>
References: <449629110.2441291439746332.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1406083705.2491291440102995.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1406083705.2491291440102995.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] a race in pid generation that causes pids to be
 reused immediatelly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > > +			if (lc > 0) {
> > > +				printf("last_pid = %d\npid = %d\n", last_pid, pid);
> > > +				distance = PidDistance(last_pid, pid);
> > > +				if (distance == 0 || distance > 30000) {
> > 
> > Hmm are you sure that distance > 30000 is good thing to assert? Who says
> > that two pids keeps at least 2768 distance and even then, who says that
> > 32768 is maximal pid (see below)?
> It was using a expert's advise here,
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=5fdee8c4a5e1800489ce61963208f8cc55e42ea1

The problem here is that following code is just hacked together to
reproduce some bug, creating robust testsuite is much more work. Perhaps
asking the person who wrote the code about more details/help would be
way to go.

> > > +	return 0;
> > Rather use tst_exit() here.
> check() function is used in main() here,
> 
> TEST(check())
> cleanup();
> 
> As you can see that the test has not finished yet after returned. It might also break existing LTP standard options like,
> 
>   -c n    Run n copies concurrently
>   -I x    Execute test for x seconds
> 
> as TEST() seems expecting a non-void function.

Ah I see. So remove the TEST() macro and change check() to void.

> > > +	/* capture signals */
> > > +	tst_sig(FORK, DEF_HANDLER, cleanup);
> > > +
> > > +	/* Pause if that option was specified */
> > > +	TEST_PAUSE;
> > > +
> > > +	tst_tmpdir();
> > 
> > Do you really need temporary directory to test fork() ?
> Not really, but as mentioned earlier that those were copied from a standard LTP test template that I don't if some LTP internal things were using them. For example, LTP internal seems make use of tst_sig() and TEST_PAUSE in setup() for those standard options,
> 
>   -p      Pause for SIGUSR1 before starting
>   -P x    Pause for x seconds between iterations
> 
> Therefore, I am concerning about remove those temporary directory creating might break other standard options and alike.

As said before, it just creates temporary directory.

> > > +/* The distance mod 32768 between two pids, where the first pid is
> > > +   expected to be smaller than the second. */
> > > +int PidDistance(pid_t first, pid_t second) {
> > > +	return (second + 32768 - first) % 32768;
> > > +}
> > 
> > The comment doesn't hold as when second is smaller than first the
> > negative value would be smaller than 32768.
> Again this is what the expert said. What would be your advise here?

Ask the expert ;). Seriously kernel folks should help with writing
tests, they are the only ones who trully know what to test anyway.

> > Moreover the maximal pid value may be changed by writing to
> > "/proc/sys/kernel/pid_max", then this code is broken.
> One thing I can do here is to backup/restore /proc/sys/kernel/pid_max and set a value explicitly to avoid ambiguity.
> 
> > Also I'm not sure if the result of such computation couldn't
> > overflow/underflow as int may not be the same size as pid_t. 
> Is this still an issue after set pid_max a value explicitly like 32768? Thanks.

I'm not sure if it's possible to lower the value, I haven't read the
kernel code.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
