Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZWlOq-0007dg-CR
	for ltp-list@lists.sourceforge.net; Tue, 01 Sep 2015 13:14:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZWlOk-0003O8-NF
	for ltp-list@lists.sourceforge.net; Tue, 01 Sep 2015 13:14:56 +0000
Date: Tue, 1 Sep 2015 15:14:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150901131410.GC27041@rei.suse.cz>
References: <20150813123035.GB14976@rei.suse.de>
	<20150820150617.GE3994@rei.suse.de>
	<20150831112319.GB17776@rei.suse.cz>
	<55E53DA4.6090005@cn.fujitsu.com>
	<20150901114230.GA27041@rei.suse.cz>
	<1488894521.16163428.1441112961686.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1488894521.16163428.1441112961686.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] LTP release
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net, jjaburek@redhat.com

Hi!
> another solution could be to let ns_ifmove.c as it is (so it won't build)
> and only add a check for binaries:
> tst_check_cmds ns_create ns_exec ns_ifmove

We would have to ingore the return value from the ns_ifmove build, which
means custom rule in the Makefile, which is ugly.

> to the netns test code. On the other hand, this will produce unclear
> output from the netns testcases, you will only know that ns_ifmove
> binary is unavailable, but won't know why.
> 
> The other way, as you pointed out, would be to check for kernel version
> and propagate TCONF to the netns_helper.sh. The patch which adds what we
> need ('IFLA_NET_NS_PID') to the kernel is:
> http://lists.linuxfoundation.org/pipermail/containers/2007-September/007113.html

Kernel version is completly orthogonal problem here.

The compilation fails since the IFLA_NET_NS_PID is not present in
linux/if_link.h. I've just finished a patch that adds autoconf check for
the constant, adds ifdefs into the ns_ifmove and propagates TCONF from
ns_ifmove to the helper. This may still fail if somebody runs the test
on recent enough userspace with older kernel. But I doubt that this will
be the case, at least for any released distribution.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
