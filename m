Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PBWXq-0004Cu-BR
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 17:45:46 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PBWXp-0003GX-CE
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 17:45:46 +0000
Received: by eya28 with SMTP id 28so1233342eya.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Oct 2010 10:45:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <973228724.1500941288087833985.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <973228724.1500941288087833985.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Thu, 28 Oct 2010 10:45:39 -0700
Message-ID: <AANLkTimVkdOnHVVPAoRhMSCv97S=3HCn_uYSF2Ot61E7@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v3] fix keyctl01 revoke argument on s390x
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Tue, Oct 26, 2010 at 3:10 AM, Caspar Zhang <czhang@redhat.com> wrote:
> v1: use number as argument in keyctl syscall function
> v2: add some codes to find an unused id instead of
> using #define directly.
> v3: use INT32_MIN to replace -INT32_MAX; remove
> intermediate variable i.
>
> Signed-off-by: Caspar Zhang <czhang@redhat.com>

Thanks for the work on this -- I committed a slightly modified version
of this patch a few days ago.
Cheers!
-Garrett

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
