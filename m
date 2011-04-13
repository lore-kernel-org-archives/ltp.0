Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q9yR4-00014a-UU
	for ltp-list@lists.sourceforge.net; Wed, 13 Apr 2011 11:40:38 +0000
Date: Wed, 13 Apr 2011 14:04:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110413120452.GA3206@saboteur.suse.cz>
References: <1302546720.2580.29.camel@doink>
	<BANLkTimqaMit_JMGLvDJFzsoJZMQhf0JSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTimqaMit_JMGLvDJFzsoJZMQhf0JSQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH 3/3, v2] ltp: fix warnings in "fsstress.c"
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
> 1. Please use sizeof() instead of bareword sizeof.
> 2. I'm not sure if this is necessarily LKML style (the code I've
> sampled in the mainline kernel do this however), but casts don't
> require spurious spaces in FreeBSD for instance, i.e.
> 
>     foo = (void*)bar;
> 
> instead of
> 
>     foo = (void*) bar;

Agreed, while it's not written explicitly it seems to be common sense.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
