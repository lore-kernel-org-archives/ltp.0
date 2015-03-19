Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YYYxW-0006AO-7P
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 11:49:54 +0000
Date: Thu, 19 Mar 2015 12:49:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150319114902.GA3724@rei>
References: <1426742198-17967-1-git-send-email-bamvor.zhangjian@huawei.com>
	<1426742198-17967-3-git-send-email-bamvor.zhangjian@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1426742198-17967-3-git-send-email-bamvor.zhangjian@huawei.com>
Subject: Re: [LTP] [RFC PATCH 2/3] ARM64: ILP32: cast for negtive off_t
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
To: "Zhang Jian(Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: dingtianhong@huawei.com, ltp-list@lists.sourceforge.net, bintian.wang@huawei.com, apinski@cavium.com, yangyingliang@huawei.com

Hi!
> off_t in 64bit in ILP32 ABI while the compiler will default 32bit
> for constant. It lead to pass the negative 32bit integer to kernel,
> and kernel will treat it as 64bit positive integer.
> 
> It could also fix in glibc while we think that there are lots of
> advantage if leave off_t remains 64bit.
> 
> Signed-off-by: Zhang Jian(Bamvor) <bamvor.zhangjian@huawei.com>
> ---
>  testcases/kernel/fs/ftest/ftest02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/fs/ftest/ftest02.c b/testcases/kernel/fs/ftest/ftest02.c
> index ec70d9b..153bd09 100644
> --- a/testcases/kernel/fs/ftest/ftest02.c
> +++ b/testcases/kernel/fs/ftest/ftest02.c
> @@ -268,7 +268,7 @@ static void crfile(int me, int count)
>  	val = write(fd, crmsg, sizeof(crmsg) - 1);
>  	warn(val, "write", 0);
>  
> -	val = lseek(fd, -(sizeof(crmsg) - 1), 1);
> +	val = lseek(fd, -(off_t)(sizeof(crmsg) - 1), 1);

Hmm, this is doing lseek(fd, -size_of_message, SEEK_CUR), wouldn't it be
easier to use the offset we passed to the first lseek() with SEEK_SET
instead?

And I do not really understand why this does not work. All I can see
that the expression is evaluated as: sizeof() returns size of the
message as size_t, which is 32 bit, we decrement it by one and then
negate it. We have negative 32 bit number. Then the compiler should pick
up the lseek() prototype from glibc header and figure out that it should
convert the second parameter to off_t. What I'm missing here?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
