Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X6zOL-0007hN-85
	for ltp-list@lists.sourceforge.net; Tue, 15 Jul 2014 09:51:21 +0000
Date: Tue, 15 Jul 2014 11:50:51 +0200
From: chrubis@suse.cz
Message-ID: <20140715095051.GA26664@rei>
References: <1403596982-21645-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403596982-21645-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] fs/ext4-new-features: fix wrong test point
 when running ext4-persist-prealloc
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> ext4-persist-prealloc test will call test cases under 'testcases/kernel/syscalls
> /fallocate' to have persist prealloc test for ext4 filesystem. But currently
> fallocate[0-3] cases will have tests in a different filesystem, which the directory
> created by tst_tmpdir() is in. This is wrong, fix it.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  .../ext4-persist-prealloc/ext4_persist_prealloc_test.sh              | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
> index 20b66f8..d577bb5 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
> @@ -46,6 +46,7 @@ ext4_test_persist_prealloc()
>  
>  	ret=1
>  
> +	temp_tmpdir=$TMPDIR
>  	for ((i = 1; i <= 3; i++))
>  	{
>  		if ! command -v fallocate0${i} > /dev/null 2>&1; then
> @@ -56,13 +57,15 @@ ext4_test_persist_prealloc()
>  			return
>  		fi
>  
> -		fallocate0${i} | grep -q "CONF"
> +		TMPDIR=mnt_point; fallocate0${i} | grep -q "CONF"
>  		if [ $? -ne $ret ]; then
>  			tst_resm TFAIL "fallocate's return value is not expected"
>  			umount mnt_point
> +			TMPDIR=$temp_tmpdir
>  			return
>  		fi
>  	}
> +	TMPDIR=$temp_tmpdir

I've moved the TMPDIR restoration closer to the fallocate call so it's
now:

+               temp_tmpdir=$TMPDIR
+               TMPDIR=mnt_point; fallocate0${i} | grep -q "CONF"
+               TMPDIR=$temp_tmpdir


And pushed, thanks.

PS: Sorry for the delay.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
