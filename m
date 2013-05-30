Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ui7zZ-0004th-Tt
	for ltp-list@lists.sourceforge.net; Thu, 30 May 2013 18:54:29 +0000
Date: Thu, 30 May 2013 20:55:45 +0200
From: chrubis@suse.cz
Message-ID: <20130530185545.GA1254@rei.suse.cz>
References: <1369823309-29965-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1369823309-29965-1-git-send-email-alexey.kodanev@oracle.com>
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
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  runtest/controllers                                |    1 +
>  .../kernel/controllers/cgroup_xattr/.gitignore     |    1 +
>  testcases/kernel/controllers/cgroup_xattr/Makefile |   19 +
>  testcases/kernel/controllers/cgroup_xattr/README   |   25 ++
>  .../kernel/controllers/cgroup_xattr/cgroup_xattr.c |  435 ++++++++++++++++++++
>  5 files changed, 481 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/controllers/cgroup_xattr/.gitignore
>  create mode 100644 testcases/kernel/controllers/cgroup_xattr/Makefile
>  create mode 100644 testcases/kernel/controllers/cgroup_xattr/README
>  create mode 100644 testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c

Pushed after removing trailing whitespace from the Makefile, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
