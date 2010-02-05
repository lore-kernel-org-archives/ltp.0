Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NdQtl-0003sn-5e
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 16:19:13 +0000
Received: from mail-pz0-f173.google.com ([209.85.222.173])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NdQti-0002tk-QD
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 16:19:13 +0000
Received: by pzk3 with SMTP id 3so1067219pzk.5
	for <ltp-list@lists.sourceforge.net>;
	Fri, 05 Feb 2010 08:19:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000701caa62c$4971b140$dc5513c0$@co.jp>
References: <000701caa62c$4971b140$dc5513c0$@co.jp>
Date: Fri, 5 Feb 2010 08:19:04 -0800
Message-ID: <364299f41002050819q7676973k47867cbf9ecf488a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "stime01" problem
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Thu, Feb 4, 2010 at 10:27 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I noticed that "stime01" test let system-clock be faster than right time.
>
> "stime01.c" is going to set system-clock by calling "stime()" function
> with "new_time" variable.
> It gets "curr_time" by "time()" function, and sets "curr_time + 10sec"
> in "new_time".
> But after the test, It doesn't restore system-clock.
>
> Therefore, system-clock is set faster than right time about 10 seconds
> after "stime01" test.
> If this test is repeated many times, the system-clock advances for the
> number of test times.
> And, if system is rebooted, hardware-clock will be wrong.
>
> How about following patch?

    The patch looks good, but I assume (and hope) that cleanup gets
executed every time before the program exits?
Thanks,
-Garrett

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
