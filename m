Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YFkwJ-0000nB-IZ
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 14:46:55 +0000
Date: Mon, 26 Jan 2015 15:45:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150126144556.GA27259@rei.suse.de>
References: <OF94742AD0.BF94A514-ON85257DD7.0024E1A8-85257DD7.00251AB6@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OF94742AD0.BF94A514-ON85257DD7.0024E1A8-85257DD7.00251AB6@us.ibm.com>
Subject: Re: [LTP] LTP: configure on LoZ node have these problems
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
To: Randy Brewster <randyab@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> configure: WARNING: linux/netlink.h: present but cannot be compiled
> configure: WARNING: linux/netlink.h:     check for missing prerequisite
> headers?
> configure: WARNING: linux/netlink.h: see the Autoconf documentation
> configure: WARNING: linux/netlink.h:     section "Present But Cannot Be
> Compiled"
> configure: WARNING: linux/netlink.h: proceeding with the compiler's result
> configure: WARNING:     ## --------------------------------------------- ##
> configure: WARNING:     ## Report this to ltp-list@lists.sourceforge.net ##
> configure: WARNING:     ## --------------------------------------------- ##

These are because the linux/socket.h lacks a sa_family_t definition.
Newer kernel-headers packages fixes that. The linux/socket.h defines
__kernel_sa_family_t which is used in netlink and can headers.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
