Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vinson@twopensource.com>) id 1YVqtk-0005nT-Tv
	for ltp-list@lists.sourceforge.net; Thu, 12 Mar 2015 00:22:48 +0000
Received: from mail-ob0-f176.google.com ([209.85.214.176])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YVqtj-0007oh-UV
	for ltp-list@lists.sourceforge.net; Thu, 12 Mar 2015 00:22:48 +0000
Received: by obcwp18 with SMTP id wp18so12669583obc.1
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Mar 2015 17:22:42 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 Mar 2015 16:53:02 -0700
Message-ID: <CAHTgTXUTmdb=JWZmgEyi6SyAWEgiqN-UFF4VnGEpp_DK+n0EaQ@mail.gmail.com>
From: Vinson Lee <vlee@twopensource.com>
Subject: [LTP] TCONF results appearing in FAILCMDFILE logs
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
To: ltp-list@lists.sourceforge.net

Hi.

I'm seeing several testcases with a TCONF result end up in the
FAILCMDFILE log file. This makes triaging actual failures more
difficult. Should TCONF results not be placed in FAILCMDFILE?

As an example, adjtimer02 has a TCONF on recent upstream kernels.

Cheers,
Vinson

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
