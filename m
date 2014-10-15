Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XeNVK-0002lr-6j
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 12:16:34 +0000
Date: Wed, 15 Oct 2014 14:16:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141015121612.GE5006@rei.suse.cz>
References: <c3a64332100498deedfb1b27b83545e42deb2d54.1389101980.git.jstancek@redhat.com>
	<7f26ec5fbdf900ddb77ec9a40debc5291498ab1b.1389101980.git.jstancek@redhat.com>
	<53F1A492.60108@oracle.com>
	<644993033.8297183.1408348159291.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <644993033.8297183.1408348159291.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 2/3] cpuset/cpuset_syscall_test: check
 HAVE_DECL_MPOL_F_MEMS_ALLOWED
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
> that looks like an oversight, which is there for couple years.
> 
> Commit below was supposed to restore that chunk to previous state,
> where it at least compiled. I agree that skip (of test15/16 by the first look)
> would be better.

Jan, can you please push a patch that fixes this?

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
