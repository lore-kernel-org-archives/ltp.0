Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U8VOf-0003st-QA
	for ltp-list@lists.sourceforge.net; Thu, 21 Feb 2013 12:37:09 +0000
Date: Thu, 21 Feb 2013 13:37:41 +0100
From: chrubis@suse.cz
Message-ID: <20130221123741.GA6872@rei>
References: <20130220115507.GB1422@rei.Home>
	<114382587.6789703.1361448130009.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <114382587.6789703.1361448130009.JavaMail.root@redhat.com>
Subject: Re: [LTP] [RFC] replacement for runltp + ltp-pan
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > * Current system doesn't support timeouts
> > 
> >   - which should be easy to implement but would require change
> >     to the runtest file format (one timeout for all doesn't
> >     work as we have tests that runs less than second and tests
> >     that takes more than ten minutes).
> 
> Finding the default for some may be tricky, as they can depend on 
> drive speed or amount of RAM.

There is a simple solution to this. We can define multiplier constant
for the timeouts that could be either set manually or measured at
runtime. Tuning this would be a little of work, but I think that this
will work well.

Moreover the timeouts are more of safety measure for tests that will
deadlock or loop infinitely, so that the testrun is finished in morning
even if there are some broken tests. For tests that takes less than
second, five or ten minutes timeout is good enough. It's more
problematic for testcases that do heavy IO and could take anything from
ten minutes to half of hour.

> Is there a plan for some transition period where both of these
> would work side-by-side?

Sure, I do not plan to remove the current system until the new system is
finished, tested and widely used.

That would unfortunately means that the runtest files would need to be
duplicated, or split into several files and preprocessed before they are
used in new environment.

> Looking at current output, almost all fields look useful.
> Well except 'contacts', not sure if I have ever seen this set to non-empty string.
> 
> <<<test_start>>>
> tag=abs01 stime=1361370087
> cmdline="abs01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> abs01       1  TPASS  :  Test passed
> abs01       2  TPASS  :  Test passed
> abs01       3  TPASS  :  Test passed
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>

I would be happier with less verbose output, but we can easily add a
switch to control the way the output is printed into the stdout.

I my idea is to make the tests print less information into stdout by
default and store more of it into the logs.

> >   "Results": [
> >   	{
> > 		"Test Name": "getrusage04",
> > 		"Test Result": "FAILED",
> > 		"Test Runtime": 0.011532,
> > 		"Test CPU Time": 0.003234,
> > 		"Test Output": [
> > 			"TINFO : Using 1 as multiply factor for max increment",
> > 			"TINFO : utime:         0us; stime         0us",
> > 			"TINFO : utime:         0us; stime      4000us",
> > 			"TFAIL : stime increased > 2000us",
> > 		],
> > 	},
> > 	(more test results follows),
> >   ]
> 
> I don't have objections to JSON. I do not parse existing logs, I just search/read them
> when there is failure. And it should be easy to just convert it to plain text if there is
> need for it.

That should be easy enough with short python script.

The main motivation for more structured logs is, at least from my point
of view, the ability to compare results. There are still testcases that
fails randomly, in such case you can do several runs, process the data
and easily spot that the test failed three times out of four.

Moreover currently LTP has no support for benchmarks, we have no
information on how fast syscalls are. If the logs are done right, it
should be possible to do several runs, reboot into different kernel, do
another round of runs, process the data and see if something has been
slowed down significantly.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
