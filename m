Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QjwV5-0008Qk-QB
	for ltp-list@lists.sourceforge.net; Thu, 21 Jul 2011 16:53:27 +0000
Date: Thu, 21 Jul 2011 18:55:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110721165538.GA7179@saboteur.suse.cz>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
Subject: Re: [LTP] [PATCH 1/7] testcases: fs_bind: fix hanging of testscript
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
To: Andrew Chen <yanpai.chen@gmail.com>
Cc: ltp-list@lists.sourceforge.net, ypchen@faraday-tech.com

Hi!
> Busybox's xargs doesn't recongize the --max-args option. Use -n instead.
> 
> Signed-off-by: Andrew Chen <ypchen@faraday-tech.com>
> ---
>  ltp-full-20101031/testscripts/test_fs_bind.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/ltp-full-20101031/testscripts/test_fs_bind.sh b/ltp-full-20101031/testscripts/test_fs_bind.sh
> index 9ab533a..6b986dc 100755
> --- a/ltp-full-20101031/testscripts/test_fs_bind.sh
> +++ b/ltp-full-20101031/testscripts/test_fs_bind.sh
> @@ -318,7 +318,7 @@ restore_mounts()
>  	# new mounts around and will never remove mounts outside the test
>  	# directory
>  	( while grep_mounts ; do
> -		grep_mounts | awk '{print $3}' | xargs -r --max-args=1 umount -l
> +		grep_mounts | awk '{print $3}' | xargs -r -n 1 umount -l
>  	done ) >& /dev/null
>  
>  	# mount list and exit with 0

This patch is good to go, but doesn't apply.

git am ...
Applying: testcases: fs_bind: fix hanging of testscript
error: ltp-full-20101031/testscripts/test_fs_bind.sh: does not exist in index
Patch failed at 0001 testcases: fs_bind: fix hanging of testscript
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

As I said before there is ltp-full-20101031 that shouldn't be there.
Could you please fix and resend it.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
5 Ways to Improve & Secure Unified Communications
Unified Communications promises greater efficiencies for business. UC can 
improve internal communications as well as offer faster, more efficient ways
to interact with customers and streamline customer service. Learn more!
http://www.accelacomm.com/jaw/sfnl/114/51426253/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
