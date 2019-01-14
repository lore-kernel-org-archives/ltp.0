From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 14 Jan 2019 15:33:26 -0500
Subject: [LTP] [PATCH 2/6] ima/ima_boot_aggregate: Don't hard code the
 length of sha1 hash
In-Reply-To: <1546827989-43569-3-git-send-email-zhang.jia@linux.alibaba.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1546827989-43569-3-git-send-email-zhang.jia@linux.alibaba.com>
Message-ID: <1547498006.4156.199.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2019-01-07 at 10:26 +0800, Jia Zhang wrote:
> Instead, use SHA_DIGEST_LENGTH.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> index d85d222..67be6a7 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> @@ -42,7 +42,7 @@ static void display_sha1_digest(unsigned char *pcr)
>  {
>  	int i;
> 
> -	for (i = 0; i < 20; i++)
> +	for (i = 0; i < SHA_DIGEST_LENGTH; i++)
>  		printf("%02x", *(pcr + i) & 0xff);
>  	printf("\n");
>  }
> @@ -94,8 +94,9 @@ int main(int argc, char *argv[])
>  			display_sha1_digest(event.header.digest);
>  		}
>  		SHA1_Init(&c);
> -		SHA1_Update(&c, pcr[event.header.pcr].digest, 20);
> -		SHA1_Update(&c, event.header.digest, 20);
> +		SHA1_Update(&c, pcr[event.header.pcr].digest,
> +			    SHA_DIGEST_LENGTH);
> +		SHA1_Update(&c, event.header.digest, SHA_DIGEST_LENGTH);
>  		SHA1_Final(pcr[event.header.pcr].digest, &c);
>  #if MAX_EVENT_DATA_SIZE < USHRT_MAX
>  		if (event.header.len > MAX_EVENT_DATA_SIZE) {
> @@ -116,7 +117,7 @@ int main(int argc, char *argv[])
>  			printf("PCR-%2.2x: ", i);
>  			display_sha1_digest(pcr[i].digest);
>  		}
> -		SHA1_Update(&c, pcr[i].digest, 20);
> +		SHA1_Update(&c, pcr[i].digest, SHA_DIGEST_LENGTH);
>  	}
>  	SHA1_Final(boot_aggregate, &c);
> 

