Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Pzuc4-0002Ni-8o
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 17:34:24 +0000
Date: Wed, 16 Mar 2011 18:56:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110316175619.GB11728@saboteur.suse.cz>
References: <1300290346-26901-1-git-send-email-czhang@redhat.com>
	<AANLkTi=FoS-qWsvxH0YegaLfywCrOqfvNOS1bpCMW+aY@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=FoS-qWsvxH0YegaLfywCrOqfvNOS1bpCMW+aY@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2 2/2] fs: fsstress: fix compile when -DNO_XFS
 disabled
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>     Once upon a time I assume this worked for someone when compiling
> on legacy systems. Please add any and all necessary autoconf tests for
> these headers.

I've commited the patch as it is a couple of minutes ago as you may say
it's improvement to the previous state. However that it doesn't compile
here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
