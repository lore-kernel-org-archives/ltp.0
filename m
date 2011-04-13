Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QA45f-0002HA-UH
	for ltp-list@lists.sourceforge.net; Wed, 13 Apr 2011 17:42:55 +0000
Date: Wed, 13 Apr 2011 20:07:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110413180708.GE3206@saboteur.suse.cz>
References: <4DA2D0F5.6020109@redhat.com>
	<BANLkTinr2n4cY9HO+x_EBsGv4UPcjVRMyg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTinr2n4cY9HO+x_EBsGv4UPcjVRMyg@mail.gmail.com>
Subject: Re: [LTP] hugeshmdt01: -I5 or -i5?
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
>     Good question. "How many iterations does it take to reproduce the
> problem?" is probably a good question to ask.

The source doesn't say that we should run this for several seconds. And
the test seems to be testing functionality rather than regression (also
there is no clear line between these two). But still I thik it's safe to
assume that this is a typo. Anybody any objections?

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
