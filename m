Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X099y-00052X-Ap
	for ltp-list@lists.sourceforge.net; Thu, 26 Jun 2014 12:52:14 +0000
Date: Thu, 26 Jun 2014 14:51:56 +0200
From: chrubis@suse.cz
Message-ID: <20140626125156.GA12090@rei.suse.cz>
References: <1400502716-8969-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1403256601-14345-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403256601-14345-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] hotplug/cpu_hotplug: add it to run default and
 cleanup
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Add cpu_hotplug tests to scenario_groups/default.
> 
> Rename files in include and tools directories.
> 
> Modify Makefile.
> 
> Some cleanup of cpuhotplug0*.sh:
>   Obtain some variables' value from parameters.
>   Use functions in test.sh, eg. tst_brkm.
>   Use 'TST_CLEANUP' shell variable.
> 
> Fix error in the procedure of offline/online cpu.
> 
> Modify 'sar' command in cpuhotplug06.sh.
> 
> Currently cpuhotplug01.sh is disabled, because some irqs'
> smp_affinity can't be set.
> 
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>  runtest/cpuhotplug                                 |  14 +-
>  scenario_groups/default                            |   1 +
>  testcases/kernel/hotplug/cpu_hotplug/ChangeLog     |   6 +-
>  testcases/kernel/hotplug/cpu_hotplug/Makefile      |  10 +-
>  testcases/kernel/hotplug/cpu_hotplug/README        |   4 +-
>  .../kernel/hotplug/cpu_hotplug/functional/Makefile |  25 +++
>  .../hotplug/cpu_hotplug/functional/cpuhotplug01.sh | 136 +++++++-------
>  .../hotplug/cpu_hotplug/functional/cpuhotplug02.sh |  84 ++++++---
>  .../hotplug/cpu_hotplug/functional/cpuhotplug03.sh | 116 +++++++-----
>  .../hotplug/cpu_hotplug/functional/cpuhotplug04.sh |  99 ++++++----
>  .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh | 118 +++++++-----
>  .../hotplug/cpu_hotplug/functional/cpuhotplug06.sh |  85 +++++----
>  .../hotplug/cpu_hotplug/functional/cpuhotplug07.sh |  90 +++++----
>  .../kernel/hotplug/cpu_hotplug/include/Makefile    |  25 +++
>  .../kernel/hotplug/cpu_hotplug/include/hotplug.fns | 202 --------------------
>  .../kernel/hotplug/cpu_hotplug/include/hotplug.sh  | 203 +++++++++++++++++++++
>  .../hotplug/cpu_hotplug/include/testsuite.fns      | 170 -----------------
>  .../hotplug/cpu_hotplug/include/testsuite.sh       | 171 +++++++++++++++++

The hotplug.sh and testsuite.sh files should be prefixed with the
cpuhotplug_ too, otherwise they are likely to collide when files are
installed into the LTP bin directory.

And it's usally better to split the patches to part that moves files and
part that does changes which is easier to review. But given that there
seems to be only one line change it may be okay. Do you know what has
been changed there? They look pretty much the same to me.

Othewise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
