Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YG7Rg-0006YT-QG
	for ltp-list@lists.sourceforge.net; Tue, 27 Jan 2015 14:48:48 +0000
Date: Tue, 27 Jan 2015 15:48:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150127144841.GD16759@rei.suse.de>
References: <1422323457-184525-1-git-send-email-shengyong1@huawei.com>
	<1422323457-184525-4-git-send-email-shengyong1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422323457-184525-4-git-send-email-shengyong1@huawei.com>
Subject: Re: [LTP] [RESEND PATCH v3 3/4] lib/tests: do not print max dir
 number if subdir limit not availiable
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
To: Sheng Yong <shengyong1@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  lib/tests/tst_fs_fill_subdirs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/tests/tst_fs_fill_subdirs.c b/lib/tests/tst_fs_fill_subdirs.c
> index 496db59..7c956f6 100644
> --- a/lib/tests/tst_fs_fill_subdirs.c
> +++ b/lib/tests/tst_fs_fill_subdirs.c
> @@ -33,10 +33,13 @@ static void cleanup(void)
>  
>  int main(void)
>  {
> +	int ret;
> +
>  	tst_tmpdir();
>  
> -	fprintf(stderr, "Max dir elements = %i\n",
> -	        tst_fs_fill_subdirs(NULL, "dir"));
> +	ret = tst_fs_fill_subdirs(NULL, "dir");
> +	if (ret != -1)
> +		fprintf(stderr, "Max dir elements = %i\n", ret);

Given that this is just a simple test for the library API in order to
make sure the code compiles and to figure out what the exact return
value was, there is no point in silencing the output.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
