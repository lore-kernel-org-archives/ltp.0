From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 12 Oct 2020 18:02:10 +0200
Subject: [LTP] [PATCH] ioctl_sg01: correct the fix SHA1
In-Reply-To: <20201012091204.875-1-po-hsu.lin@canonical.com>
References: <20201012091204.875-1-po-hsu.lin@canonical.com>
Message-ID: <26c947ca-12b7-92ad-4b7f-52603c3b173d@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Oops, thanks for noticing this.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 12. 10. 20 11:12, Po-Hsu Lin wrote:
> Correct the fix SHA1 to match with the one in the comment.
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> index 8ad2ffed5..94b30dc6b 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> @@ -127,7 +127,7 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.tags = (const struct tst_tag[]) {
> -		{"linux-git", "e093c4be760e"},
> +		{"linux-git", "a45b599ad808"},
>  		{"CVE", "2018-1000204"},
>  		{}
>  	}
> 


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
