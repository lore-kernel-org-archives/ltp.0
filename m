Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QAMOV-0008Sc-0f
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 13:15:35 +0000
Received: from mail-px0-f174.google.com ([209.85.212.174])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QAMOU-0003uB-9z
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 13:15:34 +0000
Received: by pxi15 with SMTP id 15so1342366pxi.33
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Apr 2011 06:15:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443931472.73326.1302781486782.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1640962017.73206.1302781090843.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1443931472.73326.1302781486782.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Thu, 14 Apr 2011 06:15:27 -0700
Message-ID: <BANLkTin8di7Q=rZVD9=LFnQVDY4ZrSb7OQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] memcg_process.c: signals initialization
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
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On Thu, Apr 14, 2011 at 4:44 AM, Jan Stancek <jstancek@redhat.com> wrote:
> 1. There seems to be copy paste error, instead of clearing
> sigusr_action.sa_mask it clears sigint_action.sa_mask.
> Change comes from 6c4d1c6d4b3c116ff88f9209b4860940fb8659a8
>
> 2. Other fields of these structures are left to be uninitialized.
>
> Both 1) and 2) make the behaviour unexpected. Occasionally I saw,
> this program to end upon receiving SIGUSR1.

Committed -- thanks!
-Garrett

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
