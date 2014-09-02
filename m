Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XOni4-0004Fp-5s
	for ltp-list@lists.sourceforge.net; Tue, 02 Sep 2014 13:01:20 +0000
Date: Tue, 2 Sep 2014 15:01:08 +0200
From: chrubis@suse.cz
Message-ID: <20140902130108.GA7361@rei.suse.cz>
References: <1400502716-8969-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1404291667-13198-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1404291667-13198-2-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1404291667-13198-2-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 2/2] hotplug/cpu_hotplug: add it to run default
 and cleanup
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

Pushed without the addition to the scenario_groups/default.

On single cpu machine most of the testcases fails with:

cpuhotplug05 1 TBROK : CPU1 not found

or with:

cat: /sys/devices/system/cpu/cpu1/online: No such file or directory
/opt/ltp/testcases/bin/cpuhotplug_hotplug.sh: line 198: [: =: unary
operator exp
cpuhotplug07 1 TBROK : CPU1 cannot be onlined

The testcases should exit properly with TCONF in this case. I know that
single cpu machines are not that common today, but we should we should
work correctly even on these. Let's add it to the default run once this
is fixed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
