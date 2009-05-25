Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M8h8S-0004wL-6h
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 20:51:04 +0000
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 7C8038726A
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 May 2009 22:50:10 +0200 (CEST)
Date: Mon, 25 May 2009 22:50:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090525205010.GA21081@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] list of test that needs autoconf checks
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

Hi,
I was trying to build ltp-20090430 on several different hardware and suse
flavours and following list of the tests is lacking autoconf checks for 
presence of functionality added recently into kernel/glibc:


testcases/kernel/controllers/cgroup/getdelays.c

Has missing not only freepages_count and freepages_delay_total as already 
mentioned in this list but also for kernel 2.6.22:

linux/cgroupstats.h: No such file or directory
'struct taskstats' has no member named 'nvcsw'
'struct taskstats' has no member named 'nivcsw'
'struct taskstats' has no member named 'read_bytes'
'struct taskstats' has no member named 'write_bytes'
'struct taskstats' has no member named 'cancelled_write_bytes'
'CGROUPSTATS_CMD_GET' undeclared (first use in this function)
'CGROUPSTATS_CMD_ATTR_FD' undeclared (first use in this function)
'CGROUPSTATS_TYPE_CGROUP_STATS' undeclared (first use in this function)


testcases/kernel/controllers/cgroup/test_6_2.c

clone() is missing on ia64 machines


testcases/kernel/syscalls/signalfd/signalfd01.c

sys/signalfd.h: No such file or directory (for glibc-2.4.31.54)


testcases/kernel/syscalls/splice/splice02.c

undefined reference to `splice' (from fcntl.h)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
