From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 14 Jan 2019 15:32:06 -0500
Subject: [LTP] [PATCH 3/6] ima/ima_boot_aggregate: Fix extending PCRs
 beyond PCR 0-7
In-Reply-To: <1546827989-43569-4-git-send-email-zhang.jia@linux.alibaba.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1546827989-43569-4-git-send-email-zhang.jia@linux.alibaba.com>
Message-ID: <1547497926.4156.198.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2019-01-07 at 10:26 +0800, Jia Zhang wrote:
> The boot aggragate calculation should never touch PCRs beyond PCR 0-7,
> even a PCR extension really manipulates out-of-domain PCRs.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

Thanks!

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


> ---
>  .../security/integrity/ima/src/ima_boot_aggregate.c       | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> index 67be6a7..98893b9 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> @@ -93,11 +93,16 @@ int main(int argc, char *argv[])
>  			printf("%03u ", event.header.pcr);
>  			display_sha1_digest(event.header.digest);
>  		}
> -		SHA1_Init(&c);
> -		SHA1_Update(&c, pcr[event.header.pcr].digest,
> -			    SHA_DIGEST_LENGTH);
> -		SHA1_Update(&c, event.header.digest, SHA_DIGEST_LENGTH);
> -		SHA1_Final(pcr[event.header.pcr].digest, &c);
> +
> +		if (event.header.pcr < NUM_PCRS) {
> +			SHA1_Init(&c);
> +			SHA1_Update(&c, pcr[event.header.pcr].digest,
> +				    SHA_DIGEST_LENGTH);
> +			SHA1_Update(&c, event.header.digest,
> +				    SHA_DIGEST_LENGTH);
> +			SHA1_Final(pcr[event.header.pcr].digest, &c);
> +		}
> +
>  #if MAX_EVENT_DATA_SIZE < USHRT_MAX
>  		if (event.header.len > MAX_EVENT_DATA_SIZE) {
>  			printf("Error event too long\n");

