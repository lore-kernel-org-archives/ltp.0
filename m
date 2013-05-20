Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UeSD1-0000Jd-AZ
	for ltp-list@lists.sourceforge.net; Mon, 20 May 2013 15:41:11 +0000
Date: Mon, 20 May 2013 17:42:15 +0200
From: chrubis@suse.cz
Message-ID: <20130520154215.GB21671@rei.suse.cz>
References: <4e8cb837f8dd19db77ca70bd3b0094b060b0b0a0.1368780870.git.jstancek@redhat.com>
	<f86dfe8123738c73c9dc2fd08309bfbe09e925e6.1368780870.git.jstancek@redhat.com>
	<20130520144827.GB21016@rei.suse.cz>
	<1279126164.4640384.1369062925009.JavaMail.root@redhat.com>
	<20130520152124.GA21509@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130520152124.GA21509@rei.suse.cz>
Subject: Re: [LTP] [PATCH 2/2] waitid02: split code into separate testcases
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
> There could be one instance of the checkpoint active at the time but
> that is only because the TST_CHECKPOINT_INIT() does not take the FIFO
> name as a parameter. The rest of the code does mostly what the pipe()
> does but includes the timeout detection and has more strict error
> condition checks.
> 
> If you create one checkpoint at global setup, you can reuse it in the
> rest of the testcases given that WAIT and SIGNAL is called exacly once
> for each test and test are not executed in parallel.

And I forgett to add, if the interface does not work for you, feel free
to propose changes (there is not much of tests that use this interface
yet so it is realtively easy to modify the API and fix the few usages).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
