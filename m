Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Oqgqh-0002mC-BG
	for ltp-list@lists.sourceforge.net; Wed, 01 Sep 2010 06:31:07 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oqgqd-0005FT-8m
	for ltp-list@lists.sourceforge.net; Wed, 01 Sep 2010 06:31:07 +0000
Received: by bwz12 with SMTP id 12so6517351bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 31 Aug 2010 23:30:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52CF90264091A14888078A031D780F430D093D@ism-mail03.corp.ad.wrs.com>
References: <4C7CDA7E.2020505@windriver.com>
	<52CF90264091A14888078A031D780F430D093D@ism-mail03.corp.ad.wrs.com>
Date: Tue, 31 Aug 2010 23:30:57 -0700
Message-ID: <AANLkTimHJjRYxkLSgr3kBQHD5Lu3=zwx0YR4PGX3KR01@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Probe an bigger linear available address to
	attachment.
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
To: "Yang, Wei" <Wei.Yang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

2010/8/31 Yang, Wei <Wei.Yang@windriver.com>:
> Hi
>
> When running shmat01 on some platforms, it fails on
> "addr = shmat(*(tc.shmid), base_addr + tc.offset,tc.flags);"
> with a INVAL error. Look at codes in "setup()", it probes
> an available address and align the address to SHMLBA. After
> alignment, the new address is no guarantee to be available
> any more. Here a bigger size is used to probe so that it's
> still valid address after alignment.Pertaining to the function
> setup_tc(lc, &tc) ,when it outside of "for (i = 0; i < TST_TOTAL;
> i++)",and printf the tc.offset value is always 0,add correct a mistake
> of original codes to move "setup_tc()" to right place.

Which of the sub-testcases fail and on which architecture(s)?
Thanks,
-Garrett

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
