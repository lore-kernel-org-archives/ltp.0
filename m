Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UfVbL-0002is-Cj
	for ltp-list@lists.sourceforge.net; Thu, 23 May 2013 13:30:39 +0000
Date: Thu, 23 May 2013 15:31:48 +0200
From: chrubis@suse.cz
Message-ID: <20130523133148.GB22501@rei.suse.cz>
References: <1369292997-10921-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1369292997-10921-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] New core test of cgroups and extended attributes
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Support of extended attributes in cgroups was added in Linux 3.7.

I've tried to run the test on my machine where cgroups are allready
mounted to /sys/fs/cgroup (which seems to be the case for modern
distributions). In such situation the mount in the test fails with
EBUSY. I looks like the root hierarchy can be mounted only once. Now we
cannot unmout the /sys/fs/cgroup as this one is used by the system.

But it looks like we can mount each of the controllers, i.e.

for each controller:
	mkdir /path/type
	mount -t cgroup -o type type /path/type

So the options are either to use the /sys/fs/cgroup directory or mount
each controller one by one.

What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
