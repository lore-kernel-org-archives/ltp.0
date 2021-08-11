From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 11 Aug 2021 16:24:28 +0200
Subject: [LTP] [PATCH v2] setsockopt08: Handle ENOPROTOOPT even with
 compatible config
In-Reply-To: <20210811072430.13560-1-rpalethorpe@suse.com>
References: <20210806111938.12007-1-rpalethorpe@suse.com>
 <20210811072430.13560-1-rpalethorpe@suse.com>
Message-ID: <bca277c9-cd0d-788a-ae7d-73d4a0cadb91@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11. 08. 21 9:24, Richard Palethorpe via ltp wrote:
> One or more necessary modules can be missing even if they are present
> in the config.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
> 
> V2:
> * Use tst_brk with TCONF
> 
>  .../kernel/syscalls/setsockopt/setsockopt08.c | 24 +++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> index 33892f9b1..7afb98403 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> @@ -101,6 +101,8 @@ void setup(void)
>  
>  void run(void)
>  {
> +	const char *const res_fmt_str =
> +		"setsockopt(%d, IPPROTO_IP, IPT_SO_SET_REPLACE, %p, 1)";
>  	struct ipt_replace *ipt_replace = buffer;
>  	struct ipt_entry *ipt_entry = &ipt_replace->entries[0];
>  	struct xt_entry_match *xt_entry_match =
> @@ -110,6 +112,7 @@ void run(void)
>  	struct xt_entry_target *xt_entry_tgt =
>  		((struct xt_entry_target *) (&ipt_entry->elems[0] + match_size));
>  	int fd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
> +	int result;
>  
>  	xt_entry_match->u.user.match_size = (u_int16_t)match_size;
>  	strcpy(xt_entry_match->u.user.name, "state");
> @@ -126,10 +129,23 @@ void run(void)
>  	ipt_replace->num_counters = 1;
>  	ipt_replace->size = ipt_entry->next_offset;
>  
> -	TST_EXP_FAIL(setsockopt(fd, IPPROTO_IP, IPT_SO_SET_REPLACE, buffer, 1),
> -		     EINVAL,
> -		     "setsockopt(%d, IPPROTO_IP, IPT_SO_SET_REPLACE, %p, 1)",
> -		     fd, buffer);
> +	errno = 0;
> +	if (setsockopt(fd, IPPROTO_IP, IPT_SO_SET_REPLACE, buffer, 1) == -1) {
> +		switch (errno) {
> +		case EINVAL:
> +			result = TPASS;
> +			break;
> +		case ENOPROTOOPT:
> +			tst_brk(TCONF | TERRNO, res_fmt_str, fd, buffer);
> +			return;
> +		default:
> +			result = TFAIL;
> +		}
> +	} else {
> +		result = TFAIL;
> +	}
> +
> +	tst_res(result | TERRNO, res_fmt_str, fd, buffer);
>  
>  	SAFE_CLOSE(fd);
>  }
> 

I think this would be much cleaner:

TEST(setsockopt(fd, IPPROTO_IP, IPT_SO_SET_REPLACE, buffer, 1));

if (TST_RET == -1 && TST_ERR == ENOPROTOOPT)
	tst_brk(TCONF | TTERRNO, res_fmt_str, fd, buffer);

result = (TST_RET == -1 && TST_ERR == EINVAL) ? TPASS : TFAIL;
tst_res(result | TTERRNO, res_fmt_str, fd, buffer);

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
