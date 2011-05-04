Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QHfPM-0001gy-V8
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 16:58:40 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QHfPM-00072S-Bd
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 16:58:40 +0000
Received: by vxd7 with SMTP id 7so2190887vxd.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 May 2011 09:58:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DB7B854.8010304@redhat.com>
References: <4DB7B854.8010304@redhat.com>
Date: Wed, 4 May 2011 09:58:34 -0700
Message-ID: <BANLkTim33DNfozkPozHCwZ3QsUUd_CHh=A@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] kill05: fix race condition in do_master_child
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

On Tue, Apr 26, 2011 at 11:31 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
> There is a race condition when starting child. Master child can go
> forward before child changes its reuid.
> Fix this by waiting until child is ready.

Committed -- thanks!
-Garrett

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
