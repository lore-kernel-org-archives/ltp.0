Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U88Fz-0000mt-PB
	for ltp-list@lists.sourceforge.net; Wed, 20 Feb 2013 11:54:39 +0000
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id F169EA50DE
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Feb 2013 12:54:26 +0100 (CET)
Date: Wed, 20 Feb 2013 12:55:07 +0100
From: chrubis@suse.cz
Message-ID: <20130220115507.GB1422@rei.Home>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [RFC] replacement for runltp + ltp-pan
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
To: ltp-list@lists.sourceforge.net

Hi!
Some time ago I started to think about replacement for the current
runltp + ltp-pan test execution system, before I start writing any code
here are a few points that I currently have in mind. Feel free to
comment on them.

Here is what I think that is wrong with the current system:

* Open Posix Testsuite is not executed by runtest + ltp-pan
  
  - technically this should be as easy as translating the return
    codes and generating runtest files as we build the testsuite

* Current system doesn't support timeouts

  - which should be easy to implement but would require change
    to the runtest file format (one timeout for all doesn't
    work as we have tests that runs less than second and tests
    that takes more than ten minutes).

* The output to stdout is messy

  What I would like is:

  [004/243] getrusage04 .................................. [FAILED]
  [005/243] getsid01 ..................................... [RUNNING]

* The new tool should be able search runtest files for particular test
  names, blacklist some tests if needed, etc. Which is now done by
  grepping runtest files in the hacked together runltp script.

* There are tests that needs a disk partition or loopback image, we
  should handle that and export right environment variables. This should
  be designed, documented and fixed.

* The current system doesn't produce usable logs

  Well you get list of testcases that succeeded and list of testcases
  that has failed, which is better than nothing.
  
  But what I'm thinking about is some more structured format that
  will include test output, possibly test duration and so. I personally
  think that JSON is good candidate for this job as it's structured,
  easy to read and widely supported as there are libraries for python,
  perl, etc.

  Then we could create git repo with reference results. Generate html
  pages from the repo with results. Write scripts for result comparsion,
  etc.

  The JSON log may look like:

  "LTP Version": 20130109,
  "System Info": {
  	"Kernel Version": "3.7.1",
	"Hardware": {
		"Arch": "x86_64",
		"CPUs": 2,
		"Ram": 4051840,
		(more filelds like this follows),
	},
  },
  "Results": [
  	{
		"Test Name": "getrusage04",
		"Test Result": "FAILED",
		"Test Runtime": 0.011532,
		"Test CPU Time": 0.003234,
		"Test Output": [
			"TINFO : Using 1 as multiply factor for max increment",
			"TINFO : utime:         0us; stime         0us",
			"TINFO : utime:         0us; stime      4000us",
			"TFAIL : stime increased > 2000us",
		],
	},
	(more test results follows),
  ]

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
