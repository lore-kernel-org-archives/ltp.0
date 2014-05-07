Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wi0nk-0003oH-I5
	for ltp-list@lists.sourceforge.net; Wed, 07 May 2014 12:18:20 +0000
Date: Wed, 7 May 2014 14:17:21 +0200
From: chrubis@suse.cz
Message-ID: <20140507121721.GA20240@rei>
References: <1397663294-60210-1-git-send-email-mats.liljegren@enea.com>
	<1398697619-27372-1-git-send-email-mats.liljegren@enea.com>
	<1398697619-27372-2-git-send-email-mats.liljegren@enea.com>
	<20140506162009.GB7908@rei.Home>
	<20140507132016.40361a0a@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140507132016.40361a0a@mats-desktop>
Subject: Re: [LTP] [PATCH] partrt_nohz_full: Introducing a new test case
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
> > > +	/* Launch command */
> > > +	errno = 0;
> > > +	file = popen(cmd_buf, "r");
> > > +	if (file == NULL) {
> > > +		if (errno == 0)
> > > +			tst_brkm(TBROK, cleanup, "%s: popen(): Out
> > > of memory",
> > > +				 cmd_buf);
> > > +		else
> > > +			tst_brkm(TBROK | TERRNO, cleanup,
> > > +				"%s: popen() failed", cmd_buf);
> > > +	}
> > 
> > This may be worth of SAFE_POPEN(), I can add it if you want.
> 
> Go ahead. I'll update my code when you're done.

Ok.

> > > +	/* Move child to RT partition */
> > > +	SAFE_ASPRINTF(cleanup, &tid_str, "%ld", (long) tid);
> > > +	SAFE_WRITE(cleanup, 1, cpuset_tasks_fd, tid_str,
> > > strlen(tid_str)); +
> > > +	free(tid_str);
> > > +	SAFE_CLOSE(cleanup, cpuset_tasks_fd);
> > 
> > 	SAFE_FILE_PRINTF(cleanup, CPUSET_RT_TASKS_FILE, "%ld",
> > (long)tid) ?
> > 
> > 	Or is there a good reason to use open(), asprintf(), write()
> > and close() instead?
> 
> Well, printf() by itself will do no file updates, but I replaced
> open(), asprintf(), write(), free() and close() with fopen(), fprintf()
> and fclose().

You lost me here.

Have you seen the code for the SAFE_FILE_PRINTF()? What it does is
is fopen(), fprintf() and fclose(). It was designed to simplify
writing to various kernel pseudo filesystems to one call.

> > > +	for (nr_matches = fscanf(stream, "%d-%d", &range_first,
> > > &range_last);
> > > +	     nr_matches > 0;
> > > +	     nr_matches = fscanf(stream, ",%d-%d", &range_first,
> > > &range_last)) {
> > > +		if (nr_matches == 1)
> > > +			range_last = range_first;
> > > +
> > > +		/* Set all bits in range */
> > > +		for (bit = range_first; bit <= range_last; bit++)
> > > +			mask |= (1 << bit);
> > 
> >                        Are you sure that this would not overflow?
> > 
> > 		       I guess that it depends on how you have
> > 		       partitioned your CPUs.
> 
> As far as I know there is no API stable and architecture portable way of
> determining how many CPUs a machine has, which makes this whole
> business a bit tricky. The problem starts with the partrt tool, which
> should actually support arbitrarily long masks, but this hasn't
> happened.

There is sysconf(_SC_NPROCESSORS_CONF) which tries to collect this
information from the system. It first tries /sys/devices/system/cpu/
then /proc/cpuinfo.

> This is on the TODO list, so currently the test only guarantees 32
> CPUs. Should probably be documented somewhere...

Right, at least add this into the documentation.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
