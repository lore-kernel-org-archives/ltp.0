Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VgZqJ-0000wc-0S
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 12:46:47 +0000
Date: Wed, 13 Nov 2013 13:46:31 +0100
From: chrubis@suse.cz
Message-ID: <20131113124631.GA12390@rei.Home>
References: <1383899857-4669-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383899857-4669-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] setregid02: invalid user value fix
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Commit 705926d096f7a64c9d53efeb789288e25457d68f
> introduced a bug that the value for inval_user was treated
> as '-1' when passed to 16-bit version of setregid().
> 
> Fixed it the same way as it's done for setreuid test cases.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
