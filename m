Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SEFbh-0006DF-3e
	for ltp-list@lists.sourceforge.net; Sun, 01 Apr 2012 07:53:49 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SEFbg-0002Hl-EQ
	for ltp-list@lists.sourceforge.net; Sun, 01 Apr 2012 07:53:49 +0000
Received: by pbcum15 with SMTP id um15so3513225pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 01 Apr 2012 00:53:42 -0700 (PDT)
Message-ID: <4F780917.3080604@casparzhang.com>
Date: Sun, 01 Apr 2012 15:51:51 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <aef1be3a718b56357b90b2a7f06f583c2a3c240d.1333117443.git.zliu@redhat.com>
In-Reply-To: <aef1be3a718b56357b90b2a7f06f583c2a3c240d.1333117443.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH] mm/tunable: fix unexpected error log in
	min_free_kbytes
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 03/30/2012 10:29 PM, Zhouping Liu wrote:
> 
> when overcommit_memory=0, mmap() will be destroyed in two below scenario:
>  1) MAP_FAILED with ENOMEM,
>  2) oom_killer kill it.
> without the patch, it just catched oom_killer scenario,
> the patch fixed it.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  testcases/kernel/mem/tunable/min_free_kbytes.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 
pushed. thanks.

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
