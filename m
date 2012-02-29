Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S2mHY-00069O-SO
	for ltp-list@lists.sourceforge.net; Wed, 29 Feb 2012 16:21:36 +0000
Date: Wed, 29 Feb 2012 17:22:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120229162236.GA29987@saboteur.suse.cz>
References: <loom.20120228T103647-261@post.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <loom.20120228T103647-261@post.gmane.org>
Subject: Re: [LTP] Need help in cross compiling LTP for android
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
To: rejish <rejish.rajagopala@sasken.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> With the above variables am able to cross compile LTP. 
> 
> But after pushing the cross compiled make file, cross compiled busybox and 
> cross compiled bash4.1 to target, am not able to execute runltp.
> 
> I am getting the below error :
> Running tests.......
> /data/ltp/make_2802_02_2012/bin/ltp-pan: Illegal number:

That is strange error indeed and frankly I have no idea where it came
from. There is no 'Illegal number' substring in LTP source code itself,
so it's possible this message came either from bash or libc.

What about adding -x into runltp shebang, the trace could help to
identify what wen't wrong.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
