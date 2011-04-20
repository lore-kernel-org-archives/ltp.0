Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QCQgg-0001ym-Cp
	for ltp-list@lists.sourceforge.net; Wed, 20 Apr 2011 06:14:54 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QCQgf-0008Rk-NO
	for ltp-list@lists.sourceforge.net; Wed, 20 Apr 2011 06:14:54 +0000
Received: by pzk35 with SMTP id 35so314322pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Apr 2011 23:14:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1067240850.28848.1303219004077.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <508695279.28083.1303217546129.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1067240850.28848.1303219004077.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 19 Apr 2011 23:14:46 -0700
Message-ID: <BANLkTini_6Bk04Vm9di+88pgcYDBzY+ubA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] cgroups/cpuacct_setup: fix task_kill() search for
	process
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Apr 19, 2011 at 6:16 AM, Jan Stancek <jstancek@redhat.com> wrote:
>
> 1. "i* in "grep cpuacct_taski*" seems pointless as
> its target is cpuacct_task01
>
> 2. using cut fails when ps indents the output as following:
> =A099 cpuacct_task01
> =A0112 cpuacct_task01
> 1111 cpuacct_task01
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Patch doesn't apply.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Benefiting from Server Virtualization: Beyond Initial Workload =

Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve =

application availability and disaster protection. Learn more about boosting =

the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
