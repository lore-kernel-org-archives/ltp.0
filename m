Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WT9yA-0005kO-1p
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:03:42 +0000
Date: Thu, 27 Mar 2014 14:03:10 +0100
From: chrubis@suse.cz
Message-ID: <20140327130309.GA4093@rei>
References: <531F0C71.2030209@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <531F0C71.2030209@oracle.com>
Subject: Re: [LTP] testscripts/ltpstress.sh and its log file
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> Is it made by intent that ltpstress.sh writes one single log file (by 
> default /tmp/ltpstress.log)?
> 
>  From the other side it uses a separate output file for each of ltp-pan 
> instances.
> 
> ltp-pan does not use any locking mechanism to coordinate writing to its 
> log/output files. So we may have problems here (concurrent writing from 
> different processes). Or not?

To be honest I have no idea, last functional change to the script was
done by Subrata in 2009 and I haven't even tried to run the script.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
