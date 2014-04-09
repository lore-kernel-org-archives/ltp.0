Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXs02-0003DO-La
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 12:53:06 +0000
Date: Wed, 9 Apr 2014 14:52:22 +0200
From: chrubis@suse.cz
Message-ID: <20140409125222.GA22137@rei>
References: <1396526450-22885-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1397015193-18623-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<472091851.2162463.1397039648410.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <472091851.2162463.1397039648410.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v3] lib/tst_path_has_mnt_flags.c: create a
 function tst_path_has_mnt_flags()
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
> This function looks OK for one testcase that needs to check for
> OR logic between flags. I was thinking, whether we should change
> this function to return number matched flags. That way we could
> also check easily for AND logic (matches all flags) if we need
> that in future.

I was going to suggest this as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
