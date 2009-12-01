Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NFPhy-0004Z8-Nv
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 10:11:46 +0000
Received: from mail-pz0-f184.google.com ([209.85.222.184])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFPht-00034U-QE
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 10:11:46 +0000
MIME-Version: 1.0
In-Reply-To: <200911251309.22834.vapier@gentoo.org>
References: <1259156195-13056-1-git-send-email-avagin@gmail.com>
	<200911251309.22834.vapier@gentoo.org>
Date: Tue, 1 Dec 2009 02:11:35 -0800
Message-ID: <364299f40912010211y71d5a426w91ded155c78fb5db@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] tst_res: save errno at the begin,
	otherwise it may 	be rewritten
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sf.net

On Wed, Nov 25, 2009 at 10:09 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 25 November 2009 08:36:35 Andrew Vagin wrote:
>> it may do fprinf for example.
>
> it seems a little paranoid, but i dont see any harm in the change

Committed -- thanks!
-Garrett

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
