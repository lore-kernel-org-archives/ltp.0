Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TO49G-00039C-Gc
	for ltp-list@lists.sourceforge.net; Tue, 16 Oct 2012 10:13:18 +0000
Date: Tue, 16 Oct 2012 12:11:01 +0200
From: chrubis@suse.cz
Message-ID: <20121016101101.GB9320@rei.Home>
References: <507CC6F5.3090409@cn.fujitsu.com>
	<82432993.665989.1350370438315.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <82432993.665989.1350370438315.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] io_submit: uninitialized iocb may not
	return	-EINVAL
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
Cc: ltp-list@lists.sourceforge.net, Nitin Yadav <Nitin.Yadav@mphasis.com>

Hi!
> Notice that return value is positive (1). So it could be that some random data
> succeeded and one iocb was actually submitted.

Well I think that if you pass random data to the kernel the only
assumption that may hold is that this action should not bring the system
down (unless of course you happen to initiate shutdown).

From this point of view calling libcalls/syscalls with random values and
asserting certain results makes a little sense.

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
