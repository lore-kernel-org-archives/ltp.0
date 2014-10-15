Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XeNOf-0001vw-0f
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 12:09:41 +0000
Date: Wed, 15 Oct 2014 14:09:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141015120919.GD5006@rei.suse.cz>
References: <f50955452e5249cdb57eb4e62c5688fc9dd0bccf.1413367105.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f50955452e5249cdb57eb4e62c5688fc9dd0bccf.1413367105.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 v4] add LTP_DATAROOT and tst_dataroot()
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
> LTP_DATAROOT (test.sh) and tst_dataroot (libltp) define directory
> which holds test data files.
> 
> If LTPROOT is defined, it is $LTPROOT/testcases/data/$TCID
> otherwise it's $CWD/datafiles (where CWD is current working
> directory, before any call to tst_tmdir())

Both patches acked.

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
