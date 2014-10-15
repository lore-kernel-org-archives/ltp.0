Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XeN1r-0001MP-HE
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 11:46:07 +0000
Date: Wed, 15 Oct 2014 13:45:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141015114546.GC5006@rei.suse.cz>
References: <1407405010-23077-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<2144922040.6431142.1407925292759.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2144922040.6431142.1407925292759.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] run_memctl_test.sh: replace the former
	intercept	method
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
> I'm OK with using awk, though commit message could be more clear.
> 
> Reviewed-by: Jan Stancek <jstancek@redhat.com>

I've updated the commit message and pushed the patch, thanks to both of
you.

PS: Jan you should have pushed this patch allready.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
