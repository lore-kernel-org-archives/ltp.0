Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WUwPm-0001Jz-4A
	for ltp-list@lists.sourceforge.net; Tue, 01 Apr 2014 10:59:34 +0000
Date: Tue, 1 Apr 2014 12:58:56 +0200
From: chrubis@suse.cz
Message-ID: <20140401105856.GA12474@rei.suse.cz>
References: <20140331160325.GB9911@rei.suse.cz> <533A5F9C.6000907@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <533A5F9C.6000907@oracle.com>
Subject: Re: [LTP] LTP Release
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Looking at the pending patches there are at least two patches that
> > should be sorted out. The out-of-tree build and the bashism in
> > testcases. I will make sure these two issues are handled soon.
> >
> > Are there any other patches that should be part of the next release?
> >
> Could you please look at the TCP Fast Open patch, I've recently sent 
> version 7 <http://sourceforge.net/p/ltp/mailman/message/32147204/> where 
> I moved some of the common code to the shell library: "lib/test_net.sh: 
> add network help script 
> <http://sourceforge.net/p/ltp/mailman/message/32141161/>". The last one 
> is the stopper for vxlan test as well.

Noted, I will look into these two as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
