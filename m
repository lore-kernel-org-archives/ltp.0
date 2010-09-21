Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Oxuyk-0008MR-V0
	for ltp-list@lists.sourceforge.net; Tue, 21 Sep 2010 05:01:18 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oxuyk-0003Pa-76
	for ltp-list@lists.sourceforge.net; Tue, 21 Sep 2010 05:01:18 +0000
Received: by yxg6 with SMTP id 6so2092260yxg.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Sep 2010 22:01:13 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 20 Sep 2010 22:01:12 -0700
Message-ID: <AANLkTimKw8yZyXbzoWqTXx4A=bWab7EHD7Axqu+FnKjO@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] ltp-dev.git is being moved to ltp.git
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
To: LTP list <ltp-list@lists.sourceforge.net>

    So, finally got the SF folks to help us fix some stuff and now all
of the ltp-dev.git content has been pushed out to ltp.git . I'm
letting people know in advance because no more commits *should* go to
ltp-dev.git from here on out, and after a few weeks the ltp-dev.git
repository is going to be removed.
    This transition was warranted by the fact that when Rishi and I
first setup the git repository we screwed up and in order to `get
things to work' Rishi used ltp-dev.git, which is unfortunately
confusing to newcomers because the directions state ltp.git, not
ltp-dev.git up on the SF site.
    Anyhow, sorry for the transition, but it's for the best.
Thanks,
-Garrett

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
