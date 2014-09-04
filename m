Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XPUJE-0004rW-8g
	for ltp-list@lists.sourceforge.net; Thu, 04 Sep 2014 10:30:32 +0000
Date: Thu, 4 Sep 2014 12:30:19 +0200
From: chrubis@suse.cz
Message-ID: <20140904103019.GB3151@rei.suse.cz>
References: <1409672758-32402-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409672758-32402-1-git-send-email-zlang@redhat.com>
Subject: Re: [LTP] [PATCH 2/2] [PATCH-V2]fs/fsstress: prevent orphan and
 zombie processes to be left
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
To: Zorro Lang <zlang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> parent use signal handler to deal with SIGTERM, make sure children processes
> will be over before parent.
> command "killall fsstress; wait;" can be used with this patch.

This patch seems to be verbatim copy of the fix included in the xfstests
repository. You should at least mention the original authors in the
commit message here.

And the commit message for the original patch is better as well...

I'm all for getting back the fixes from xfstests but taking the patch
and not giving credit to the original authors is plain wrong.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
