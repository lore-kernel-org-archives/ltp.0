Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z0C0e-0005zZ-6M
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2015 16:59:20 +0000
Date: Wed, 3 Jun 2015 18:58:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150603165820.GC8444@rei.suse.de>
References: <1433158230-3452-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433158230-3452-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH] Fix the return value error of read_shares_file.
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
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> See the following in the read_file function.
> *value = read_shares_file(filepath);
> if (*value == -1)
> 	return -1;
> Since the return value of read_shares_file and the variable value are
> unsigned int, it is impossible that *value == -1.
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> ---
>  testcases/kernel/controllers/libcontrollers/libcontrollers.c | 6 ++++--
>  testcases/kernel/controllers/libcontrollers/libcontrollers.h | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.c b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
> index b01e1b8..80a90b9 100644
> --- a/testcases/kernel/controllers/libcontrollers/libcontrollers.c
> +++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
> @@ -115,11 +115,14 @@ int read_file(char *filepath, int action, unsigned int *value)
>  {
>  	int num_line = 0;
>  	FILE *fp;
> +	int tmp;
>  	switch (action) {
>  	case GET_SHARES:
> -		*value = read_shares_file(filepath);
> +		tmp = read_shares_file(filepath);
>  		if (*value == -1)
>  			return -1;
> +		else
> +			*value = (unsigned int)tmp;
>  		break;
>  
>  	case GET_TASKS:
> @@ -159,7 +162,6 @@ inline int error_function(char *msg1, char *msg2)
>   * the given pointer location. Returns 0 if success
>   */
>  
> -unsigned
>  int read_shares_file(char *filepath)
>  {
>  	FILE *fp;
> diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.h b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
> index 4001555..78a7fed 100644
> --- a/testcases/kernel/controllers/libcontrollers/libcontrollers.h
> +++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
> @@ -72,7 +72,7 @@ enum{
>  
>  inline int error_function(char *msg1, char *msg2);
>  
> -unsigned int read_shares_file (char *filepath);
> +int read_shares_file(char *filepath);
>  
>  int read_file(char *filepath, int action, unsigned int *value);

Looking at the code, it's more broken than this.

The read_shares_file() function, as well as rest of the functions,
cannot return -1 as they are now.

If you look at the code carefuly:

inline int error_function(char *msg1, char *msg2)
{
        fprintf(stdout, "ERROR: %s ", msg1);
        fprintf(stdout, "%s\n", msg2);
        return -1;
}

unsigned
int read_shares_file(char *filepath)
{
        FILE *fp;
        unsigned int shares;
        fp = fopen(filepath, "r");
        if (fp == NULL)
                error_function("Could not open file", filepath);
	fscanf(fp, "%u", &shares);

The return value from error_function() would be ingnored here and, if the file
cannot be open, the code will crash while passing NULL to fscanf.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
