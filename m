Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UGB0y-0003IJ-9H
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:28:24 +0000
Date: Thu, 14 Mar 2013 17:29:02 +0100
From: chrubis@suse.cz
Message-ID: <20130314162901.GA8894@rei.suse.cz>
References: <1363183294-21203-1-git-send-email-markos.chandras@gmail.com>
	<1482749503.18144192.1363197480299.JavaMail.root@redhat.com>
	<CAG2jQ8h+u3Ade6ONcde=jBLSipJtF1vzP9q7zE-m3qX-LM1fKQ@mail.gmail.com>
	<20130313182323.GA4633@rei>
	<CAG2jQ8hbT_8h8KR0V2=7qzwdSy8cqzOWb_oHt4JJ5Y22yFEeDg@mail.gmail.com>
	<CAG2jQ8j23+74_JZbrkM55aKg4YG+V-g4G1+NsS4fLGy=efRDjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG2jQ8j23+74_JZbrkM55aKg4YG+V-g4G1+NsS4fLGy=efRDjQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH 1/2] syscalls/getdents: Use getdents64 if
 SYS_getdents is not defined
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
To: Markos Chandras <markos.chandras@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> 
> I wrote patch that does what we talked about.
> 
> https://github.com/hwoarang/ltp/commit/3e361757a9cfd6c6af50a395c2de68777356a4b6
> 
> If you are happy with the way it is implemented, I will post it to the
> mailing list for further review.

The patch looks realtive good, please send it to he ML for review.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
