Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z0Und-000655-3X
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2015 13:03:09 +0000
Date: Thu, 4 Jun 2015 15:02:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150604130208.GA7095@rei.suse.de>
References: <1433430027-11690-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433430027-11690-1-git-send-email-sunyuan3@huawei.com>
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
Can you also change the error_function() to return void and remove the
return -1 from it?

> diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.c b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
> index b01e1b8..ebf9870 100644
> --- a/testcases/kernel/controllers/libcontrollers/libcontrollers.c
> +++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
> @@ -50,8 +50,10 @@ int scan_shares_files(unsigned int *shares_pointer)
>  	/*
>  	 * Check if we can get stat of the file
>  	 */
> -	if (lstat(fullpath, &statbuffer) < 0)
> +	if (lstat(fullpath, &statbuffer) < 0) {
>  		error_function("Can not read stat for file ", fullpath);
> +		return -1;
> +	}
>  
>  	if (S_ISDIR(statbuffer.st_mode) == 0) {	/* not a directory */
>  		/*
> @@ -75,8 +77,10 @@ int scan_shares_files(unsigned int *shares_pointer)
>  	*path_pointer++ = '/';
>  	*path_pointer = 0;
>  
> -	if ((dp = opendir(fullpath)) == NULL)	/* Error in opening directory */
> +	if ((dp = opendir(fullpath)) == NULL) {	/* Error in opening directory */
>  		error_function("Can't open ", fullpath);
> +		return -1;
> +	}
>  	/*
>  	 * search all groups recursively and get total shares
>  	 */
> @@ -99,8 +103,10 @@ int scan_shares_files(unsigned int *shares_pointer)
>  
>  	path_pointer[-1] = 0;
>  
> -	if (closedir(dp) < 0)
> +	if (closedir(dp) < 0) {
>  		error_function("Could not close dir ", fullpath);
> +		return -1;
> +	}
>  	return 0;
>  }
>  
> @@ -115,27 +121,35 @@ int read_file(char *filepath, int action, unsigned int *value)
>  {
>  	int num_line = 0;
>  	FILE *fp;
> +	int tmp;
>  	switch (action) {
>  	case GET_SHARES:
> -		*value = read_shares_file(filepath);
> -		if (*value == -1)
> +		tmp = read_shares_file(filepath);
> +		if (tmp == -1)
>  			return -1;
> +		else
> +			*value = (unsigned int)tmp;

There is no need for the else branch. If tmp is -1 the code below would
not be reached anyway.

>  		break;
>  
>  	case GET_TASKS:
>  		fp = fopen(filepath, "r");
> -		if (fp == NULL)
> +		if (fp == NULL) {
>  			error_function("Could not open file", filepath);
> +			return -1;
> +		}
>  		while (fgets(target, LINE_MAX, fp) != NULL)
>  			num_line++;
>  		*value = (unsigned int)num_line;
> -		if (fclose(fp))
> +		if (fclose(fp)) {
>  			error_function("Could not close file", filepath);
> +			return -1;
> +		}
>  		break;
>  
>  	default:
>  		error_function("Wrong action type passed to fun read_file for ",
>  			       filepath);
> +		return -1;
>  		break;

No need to keep the break after return.

>  	}
>  	return 0;
> @@ -159,17 +173,20 @@ inline int error_function(char *msg1, char *msg2)
>   * the given pointer location. Returns 0 if success
>   */
>  
> -unsigned
>  int read_shares_file(char *filepath)
>  {
>  	FILE *fp;
>  	unsigned int shares;
>  	fp = fopen(filepath, "r");
> -	if (fp == NULL)
> +	if (fp == NULL) {
>  		error_function("Could not open file", filepath);
> +		return -1;
> +	}
>  	fscanf(fp, "%u", &shares);
> -	if (fclose(fp))
> +	if (fclose(fp)) {
>  		error_function("Could not close file", filepath);
> +		return -1;
> +	}
>  	return shares;
>  }
>  
> @@ -181,8 +198,10 @@ int write_to_file(char *file, const char *mode, unsigned int value)
>  {
>  	FILE *fp;
>  	fp = fopen(file, mode);
> -	if (fp == NULL)
> +	if (fp == NULL) {
>  		error_function("in opening file for writing:", file);
> +		return -1;
> +	}
>  	fprintf(fp, "%u\n", value);
>  	fclose(fp);
>  	return 0;
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
>  
> -- 
> 1.9.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
