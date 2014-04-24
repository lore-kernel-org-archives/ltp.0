Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WdFcP-0002TR-A3
	for ltp-list@lists.sourceforge.net; Thu, 24 Apr 2014 09:06:57 +0000
Date: Thu, 24 Apr 2014 11:06:05 +0200
From: chrubis@suse.cz
Message-ID: <20140424090605.GB19162@rei.Home>
References: <0247700D01F14443B9209F90AD938CC524366845@sestoex05.enea.se>
	<1397663294-60210-1-git-send-email-mats.liljegren@enea.com>
	<1397663294-60210-2-git-send-email-mats.liljegren@enea.com>
	<20140422154711.GG3951@rei> <20140424105218.5cd2b5bf@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140424105218.5cd2b5bf@mats-desktop>
Subject: Re: [LTP] [RFC][PATCH] partrt_nohz_full: Introducing a new test case
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net, Kevin Hilman <khilman@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>

Hi!
> > > +/*
> > > + * Wait for a command with given pid to finish, and assert that
> > > the command
> > > + * returned success (0).
> > > + */
> > > +static void
> > > +pid_wait(pid_t pid)
> > > +{
> > > +	int status;
> > > +	char prefix[64];
> > > +
> > > +	snprintf(prefix, sizeof (prefix), "Pid %lu", (unsigned
> > > long) pid); +
> > > +	if (wait(&status) == -1)
> > > +		err("%s: wait() failed: %s", prefix,
> > > strerror(errno));
> > 
> > Use SAFE_WAIT() instead.
> > 
> 
> I couldn't find that function in include directory. Did I search in the
> wrong place?

Ah, you are right, that one is missing, sorry.

I will add it.

> > > +	const char *str,
> > > +	const char *err_prefix,
> > > +	int base
> > > +	)
> > > +{
> > > +	char *endptr;
> > > +	unsigned long val;
> > > +	val = strtoull(str, &endptr, base);
> > > +	if (endptr == str)
> > > +		err("%s: %s: Expected unsigned decimal value",
> > > err_prefix, str);
> > > +	if (*endptr != '\0')
> > > +		err("%s: %s: Garbage character '%c' found after
> > > decimal value",
> > > +			err_prefix, str, *endptr);
> > > +
> > > +	return val;
> > > +}
> > 
> > Use SAFE_STRTOUL() instead.
> 
> That would loose a lot of information useful for figuring out what the
> error is. For example, when called for translating command line options
> to integers, using SAFE_STRTOUL() will only say that "this string is
> not an integer" without giving any hint that we are talking about a
> command line option, and which option that is being parsed.

Well it depends on the fact if the additional work is worth of the
clarity.

Looked at the code it may be in this case. But at least remove the base
argument and just pass 10 to strtoull() instead. Keep things simple :)

> > > +	pid_t pid;
> > > +	int status;
> > > +
> > > +	if (!__sync_bool_compare_and_swap(&cleanup_entered, 0, 1,
> > > +						cleanup_entered)) {
> > > +		info("Cleanup: Already cleaning, exiting");
> > > +		return;
> > > +	}
> > > +
> > > +	info("Cleanup: Terminating children");
> > > +
> > > +	time_is_up = 1;
> > > +
> > > +	do {
> > > +		pid = wait(&status);
> > > +		if (pid != -1) {
> > > +			char cmd[64];
> > > +			snprintf(cmd, sizeof (cmd), "Pid %lu",
> > > +				 (unsigned long) pid);
> > > +			assert_exit_status(cmd, status);
> > 
> >                         I do not understand why you pass "Pid %lu"
> > 			string instead of the pid. It's more messy
> > 			this way.
> 
> This is because assert_exit_status() sometimes checks result of
> executed commands, and in those cases this function gets a command line
> rather than PID.

I've greped the source code for assert_exit_status and it's called from
pid_wait() and cleanup() in both cases the first argument is result of:

snprintf(buf, sizeof(buf), "Pid %lu", pid)

Do I miss something?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
