Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1QMlM4-00037u-Jx
	for ltp-list@lists.sourceforge.net; Wed, 18 May 2011 18:20:20 +0000
Received: from lo.gmane.org ([80.91.229.12])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QMlM2-0001IT-9Z
	for ltp-list@lists.sourceforge.net; Wed, 18 May 2011 18:20:20 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1QMlLp-00067O-Ur
	for ltp-list@lists.sourceforge.net; Wed, 18 May 2011 20:20:06 +0200
Received: from vpnnat.eglbp.corp.yahoo.com ([203.83.248.37])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Wed, 18 May 2011 20:20:05 +0200
Received: from sandipb by vpnnat.eglbp.corp.yahoo.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Wed, 18 May 2011 20:20:05 +0200
From: Sandip Bhattacharya <sandipb@foss-community.com>
Date: Wed, 18 May 2011 18:16:33 +0000 (UTC)
Message-ID: <loom.20110518T201407-12@post.gmane.org>
Mime-Version: 1.0
Subject: [LTP] LTP version in ChangeLog not updated?
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

I just cloned the LTP git repo from SF and ran the suite. Strangely, the report 
showed the LTP version to be an old one. Is something amiss?


$ git log -1
commit 61ac0eaf2a3f24378ed0ab20a1613134ab83843a
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Wed May 11 17:08:32 2011 +0200

    Add newline to include/cleanup.c to stop GCC from whining.
    
    Signed-off-by: Cyril Hrubis <chrubis@suse.cz>


$ head ChangeLog 
LTP-20100831

commit dd59d49d75598d163f1b4599067a9f0dcb70e6c4
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Tue Aug 31 23:09:49 2010 -0700

    The cacheflush system call does not return EINVAL in the latest Linux
    kernel. see the link:
    A related patch about the cacheflush function:
    http://lkml.org/lkml/2009/4/9/203

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
