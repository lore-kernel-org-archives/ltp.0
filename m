Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q9XHB-0000XL-Gf
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:40:37 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q9XH8-00079h-QC
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:40:35 +0000
Received: by pzk35 with SMTP id 35so3367881pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Apr 2011 23:40:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DA2D0F5.6020109@redhat.com>
References: <4DA2D0F5.6020109@redhat.com>
Date: Mon, 11 Apr 2011 23:40:28 -0700
Message-ID: <BANLkTinr2n4cY9HO+x_EBsGv4UPcjVRMyg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

2011/4/11 Caspar Zhang <czhang@redhat.com>:
> The hugeshm* tests in runtest/hugetlb are:
>
> hugeshmat01 hugeshmat01 -i 5
> hugeshmat02 hugeshmat02 -i 5
> hugeshmat03 hugeshmat03 -i 5
>
> hugeshmctl01 hugeshmctl01 -i 5
> hugeshmctl02 hugeshmctl02 -i 5
> hugeshmctl03 hugeshmctl03 -i 5
>
> hugeshmdt01 hugeshmdt01 -I 5 <--- *-I or -i?*
>
> hugeshmget01 hugeshmget01 -i 10
> hugeshmget02 hugeshmget02 -i 10
> hugeshmget03 hugeshmget03 -i 10
> hugeshmget05 hugeshmget05 -i 10
>
> I wonder whether hugeshmdt01 should be repeated for 5 times, or 5
> seconds? (5 seconds is enough to execute the test for thousands times...
> That will produce tens ~ hundreds MB log)

    Good question. "How many iterations does it take to reproduce the
problem?" is probably a good question to ask.
Cheers,
-Garrett

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
