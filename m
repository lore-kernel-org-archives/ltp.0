Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Otrpg-0005NI-Jr
	for ltp-list@lists.sourceforge.net; Fri, 10 Sep 2010 00:51:12 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Otrpf-0000nQ-Qs
	for ltp-list@lists.sourceforge.net; Fri, 10 Sep 2010 00:51:12 +0000
Received: by yxg6 with SMTP id 6so503925yxg.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Sep 2010 17:51:06 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1081)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <AANLkTi=ufkOGaSbHpXfwC3sxCw8VwV+5-=ucGcDV8330@mail.gmail.com>
Date: Thu, 9 Sep 2010 17:51:01 -0700
Message-Id: <F0FA14BB-292E-4F75-9B7D-DD327C631007@gmail.com>
References: <AANLkTi=ufkOGaSbHpXfwC3sxCw8VwV+5-=ucGcDV8330@mail.gmail.com>
Subject: Re: [LTP] wrong description in LTP HowTo section: 3.3 Compiling the
	test suite
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
To: shenghui <crosslonelyover@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Sep 9, 2010, at 4:52 PM, shenghui wrote:

> Hi,
> 
> I followed the description in LTP HowTo 3.3 section
>               http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3.3
> to install LTP, and found that some description is wrong:
> 
> "This will create symbolic links of the executable to corresponding
> files in ltp-yyyymmdd/ test-cases/bin directory."
> 
> I checked the executables under [install_dir]/testcases/bin, and
> noticed that they are all executables, not symbolic links. I think
> we'd better correct the description.

	Yeah, the documentation really needs cleanup. I need to do a single pass over it because I was the dude that worked on the system last :).
	The original setup was actually hardlinks though, and not symlinks, so I think the documentation has been incorrect for a while now..
Thanks for the heads up!
-Garrett
------------------------------------------------------------------------------
Automate Storage Tiering Simply
Optimize IT performance and efficiency through flexible, powerful, 
automated storage tiering capabilities. View this brief to learn how
you can reduce costs and improve performance. 
http://p.sf.net/sfu/dell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
