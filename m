Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XMHAq-0001Xv-Mi
	for ltp-list@lists.sourceforge.net; Tue, 26 Aug 2014 13:52:36 +0000
Date: Tue, 26 Aug 2014 15:51:32 +0200
From: chrubis@suse.cz
Message-ID: <20140826135131.GA9525@rei>
References: <0be2f82a131d32b119748e91a840cb038bf82960.1409046964.git.jstancek@redhat.com>
	<20140826100642.GA27928@rei>
	<1144259951.13045166.1409048187591.JavaMail.zimbra@redhat.com>
	<20140826105516.GA28025@rei>
	<1485901937.13089374.1409051869026.JavaMail.zimbra@redhat.com>
	<20140826112410.GA3210@rei>
	<555448176.13093369.1409052507826.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <555448176.13093369.1409052507826.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] tst_ncpus_max: use kernel_max if available
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> Pushed - I'm not aware of any other outstanding issues for the release.

I've pushed last patch that I've been working on, the fix for the
kernel-devel configure check.

And looking at my set of results there is last unexpected failure for
read02 with /tmp on btrfs that fails to fail with O_DIRECT and unaligned
buffers/lengths. But that may be a btrfs bug. I will look into this
shortly and if no fix is found I would like to proceed with the release.

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
