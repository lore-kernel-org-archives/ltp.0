Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QDA0y-0007H9-Aa
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 06:38:52 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QDA0x-0003Oq-Kj
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 06:38:52 +0000
Received: by pzk35 with SMTP id 35so278384pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Apr 2011 23:38:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <14a46a643c1e7c7b912be1a237067f79b203baa1.1303453311.git.czhang@redhat.com>
References: <14a46a643c1e7c7b912be1a237067f79b203baa1.1303453311.git.czhang@redhat.com>
Date: Thu, 21 Apr 2011 23:38:45 -0700
Message-ID: <BANLkTimGcJ2a7wpe34Y4iML4GLvcjCD0NA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] [mm] mbind01: fix compile issue in RHEL5
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

On Thu, Apr 21, 2011 at 11:22 PM, Caspar Zhang <czhang@redhat.com> wrote:
>
> mem/mbind01 was designed to test NUMA v2 lib, it will cause compile
> error with old NUMA API version, this patch fixes this issue.

Fixed this and the other libnuma item in one commit.
Thanks!
-Garrett

------------------------------------------------------------------------------
Fulfilling the Lean Software Promise
Lean software platforms are now widely adopted and the benefits have been 
demonstrated beyond question. Learn why your peers are replacing JEE 
containers with lightweight application servers - and what you can gain 
from the move. http://p.sf.net/sfu/vmware-sfemails
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
