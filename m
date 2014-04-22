Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WcZhe-0004DK-El
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 12:21:36 +0000
Date: Tue, 22 Apr 2014 14:20:41 +0200
From: chrubis@suse.cz
Message-ID: <20140422122041.GB3951@rei>
References: <534FA1A9.10902@oracle.com> <20140417125003.GA949@rei>
	<53510E46.4090907@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53510E46.4090907@oracle.com>
Subject: Re: [LTP] [PATCH v3] containers/netns:parameters are not correct
 when calling, crtchild() function
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
To: Shuang Qiu <shuang.qiu@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The numbers of parameters for crtchild() function which called in
> two_children_ns.c and par_chld_ipv6.c is not correct.And it will make
> the child process to be a zombie process.
> And also move the definition of the function to the header file(common.h)


> +#ifndef _COMMON_H_
> +#define _COMMON_H_

Identifiers starting with double underscore or with underscore and
capital letter are reserved for glibc implementation. We should use
something as COMMON_H or COMMON_H__ to be sure not to collide. But this
is very minor.


Apart from this the patch has been corrupted, most likely line wrapped
by your mail client. Have a look at:

https://www.kernel.org/doc/Documentation/email-clients.txt

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
