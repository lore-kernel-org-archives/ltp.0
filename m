From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 12 Aug 2021 12:06:28 +0200
Subject: [LTP] [PATCH v3] setsockopt08: Handle ENOPROTOOPT even with
 compatible config
In-Reply-To: <20210812064741.4246-1-rpalethorpe@suse.com>
References: <20210811142438.2C8D3A3CBF@relay2.suse.de>
 <20210812064741.4246-1-rpalethorpe@suse.com>
Message-ID: <20d55401-e0f4-0d68-74eb-d931134ba52c@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
small nit below but otherwise it looks good.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 12. 08. 21 8:47, Richard Palethorpe wrote:
> One or more necessary modules can be missing even if they are present
> in the config.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> V3:
> * Use code suggested by Martin. Functionally it is the same as V2.
> 
> I'm not sure which is easier to read, but usually more indentation
> makes things worse. So this is better in that regard.
> 
>  .../kernel/syscalls/setsockopt/setsockopt08.c      | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> index 33892f9b1..20abe85b4 100644
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

Unused variable ^

>  
>  	xt_entry_match->u.user.match_size = (u_int16_t)match_size;
>  	strcpy(xt_entry_match->u.user.name, "state");
> @@ -126,10 +129,13 @@ void run(void)
>  	ipt_replace->num_counters = 1;
>  	ipt_replace->size = ipt_entry->next_offset;
>  
> -	TST_EXP_FAIL(setsockopt(fd, IPPROTO_IP, IPT_SO_SET_REPLACE, buffer, 1),
> -		     EINVAL,
> -		     "setsockopt(%d, IPPROTO_IP, IPT_SO_SET_REPLACE, %p, 1)",
> -		     fd, buffer);
> +	TEST(setsockopt(fd, IPPROTO_IP, IPT_SO_SET_REPLACE, buffer, 1));
> +
> +	if (TST_RET == -1 && TST_ERR == ENOPROTOOPT)
> +		tst_brk(TCONF | TTERRNO, res_fmt_str, fd, buffer);
> +
> +	result = (TST_RET == -1 && TST_ERR == EINVAL) ? TPASS : TFAIL;
> +	tst_res(result | TTERRNO, res_fmt_str, fd, buffer);
>  
>  	SAFE_CLOSE(fd);
>  }
> 


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
