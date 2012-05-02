Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SPbnV-0005R6-Dr
	for ltp-list@lists.sourceforge.net; Wed, 02 May 2012 15:48:57 +0000
Date: Wed, 2 May 2012 17:47:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120502154707.GG366@saboteur.suse.cz>
References: <4F90D809.7050809@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F90D809.7050809@windriver.com>
Subject: Re: [LTP] Pls. help on POSIX test case mlockall/3-6 on MIPS
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The POSIX cases mlockall/3-6 3-7 fail on routerstation(arch MIPS), and 
> the OS is linux 3.0.24.
> It seems that after mlockall() that not all the share memories have been 
> set LOCK flag.
> Does anyone meet the question before or know what is the root cause?

Which version of LTP do you have and what is the exact output from these
testcases?

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
