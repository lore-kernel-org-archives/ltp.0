Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sandipb@foss-community.com>) id 1QMwwB-0001G2-KT
	for ltp-list@lists.sourceforge.net; Thu, 19 May 2011 06:42:23 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QMwwA-0003SP-T3
	for ltp-list@lists.sourceforge.net; Thu, 19 May 2011 06:42:23 +0000
Received: by pvc30 with SMTP id 30so1426370pvc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 May 2011 23:42:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTinmF0SyfJHRrmD+ox6wnUx6LOTvgg@mail.gmail.com>
References: <loom.20110518T201407-12@post.gmane.org>
	<BANLkTinmF0SyfJHRrmD+ox6wnUx6LOTvgg@mail.gmail.com>
Date: Thu, 19 May 2011 12:12:16 +0530
Message-ID: <BANLkTinAGsHbJQo8KiW20cWddfi3BG5Rvg@mail.gmail.com>
From: Sandip Bhattacharya <sandipb@foss-community.com>
Subject: Re: [LTP] LTP version in ChangeLog not updated?
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

Hi Garrett,

>
> Updating the ChangeLog is a manual procedure (shouldn't be, but it is).

It is not a major issue at all. Just that the HTML report for the
latest stable show the LTP version to be older than the stable build
date. That looks a little odd when I claim at work that we are using
the latest LTP stable. :-P

BTW, for stable builds, do you have a tag or a commit number
documented somewhere for the git commit used as the basis of the
release? Right now whenever a test fails where it shouldn't, I am
doing a whack-a-mole fix from the log of the file involved. If there
is a git tag or commit number for the stable, I can look at all the
commits from that time onwards to incorporate as patches into my srpm.

Thanks,
 Sandip

------------------------------------------------------------------------------
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its 
next-generation tools to help Windows* and Linux* C/C++ and Fortran 
developers boost performance applications - including clusters. 
http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
