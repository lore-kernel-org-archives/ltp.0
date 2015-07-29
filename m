Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZKTcd-0003Rx-3c
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 15:50:23 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZKTcc-0001Qg-02
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 15:50:23 +0000
Date: Wed, 29 Jul 2015 17:50:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150729155005.GC3427@rei.suse.de>
References: <CANKSX+HAqaZARVLcDWU3Uhv2CYDjSBrrq2H4OrkOSaY647saaA@mail.gmail.com>
	<20150729144508.GB3427@rei.suse.de>
	<CANKSX+ETp0jdXp+zSUtUPn8SWUQaCh1bETYzcpF_C8kZpPtGdQ@mail.gmail.com>
	<20150729152949.GA6478@rei.suse.de>
	<1186607709.563342.1438184803657.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1186607709.563342.1438184803657.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] LTP make failed
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
> One thing I noticed is that those libraries which failed were "INTERNAL_LIB".
> 
> Can you try this:
> 
> 1. cd $LTP/testcases/kernel/lib
> 2. edit Makefile and change this line:
>       INTERNAL_LIB            := libkerntest.a
> to:
>       LIB            := libkerntest.a
> 3. run make
> 
> Does that make any difference?

But these behave differently only on install target. For any other
target LIB is the same as INTERNAL_LIB.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
