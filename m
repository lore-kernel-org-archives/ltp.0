Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1ScGkM-0005Pw-3p
	for ltp-list@lists.sourceforge.net; Wed, 06 Jun 2012 13:58:02 +0000
Date: Wed, 6 Jun 2012 15:56:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120606135647.GA20162@saboteur.suse.cz>
References: <4FCF4CFC.2010100@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FCF4CFC.2010100@redhat.com>
Subject: Re: [LTP] [PATCH v2] dio_sparse: prevent race between kill and
 signal
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
> This is same change as in:
>   commit d8f1292181b486b2073cc6fe1ec226f5cedea342
>   Author: Cyril Hrubis <chrubis@suse.cz>
>   Date:   Fri Mar 2 13:37:47 2012 +0100
>       ltp-aiodio: aiodio_sparse fix race condition
> 
> but for dio_sparse.c, which is also prone to race
> between kill() and signal().

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
