Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEbgQ-0004Hm-Hw
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 11:14:02 +0000
Date: Mon, 13 Jul 2015 13:12:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150713111232.GD2900@rei.suse.de>
References: <1436407199-12492-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20150713100728.GA2900@rei.suse.de>
	<1721921160.16296939.1436785318844.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1721921160.16296939.1436785318844.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/getrandom: remove reference to
 '<linux/random.h>'
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > What about moving the #include <linux/random.h> to start of
> > lapi/getrandom.h and including <linux/types.h> there as well if needed
> > (would require configure check).
> 
> Current man page for getrandom suggests including just <linux/random.h>,
> I'd stick with that, but verify it compiles with configure check.

Sounds good to me.

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
