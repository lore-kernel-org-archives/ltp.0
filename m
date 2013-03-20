Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UIGUu-0004cc-1N
	for ltp-list@lists.sourceforge.net; Wed, 20 Mar 2013 10:43:56 +0000
Received: from mail-da0-f53.google.com ([209.85.210.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UIGUs-0001sR-LZ
	for ltp-list@lists.sourceforge.net; Wed, 20 Mar 2013 10:43:56 +0000
Received: by mail-da0-f53.google.com with SMTP id n34so907537dal.26
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Mar 2013 03:43:48 -0700 (PDT)
Message-ID: <51498D7C.1000600@casparzhang.com>
Date: Wed, 20 Mar 2013 18:20:44 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1363772673-14851-1-git-send-email-jstancek@redhat.com>
In-Reply-To: <1363772673-14851-1-git-send-email-jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] inode02: fix "slash" array overrun
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 03/20/2013 05:44 PM, Jan Stancek wrote:
> Remove "slash" array and convert strcat to snprintf.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

> ---
>   testcases/kernel/fs/inode/inode02.c |   26 ++++++++++++++++----------
>   1 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/testcases/kernel/fs/inode/inode02.c b/testcases/kernel/fs/inode/inode02.c
> index 783edf8..54e3927 100644
> --- a/testcases/kernel/fs/inode/inode02.c
> +++ b/testcases/kernel/fs/inode/inode02.c
> @@ -80,7 +80,6 @@ int nchild;
>   FILE *list_stream = NULL;
>   int list_id;
>   int file_id;
> -char slash[1];
>
>   int increment_name(), get_next_name(), mode(), escrivez(), massmurder();
>   int max_depth, max_breadth, file_length;
> @@ -249,9 +248,7 @@ int tree()
>   	char path_list_string[PATH_STRING_LENGTH + 10];
>   	int len;
>   	int status;
> -
> -	slash[0] = '/';
> -	slash[1] = '\0';
> +	int snp_ret;
>
>   	/********************************/
>   	/*                              */
> @@ -287,9 +284,13 @@ int tree()
>   	/*                                      */
>   	/****************************************/
>
> -	strcpy(path_list_string, path_string);
> -	strcat(path_list_string, slash);
> -	strcat(path_list_string, "path_list");
> +	snp_ret = snprintf(path_list_string, sizeof(path_list_string),
> +		"%s/path_list",	path_string);
> +	if (snp_ret < 0 || snp_ret >= sizeof(path_list_string)) {
> +		tst_resm(TBROK, "snprintf(path_list_string,..) returned %d",
> +			snp_ret);
> +		exit(-1);
> +	}
>   	list_id = creat(path_list_string, FILE_MODE);
>   	if (list_id == -1) {
>   		fprintf(temp,
> @@ -411,6 +412,7 @@ int level;			/* the tree depth variable */
>   	char new_string[PATH_STRING_LENGTH + 1];
>   	int new_level;
>   	int i, j;		/* iteration counters */
> +	int snp_ret;
>
>   	switch_flag = level & TRUE;
>   	if (strlen(string) >= MAX_PATH_STRING_LENGTH) {
> @@ -427,9 +429,13 @@ int level;			/* the tree depth variable */
>   	} else if (level < max_depth) {
>   		for (i = 0; i <= max_breadth; i++) {
>   			get_next_name();
> -			strcpy(new_string, string);
> -			strcat(new_string, slash);
> -			strcat(new_string, name);
> +			snp_ret = snprintf(new_string, sizeof(new_string),
> +				"%s/%s", string, name);
> +			if (snp_ret < 0 || snp_ret >= sizeof(new_string)) {
> +				tst_resm(TBROK, "snprintf(new_string,..) "
> +					"returned %d", snp_ret);
> +				exit(-1);
> +			}
>
>   			/****************************************/
>   			/*                                      */
>


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
