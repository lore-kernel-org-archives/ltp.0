Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uu15E-0004nZ-SW
	for ltp-list@lists.sourceforge.net; Tue, 02 Jul 2013 13:57:28 +0000
Date: Tue, 2 Jul 2013 15:59:01 +0200
From: chrubis@suse.cz
Message-ID: <20130702135901.GA6555@rei.suse.cz>
References: <51D23341.1060000@cn.fujitsu.com>
	<428972040.2573228.1372770337971.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <428972040.2573228.1372770337971.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH v3] mmap/mmap14.c: new case to test MAP_LOCKED of
 mmap
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> > Create test case for MAP_LOCKED of mmap.
> > 
> > Verify pages are locked by checking section "VmLck" of /proc/<pid>/status.
> > 
> > 
> > Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> 
> Reviewed-by: Jan Stancek <jstancek@redhat.com>
> 
> Looks good to me. You could probably remove some of those includes, but
> that's just minor nit.

Heh, it turned out that the only needed (among ltp test includes) are
stdio.h and sys/mman.h. Pushed with this change, thanks all involved.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
