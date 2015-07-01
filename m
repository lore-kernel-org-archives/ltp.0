Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1ZABk4-00056B-Kr
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 06:43:32 +0000
Received: from mail-ob0-f171.google.com ([209.85.214.171])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZABk3-00051q-Tk
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 06:43:32 +0000
Received: by obdbs4 with SMTP id bs4so22261968obd.3
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Jun 2015 23:43:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPwn2JTer_HFLWz-dO+NjP4BTGZ3-BxfUh24h41djA9W+nfG+w@mail.gmail.com>
References: <1435732532-10995-1-git-send-email-liuhangbin@gmail.com>
	<CAPwn2JTer_HFLWz-dO+NjP4BTGZ3-BxfUh24h41djA9W+nfG+w@mail.gmail.com>
Date: Wed, 1 Jul 2015 14:43:26 +0800
Message-ID: <CAPwn2JRjcmgUuCsQSp=Vv90WjhWsYiYrvwwajdbsA5w8Gm_0NQ@mail.gmail.com>
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCHv3] containers: Use ltp_syscall for setns incase
 some libc library do not support it
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
To: LTP List <ltp-list@lists.sourceforge.net>

2015-07-01 14:39 GMT+08:00 Hangbin Liu <liuhangbin@gmail.com>:
> Opps, there is something wrong with code format. I will correct it. Sorry

It seem the gmail webside view make the patch a mess. Form mutt the patch
format looks good. Please ignore the last mail and continue review this patch.

Sorry for the disturb.

Regards
Hangbin

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
