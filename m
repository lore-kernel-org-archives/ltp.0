Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QAKM2-0001Vt-G0
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 11:04:54 +0000
Date: Thu, 14 Apr 2011 13:29:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110414112916.GA17067@saboteur.suse.cz>
References: <4DA2D0F5.6020109@redhat.com>
	<BANLkTinr2n4cY9HO+x_EBsGv4UPcjVRMyg@mail.gmail.com>
	<20110413180708.GE3206@saboteur.suse.cz>
	<BANLkTimdKXf8dg0VHHR4m5ySGBnyNK-fKA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTimdKXf8dg0VHHR4m5ySGBnyNK-fKA@mail.gmail.com>
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
> > The source doesn't say that we should run this for several seconds. And
> > the test seems to be testing functionality rather than regression (also
> > there is no clear line between these two). But still I thik it's safe to
> > assume that this is a typo. Anybody any objections?
> 
>     No, but I'd prefer is someone changed the 'typo', ran the test a
> few times in positive cases as opposed to blindly commit what someone
> considered a 'typo', and make the test ineffective.
>     Digging through the CVS/git commit email and/or the mail archives
> to determine what the contributor had in mind for the test would
> definitely help. The latter might be painful depending on the test
> submission though.

Okay, lets see what is in the logs.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
