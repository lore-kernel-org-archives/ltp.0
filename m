Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rv7dj-0005X5-II
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 13:32:51 +0000
Date: Wed, 8 Feb 2012 14:46:44 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120208134644.GD17568@saboteur.suse.cz>
References: <1328673253-23856-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F320A18.9020308@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F320A18.9020308@casparzhang.com>
Subject: Re: [LTP] [PATCH v2 0/4] hugemmap: auto mount the temporary dir
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> Hi, I want to know the test status of your patches before we commit the
> changes, after that, you can reply with adding a `Tested-by` line. Also,
> I'd like to know Cyril's comments to this version of patchset.

Looks reasonable.

> Cyril, I'm not sure which is the best place to put such wrapper
> functions like string_to_long() I mentioned in previous mail, any ideas?

See reply to previous mail ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
