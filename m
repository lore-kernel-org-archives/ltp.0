Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdhLi-0000bd-FA
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 12:02:14 +0000
Date: Thu, 22 Dec 2011 13:11:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222121153.GD26303@saboteur.suse.cz>
References: <1324543794-28128-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324543794-28128-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] syscalls/getrusage03: fix option parsing
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> On powerpc platform, getrusage03_child returns the following error
> message:
> 
> getrusage03_child    1  TBROK  :  OPTION PARSING ERROR - parse_opts: ERROR - Only short options are allowed
> 
> This is because child_options[] didn't end up with a NULL array. This
> patch fixes this problem.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
