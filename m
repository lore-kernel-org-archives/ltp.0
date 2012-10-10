Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TLw51-0007EJ-Lt
	for ltp-list@lists.sourceforge.net; Wed, 10 Oct 2012 13:12:07 +0000
Date: Wed, 10 Oct 2012 15:09:52 +0200
From: chrubis@suse.cz
Message-ID: <20121010130952.GB2853@rei.suse.cz>
References: <20121003114039.GC22986@saboteur.suse.cz>
	<564795434.6124572.1349265888804.JavaMail.root@redhat.com>
	<20121003123250.GA8435@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121003123250.GA8435@rei>
Subject: Re: [LTP] Test case send01 fails in kernel version 3.6-rc1,
 rc2 and rc3
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
Cc: shyju pv <shyju.pv@huawei.com>, ltp-list@lists.sourceforge.net

Hi!
> Okay then I will prepare patch. Stay tuned.

I've just pushed patch to fix this (tested on 3.6.1).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
