Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QN3Kf-0004nH-NE
	for ltp-list@lists.sourceforge.net; Thu, 19 May 2011 13:32:05 +0000
Date: Thu, 19 May 2011 15:27:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110519132745.GC2333@saboteur.suse.cz>
References: <loom.20110518T201407-12@post.gmane.org>
	<BANLkTinmF0SyfJHRrmD+ox6wnUx6LOTvgg@mail.gmail.com>
	<BANLkTinAGsHbJQo8KiW20cWddfi3BG5Rvg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTinAGsHbJQo8KiW20cWddfi3BG5Rvg@mail.gmail.com>
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
To: Sandip Bhattacharya <sandipb@foss-community.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> BTW, for stable builds, do you have a tag or a commit number
> documented somewhere for the git commit used as the basis of the
> release? Right now whenever a test fails where it shouldn't, I am
> doing a whack-a-mole fix from the log of the file involved. If there
> is a git tag or commit number for the stable, I can look at all the
> commits from that time onwards to incorporate as patches into my srpm.

Adding tags to git for stable releases is IMHO good idea.

-- 
Cyril Hrubis
chrubis@suse.cz

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
