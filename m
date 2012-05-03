Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SPwdk-0002i4-PD
	for ltp-list@lists.sourceforge.net; Thu, 03 May 2012 14:04:16 +0000
Date: Thu, 3 May 2012 15:12:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120503131244.GB9999@saboteur.suse.cz>
References: <CAFkf=XoJnHYOZ3gVoyDjekjd3xp_YGQ==A7zvPqgMtgkdzzmnw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFkf=XoJnHYOZ3gVoyDjekjd3xp_YGQ==A7zvPqgMtgkdzzmnw@mail.gmail.com>
Subject: Re: [LTP] Test for linux syscall 240 cc sys_futex
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
To: Andreas Saebjoernsen <andreas@digitalplaywright.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
Sorry I'm not aware of any tests directly for futex systcall in LTP. I
guess that these are covered indirectly by glibc mutex and lock tests.

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
