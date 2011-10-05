Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RBTeB-00066q-L9
	for ltp-list@lists.sourceforge.net; Wed, 05 Oct 2011 15:44:39 +0000
Date: Wed, 5 Oct 2011 17:47:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111005154734.GF26968@saboteur.suse.cz>
References: <1317385970-4899-1-git-send-email-mad_soft@inbox.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1317385970-4899-1-git-send-email-mad_soft@inbox.ru>
Subject: Re: [LTP] [PATCH] fs/proc01: namespaces fix for kernel >= 3.0
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
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Add exclusion for /proc/self/.../ns/{net,uts,ipc} files introduced
> in kernel 3.0. These files aren't meant to be read and merely
> used for getting filedescriptor as a handle to corresponding namespace.
> Any file operation on them including read() returns -EINVAL.
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
