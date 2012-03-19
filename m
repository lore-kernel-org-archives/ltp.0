Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S9bHG-0004M7-MV
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 12:01:30 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1S9bHB-00013j-6G
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 12:01:30 +0000
Received: by yenm3 with SMTP id m3so6295266yen.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 19 Mar 2012 05:01:19 -0700 (PDT)
Message-ID: <4F671858.8020305@casparzhang.com>
Date: Mon, 19 Mar 2012 19:28:24 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <2fb866f36188a32158e9cb402adb5d59d9df27d2.1332151930.git.zliu@redhat.com>
In-Reply-To: <2fb866f36188a32158e9cb402adb5d59d9df27d2.1332151930.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v3] mem/oom: avoid unexpected error when no memcg
 swap accounting
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
Cc: LTP List <ltp-list@lists.sourceforge.net>, Cai Qian <caiqian@redhat.com>

On 03/19/2012 06:28 PM, Zhouping Liu wrote:
> Since commit http://git.kernel.org/linus/a42c390cfa0c,
> which added an option to control memcg swap, when kernel
> neither set CGROUP_MEM_RES_CTLR_SWAP_ENABLED nor add
> 'swapaccount=1' kernel parameter, that indicates memcg swap
> accounting is disabled, it will have no such file:
> memory.memsw.*, then oom03 & oom04 cases will fail.
> 
> The patch fixed it: removed memsw cases when memcg swap
> accounting is disabled, and added a TCONF:
> tst_resm(TCONF,"memcg swap accounting is disabled");
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> Reviewed-by: Caspar Zhang <czhang@redhat.com>
> 

...

> -		write_file(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes", mem);
> -		testoom(0, 1, 1);
> +		if (swap_acc_on) {			

You should remove trailing whitespace.

Committed with this update.

Thanks,
Caspar

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
