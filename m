Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEzze-0007yu-Pb
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 13:11:30 +0000
Date: Tue, 14 Jul 2015 15:09:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150714130958.GB7040@rei.suse.de>
References: <1436876572-28759-1-git-send-email-mmarhefk@redhat.com>
	<1436876572-28759-2-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436876572-28759-2-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH 2/2] containers/netns tests rewritten
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -23,15 +23,24 @@ mqns_03_clone mqns_03 -clone
>  mqns_04 mqns_04
>  mqns_04_clone mqns_04 -clone
>  
> -netns_crtchild netns_crtchild
> -netns_two_children_ns netns_two_children_ns
> -netns_crtchild_delchild netns_crtchild_delchild
> -netns_par_chld_ipv6 netns_par_chld_ipv6
> -netns_par_chld_ftp netns_par_chld_ftp.sh
>  netns_netlink netns_netlink
> -netns_devices netns_devices.sh
> -netns_devices2 netns_devices2.sh
> -netns_isolation netns_isolation.sh
> +netns_breakns netns_breakns.sh ns_exec ipv4 netlink
> +netns_breakns netns_breakns.sh ns_exec ipv6 netlink
> +netns_breakns netns_breakns.sh ns_exec ipv4 ioctl
> +netns_breakns netns_breakns.sh ns_exec ipv6 ioctl
> +netns_breakns netns_breakns.sh ip ipv4 netlink
> +netns_breakns netns_breakns.sh ip ipv6 netlink
> +netns_breakns netns_breakns.sh ip ipv4 ioctl
> +netns_breakns netns_breakns.sh ip ipv6 ioctl
> +netns_comm netns_comm.sh ns_exec ipv4 netlink
> +netns_comm netns_comm.sh ns_exec ipv6 netlink
> +netns_comm netns_comm.sh ns_exec ipv4 ioctl
> +netns_comm netns_comm.sh ns_exec ipv6 ioctl
> +netns_comm netns_comm.sh ip ipv4 netlink
> +netns_comm netns_comm.sh ip ipv6 netlink
> +netns_comm netns_comm.sh ip ipv4 ioctl
> +netns_comm netns_comm.sh ip ipv6 ioctl
> +netns_sysfs netns_sysfs.sh

This would create several testcases with exactly same name in LTP
results, wouldn't it.

Can we also somehow include what is utilized, i.e. something from the
parameters passed to the test script in the testcase name?

Something as:

netns_comm_exec_v4_ioctl
netns_comm_exec_v6_ioctl

I know that the names gets too long, but it's far better than having to
figure out which combination of pamaters is actually failing.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
