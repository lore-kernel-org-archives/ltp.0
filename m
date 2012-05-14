Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1STpfh-00089q-Nn
	for ltp-list@lists.sourceforge.net; Mon, 14 May 2012 07:26:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1STpfb-0007AG-Sy
	for ltp-list@lists.sourceforge.net; Mon, 14 May 2012 07:26:21 +0000
Message-ID: <4FB0B348.3020601@cn.fujitsu.com>
Date: Mon, 14 May 2012 15:24:56 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1336655089-26941-1-git-send-email-marios.makris@gmail.com>
	<1336655089-26941-3-git-send-email-marios.makris@gmail.com>
In-Reply-To: <1336655089-26941-3-git-send-email-marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH 3/3] Changed nconv variable from long to int in
 /lib/bytes_by_prefix.c
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Marios Makris <marios.makris@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 05/10/2012 09:04 PM, Marios Makris wrote:

> According to sscanf man page the return value is int
> therefore the holding variable should be int as well.
> 
> Also changed the loop variable name of the main method
> from ind to i in order to better represent that it is
> just a loop variable.
> 
> Signed-off-by: Marios Makris <marios.makris@gmail.com>


But Marios,

In the previous patch, you changed the library function
from str_to_bytes to bytes_by_prefix, if you'd prefer
the latter name, please also replace the using of str_to_bytes
with the new name, if not, it'll not be compiled.

Thanks,
Wanlong Gao

> ---
>  lib/bytes_by_prefix.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/bytes_by_prefix.c b/lib/bytes_by_prefix.c
> index b9ac565..eebff83 100644
> --- a/lib/bytes_by_prefix.c
> +++ b/lib/bytes_by_prefix.c
> @@ -108,7 +108,7 @@ int bytes_by_prefix(char *s)
>  long lbytes_by_prefix(char *s)
>  {
>  	char mult, junk;
> -	long nconv;
> +	int nconv;
>  	float num;
>  
>  	nconv = sscanf(s, "%f%c%c", &num, &mult, &junk);
> @@ -145,7 +145,7 @@ long lbytes_by_prefix(char *s)
>  long long llbytes_by_prefix(char *s)
>  {
>  	char mult, junk;
> -	long nconv;
> +	int nconv;
>  	double num;
>  
>  	nconv = sscanf(s, "%lf%c%c", &num, &mult, &junk);
> @@ -179,23 +179,23 @@ long long llbytes_by_prefix(char *s)
>  
>  main(int argc, char **argv)
>  {
> -	int ind;
> +	int i;
>  
>  	if (argc == 1) {
>  		fprintf(stderr, "missing bytes_by_prefix() parameteres\n");
>  		exit(1);
>  	}
>  
> -	for (ind = 1; ind < argc; ind++) {
> +	for (i = 1; i < argc; i++) {
>  
>  		printf("bytes_by_prefix(%s) returned %d\n",
> -		       argv[ind], bytes_by_prefix(argv[ind]));
> +		       argv[i], bytes_by_prefix(argv[i]));
>  
>  		printf("lbytes_by_prefix(%s) returned %ld\n",
> -		       argv[ind], lbytes_by_prefix(argv[ind]));
> +		       argv[i], lbytes_by_prefix(argv[i]));
>  
>  		printf("llbytes_by_prefix(%s) returned %lld\n",
> -		       argv[ind], llbytes_by_prefix(argv[ind]));
> +		       argv[i], llbytes_by_prefix(argv[i]));
>  	}
>  }
>  



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
