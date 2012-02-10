Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rvp7P-0001uR-1F
	for ltp-list@lists.sourceforge.net; Fri, 10 Feb 2012 11:58:23 +0000
Date: Fri, 10 Feb 2012 13:12:20 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120210121220.GA30338@saboteur.suse.cz>
References: <4F262804.9020508@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F262804.9020508@linux.vnet.ibm.com>
Subject: Re: [LTP] Filecaps tests not getting built along with ltp
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
To: Athira <atrajeev@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
I've commited a patch by Peng Haitao <penght@cn.fujitsu.com>

http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp.git;a=commit;h=3a4db087329c7b46ded96e4b58479a5591720ce7

Please check if that fixes these problems.

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
