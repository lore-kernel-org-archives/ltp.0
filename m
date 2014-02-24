Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WHv8p-0005PP-MH
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 13:00:15 +0000
Date: Mon, 24 Feb 2014 14:00:02 +0100
From: chrubis@suse.cz
Message-ID: <20140224130002.GB23791@rei>
References: <462077908.7898377.1393243192528.JavaMail.zimbra@redhat.com>
	<1264301891.7910240.1393244817542.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1264301891.7910240.1393244817542.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] make -j64 failure while building ltp-20140115
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
Cc: ltp-list <ltp-list@lists.sf.net>

Hi!
> I ran into build failure (see below) with ltp-20140115. This happened only once and all
> my attempts to recreate it failed. LTP is run as part of automated testing across
> multiple systems/architectures, where each system starts from clean installation.
> 
> It looks like that build process should continue with:
>   /mnt/tests/kernel/RHEL6/ltp-lite/ltp-full-20140115/testcases/network/rpc/basic_tests/rpc01/datafiles
> but instead for some reason it jumped to root directory:
>   make[7]: Entering directory `/'

Hmm, that looks really strange. One posibility is that '/' somehow made
it into SUBDIRS variable (that would be the get_make_dirs function in
include/mk/functions.mk). But unless we are able to reproduce the issue
the chances to figure out what happened are pretty small.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
