Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZUy98-0005aa-Tx
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2015 14:27:18 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZUy96-0006ol-Qp
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2015 14:27:18 +0000
Date: Thu, 27 Aug 2015 16:26:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150827142634.GC28831@rei.suse.cz>
References: <1436876572-28759-1-git-send-email-mmarhefk@redhat.com>
	<1439899089-7601-1-git-send-email-mmarhefk@redhat.com>
	<20150826150521.GA19278@rei.suse.de>
	<20150827115542.GA27851@rei.suse.cz> <55DF1280.5080300@redhat.com>
	<20150827134749.GA28831@rei.suse.cz> <55DF19FC.3030501@redhat.com>
	<20150827141335.GB28831@rei.suse.cz> <55DF1D60.8090702@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55DF1D60.8090702@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 v3] added helper tools for creating and
 working with namespaces
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> ./ns_exec 1234 mnt pid uts ls /
> 
> seems a bit confusing to me. Maybe use just $2 and comma-separate the
> names? (Also for ns_create, for consistency.)
>
> pid=$(./ns_create pid,mnt,uts,net)
> ./ns_exec $pid mnt,pid ls /

That's a bit harder to parse but you have the point.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
