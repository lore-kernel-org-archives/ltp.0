Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RiSHf-0002vO-Pn
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 14:57:43 +0000
Date: Wed, 4 Jan 2012 16:08:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120104150831.GI15845@saboteur.suse.cz>
References: <4F030192.8030107@imgtec.com>
	<201201031535.17342.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201201031535.17342.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 19/21] nfs/nfsstress/make_tree: Fix erroneous cast
 to void pointer
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>

Hi!
> NAK: this is how the pthread API works.  you aren't passing a value by 
> reference.  they used a pointer rather than "long" or something as it's harder 
> to fit a pointer into an integer rather than the other way around.
> 
> if you're getting a build time warning, try casting it to uintptr_t instead

Pretty much, you would pass a pointer to thread stack as a return value
with this patch which is wrong for several reasons (and the stackframe
woudn't most likely there when somebody else would touch this value).

The whole macro actually seems to be broken. It assigns local variable
thread_exit which is defined as volatile and it looks to me like
somebody had no clue how volatie works (at least at first sight).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
