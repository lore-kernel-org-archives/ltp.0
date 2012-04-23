Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SMGii-0005uX-HQ
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 10:42:12 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SMGid-0008Sx-6G
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 10:42:12 +0000
Received: by pbcum15 with SMTP id um15so3532486pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 23 Apr 2012 03:42:01 -0700 (PDT)
Message-ID: <4F9531E1.3080102@casparzhang.com>
Date: Mon, 23 Apr 2012 18:41:37 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F952FAE.9050208@redhat.com>
In-Reply-To: <4F952FAE.9050208@redhat.com>
Subject: Re: [LTP] [PATCH 2/3] add testcases/kernel/syscalls/cma
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
To: ltp-list@lists.sourceforge.net

On 04/23/2012 06:32 PM, Jan Stancek wrote:
> 
> add directory structure for tests related to syscalls:
> process_vm_readv
> process_vm_writev
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

ACK

> ---
>  testcases/kernel/syscalls/cma/Makefile             |   22 ++++++++++++++++++++
>  .../kernel/syscalls/cma/process_vm_readv/Makefile  |   22 ++++++++++++++++++++
>  .../kernel/syscalls/cma/process_vm_writev/Makefile |   22 ++++++++++++++++++++
>  3 files changed, 66 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/cma/Makefile
>  create mode 100644 testcases/kernel/syscalls/cma/process_vm_readv/Makefile
>  create mode 100644 testcases/kernel/syscalls/cma/process_vm_writev/Makefile
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> For Developers, A Lot Can Happen In A Second.
> Boundary is the first to Know...and Tell You.
> Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
> http://p.sf.net/sfu/Boundary-d2dvs2
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
