Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QHfGd-0001MG-0u
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 16:49:39 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QHfGc-0000Uz-4D
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 16:49:38 +0000
Received: by vxd7 with SMTP id 7so2175928vxd.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 May 2011 09:49:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dba8a1fa92ed925df7774c7be07f85407f0bea0c.1304500580.git.czhang@redhat.com>
References: <dba8a1fa92ed925df7774c7be07f85407f0bea0c.1304500580.git.czhang@redhat.com>
Date: Wed, 4 May 2011 09:49:32 -0700
Message-ID: <BANLkTik2TDf_6ZH9GtWpG0gfpHfOa5Ejeg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] mem_hotplug: more compile err fix against NUMA v1
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

On Wed, May 4, 2011 at 2:21 AM, Caspar Zhang <czhang@redhat.com> wrote:
>
> commands.c still fail to compile under RHEL5 since it used a compat
> function from NUMA API v2.

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
