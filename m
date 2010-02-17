Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NhnOR-0003hB-2X
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:08:55 +0000
Received: from mail-pz0-f187.google.com ([209.85.222.187])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NhnOP-0007Aw-MQ
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:08:54 +0000
Received: by pzk17 with SMTP id 17so6512213pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Feb 2010 09:08:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B7BA433.3030206@linux.vnet.ibm.com>
References: <4B7BA433.3030206@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2010 09:08:39 -0800
Message-ID: <364299f41002170908p302cc665g874c89a109ddfd1f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] mail_tests.sh: fix a version problem of Heirloom
	Mail
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
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Wed, Feb 17, 2010 at 12:09 AM, Rishikesh <risrajak@linux.vnet.ibm.com> wrote:
> Hi Shi,
>
> Thanks for your patch . It will be merged in feb 2010 release.
>
> Acked-By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
>
> http://marc.info/?l=ltp-list&m=126440546415559&w=2

There's a lot of noise in the patch because of if-else behavior in
trying to determine the mail app. That's why I didn't commit this (it
requires verification of previous mail applications as well).

The mail test should be resistant to changes like these as a lot of
developers in the FOSS community have different opinions on how to do
things and don't follow any particular standard. This `heirloom mailx'
support is just one said example that needs to be fixed.

Thanks,
-Garrett

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
