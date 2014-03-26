Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WSq13-0008QZ-UE
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 15:45:21 +0000
Date: Wed, 26 Mar 2014 16:44:54 +0100
From: chrubis@suse.cz
Message-ID: <20140326154454.GA11336@rei.Home>
References: <1394464444-23803-1-git-send-email-ciprian.barbu@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394464444-23803-1-git-send-email-ciprian.barbu@linaro.org>
Subject: Re: [LTP] [LNG][PATCH] Fix ltp realtime hrtimer-prio and
 measurement to pass default profile to run_c_files.sh
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
To: Ciprian Barbu <ciprian.barbu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, linaro-networking@linaro.org

Hi!
> Signed-off-by: Ciprian Barbu <ciprian.barbu@linaro.org>
> 
> Upstream-Status: Pending

Pushed with splitting the long line in the commit log.

The log should be in format:

short description

rest of the description that can span to several lines

Signed-off-by: ...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
