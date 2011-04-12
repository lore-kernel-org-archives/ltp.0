Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q9XMV-0001Kx-Gg
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:46:07 +0000
Received: from mail-px0-f174.google.com ([209.85.212.174])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q9XMU-0002l3-OP
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:46:07 +0000
Received: by pxi15 with SMTP id 15so3211544pxi.33
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Apr 2011 23:46:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <31e14b5b388ec4591dd62f86fa2b35b5ae4f408f.1302440251.git.czhang@redhat.com>
References: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>
	<f4ad73abd0251782d607e88f90a4a1a26001d9ea.1302440251.git.czhang@redhat.com>
	<31e14b5b388ec4591dd62f86fa2b35b5ae4f408f.1302440251.git.czhang@redhat.com>
Date: Mon, 11 Apr 2011 23:46:00 -0700
Message-ID: <BANLkTi=zFezAWMpeQYE+JFRth8zCuByXhA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v3] [mm] mbind01: not working on some systems
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

On Sun, Apr 10, 2011 at 6:00 AM, Caspar Zhang <czhang@redhat.com> wrote:
>
> when executing mem/mbind01 testcase under some systems, it returns
> ENOSYS error, indicating that mbind syscall is not implemented on this
> system. This behavior is allowed and should not return error.
>
> Signed-off-by: Caspar Zhang <czhang@redhat.com>

Committed.
Thanks!
-Garrett

------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
