Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UeONl-0000le-E4
	for ltp-list@lists.sourceforge.net; Mon, 20 May 2013 11:36:01 +0000
Date: Mon, 20 May 2013 13:37:05 +0200
From: chrubis@suse.cz
Message-ID: <20130520113704.GA19493@rei>
References: <001701ce5200$6bdfcdb0$439f6910$@lge.com>
	<6A7E2981-DEB3-4402-B0C8-7AE7FCD85236@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6A7E2981-DEB3-4402-B0C8-7AE7FCD85236@gmail.com>
Subject: Re: [LTP] Regarding LTP contribution
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP <ltp-list@lists.sourceforge.net>, Jungsoo Son <jungsoo.son@lge.com>

Hi!
> > My name is jungsoo son who is in charge of kernel development on my company.
> > I want to send my patch to upstream of Linux Test Project.
> > Could you give me some information about how to push git commit ?
> 
> Hi jungsoo son!
>     I recommend following up on ltp-list requesting these details. Also, these details should be updated in any documentation attached to the project (I think there's some IIRC).

There is quick howto at the end of doc/style-guide.txt but it's far from
complete (I really should get some time to review and update the docs).

Generally if you want to contribute to LTP send your patch to the LTP
malinling list for review. It will be pushed to LTP git once it passes
the review phase by one of our developers.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
