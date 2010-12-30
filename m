Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PYEOP-0006EZ-9F
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 09:01:53 +0000
Date: Thu, 30 Dec 2010 10:17:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101230091715.GA14045@saboteur.suse.cz>
References: <4D195645.1050902@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D195645.1050902@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]Remove redundance code.
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> It's incorrect to close a file twice, so remove the redundance code.
> 
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

Good catch ;).

It seems like this broke in Garrett's style commit.

And there are more. The uid_t and gid_t is unsigned so (uid_t)-1 is the
only way how to pass -1 to lchown() without warning. That's even said in
POSIX documentation.

Garrett please remove the first one close() and add back the (uid_t) and
(gid_t). Also the tst_brkm() messages in lchown01 got a little
unconsistent after this merge.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
