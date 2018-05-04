Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <metan@suse.de>) id 1fEbNv-0000bA-7g
 for ltp-list@lists.sourceforge.net; Fri, 04 May 2018 14:08:31 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1:ECDHE-RSA-AES256-SHA:256) (Exim 4.90_1) id 1fEbNt-008ZBV-7m
 for ltp-list@lists.sourceforge.net; Fri, 04 May 2018 14:08:31 +0000
Date: Fri, 4 May 2018 16:06:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20180504140622.GC7653@rei>
References: <20180503114252.12548-1-jack@suse.cz>
 <CAOQ4uxgQK9HtojVteoQNJfaP5qVX67HxmHoQ-XKLtjaTq4==Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgQK9HtojVteoQNJfaP5qVX67HxmHoQ-XKLtjaTq4==Lg@mail.gmail.com>
Subject: Re: [LTP] [PATCH] inotify07: Add test for kernel crash during event
 notification
List-Id: Linux Test Project General Discussions
 <ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ltp-list>,
 <mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
 <mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Amir Goldstein <amir73il@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Jan Kara <jack@suse.cz>

Hi!
> inotify07 and inotify08 have already been merged to master
> and FYI already "posted" inotify09:
> https://github.com/linux-test-project/ltp/pull/260
> 
> BTW, Cyril, do you have a preference between github pull request
> and posting the patch to the list?
> I suppose I should have posted to fsdevel and CC Jan anyway...

I do prefer mailing list over pull requests but I work with both.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
