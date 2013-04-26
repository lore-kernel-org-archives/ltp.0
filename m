Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <danyeal.ip@gmail.com>) id 1UW1bk-000828-95
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 09:39:52 +0000
Received: from mail-pa0-f65.google.com ([209.85.220.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UW1bj-0000Qm-JU
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 09:39:52 +0000
Received: by mail-pa0-f65.google.com with SMTP id bh4so3188999pad.8
	for <ltp-list@lists.sourceforge.net>;
	Sat, 27 Apr 2013 02:39:45 -0700 (PDT)
Message-ID: <517AAD94.1050507@gmail.com>
Date: Sat, 27 Apr 2013 00:38:44 +0800
From: DAN LI <danyeal.ip@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] syscalls/mount/mount02.c: modify array
	"exp_enos"
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
To: vapier@gentoo.org
Cc: ltp-list@lists.sourceforge.net

> >Expected errno setted in array "exp_enos" do not match
> >echo test item rightly, leading to two problems:
>
>what is "echo test item" ?

Sorry for this type error confused you ...

s/echo/each

Thanks,
DAN LI

>-mike


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
