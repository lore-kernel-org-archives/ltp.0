Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZFeya-0003ac-0x
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 08:57:08 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZFeyY-000646-GF
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 08:57:08 +0000
Date: Thu, 16 Jul 2015 04:56:52 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1141568873.18145768.1437037012830.JavaMail.zimbra@redhat.com>
In-Reply-To: <1436548585-27189-1-git-send-email-sunyuan3@huawei.com>
References: <1436548585-27189-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Writing "deny" to the /proc/[pid]/setgroups file
 before writing to /proc/[pid]/gid_map.
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





----- Original Message -----
> From: "Yuan Sun" <sunyuan3@huawei.com>
> To: jstancek@redhat.com
> Cc: ltp-list@lists.sourceforge.net
> Sent: Friday, 10 July, 2015 7:16:25 PM
> Subject: [PATCH] Writing "deny" to the /proc/[pid]/setgroups file before writing to /proc/[pid]/gid_map.

I added commit message to make it more clear why setgroups is disabled,
and pushed the patch.

Regards,
Jan

> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> ---
>  testcases/kernel/containers/userns/userns03.c | 77
>  +++++++++++++--------------
>  1 file changed, 38 insertions(+), 39 deletions(-)
> 
> diff --git a/testcases/kernel/containers/userns/userns03.c
> b/testcases/kernel/containers/userns/userns03.c
> index f724967..4e12ff1 100644
> --- a/testcases/kernel/containers/userns/userns03.c
> +++ b/testcases/kernel/containers/userns/userns03.c
> @@ -23,7 +23,8 @@
>   * ID-outside-ns is defined with respect to the user namespace of the
>   process
>   * opening the file.
>   *
> - * GID check is skipped if setgroups is allowed, see kernel commits:
> + * The string "deny" would be written to /proc/self/setgroups before GID
> + * check if setgroups is allowed, see kernel commits:
>   *
>   *   commit 9cc46516ddf497ea16e8d7cb986ae03a0f6b92f8
>   *   Author: Eric W. Biederman <ebiederm@xmission.com>
> @@ -87,17 +88,11 @@ static int child_fn2(void)
>  	uid = geteuid();
>  	gid = getegid();
>  
> -	if (uid != CHILD2UID) {
> -		printf("unexpected uid=%d\n", uid);
> +	if (uid != CHILD2UID || gid != CHILD2GID) {
> +		printf("unexpected uid=%d gid=%d\n", uid, gid);
>  		exit_val = 1;
>  	}
>  
> -	if (setgroupstag == false) {
> -		if (gid != CHILD2GID) {
> -			printf("unexpected: gid=%d\n", gid);
> -			exit_val = 1;
> -		}
> -	}
>  	/*Get the uid parameters of the child_fn2 process.*/
>  	SAFE_FILE_SCANF(NULL, "/proc/self/uid_map", "%d %d %d", &idinsidens,
>  		&idoutsidens, &length);
> @@ -127,27 +122,25 @@ static int child_fn2(void)
>  		exit_val = 1;
>  	}
>  
> -	if (setgroupstag == false) {
> -		sprintf(cpid1gidpath, "/proc/%d/gid_map", cpid1);
> -		SAFE_FILE_SCANF(NULL, "/proc/self/gid_map", "%d %d %d",
> -			 &idinsidens, &idoutsidens, &length);
> +	sprintf(cpid1gidpath, "/proc/%d/gid_map", cpid1);
> +	SAFE_FILE_SCANF(NULL, "/proc/self/gid_map", "%d %d %d",
> +		 &idinsidens, &idoutsidens, &length);
>  
> -		if (idinsidens != CHILD2GID || idoutsidens != parentgid) {
> -			printf("child_fn2 checks /proc/cpid2/gid_map:\n");
> -			printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> -				idinsidens, idoutsidens);
> -			exit_val = 1;
> -		}
> +	if (idinsidens != CHILD2GID || idoutsidens != parentgid) {
> +		printf("child_fn2 checks /proc/cpid2/gid_map:\n");
> +		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> +			idinsidens, idoutsidens);
> +		exit_val = 1;
> +	}
>  
> -		SAFE_FILE_SCANF(NULL, cpid1gidpath, "%d %d %d", &idinsidens,
> -			&idoutsidens, &length);
> +	SAFE_FILE_SCANF(NULL, cpid1gidpath, "%d %d %d", &idinsidens,
> +		&idoutsidens, &length);
>  
> -		if (idinsidens != CHILD1GID || idoutsidens != CHILD2GID) {
> -			printf("child_fn1 checks /proc/cpid1/gid_map:\n");
> -			printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> -				idinsidens, idoutsidens);
> -			exit_val = 1;
> -		}
> +	if (idinsidens != CHILD1GID || idoutsidens != CHILD2GID) {
> +		printf("child_fn1 checks /proc/cpid1/gid_map:\n");
> +		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> +			idinsidens, idoutsidens);
> +		exit_val = 1;
>  	}
>  
>  	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
> @@ -162,17 +155,11 @@ static void cleanup(void)
>  
>  static void setup(void)
>  {
> -	char read_buf[BUFSIZ];
> -
>  	check_newuser();
>  	tst_tmpdir();
>  	TST_CHECKPOINT_INIT(NULL);
> -	if (access("/proc/self/setgroups", F_OK) == 0) {
> -		SAFE_FILE_SCANF(cleanup, "/proc/self/setgroups", "%s",
> -			read_buf);
> -		if (strcmp(read_buf, "deny") == 0)
> -			setgroupstag = false;
> -	}
> +	if (access("/proc/self/setgroups", F_OK) == 0)
> +		setgroupstag = false;
>  }
>  
>  static int updatemap(int cpid, bool type, int idnum, int parentmappid)
> @@ -198,8 +185,10 @@ static int updatemap(int cpid, bool type, int idnum, int
> parentmappid)
>  int main(int argc, char *argv[])
>  {
>  	pid_t cpid2;
> +	char path[BUFSIZ];
>  	int cpid1status, cpid2status;
>  	int lc;
> +	int fd;
>  
>  	tst_parse_opts(argc, argv, NULL, NULL);
>  	setup();
> @@ -222,13 +211,23 @@ int main(int argc, char *argv[])
>  			tst_brkm(TBROK | TERRNO, cleanup,
>  				"cpid2 clone failed");
>  
> +		if (setgroupstag == false) {
> +			sprintf(path, "/proc/%d/setgroups", cpid1);
> +			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
> +			SAFE_WRITE(cleanup, 1, fd, "deny", 4);
> +			SAFE_CLOSE(cleanup, fd);
> +
> +			sprintf(path, "/proc/%d/setgroups", cpid2);
> +			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
> +			SAFE_WRITE(cleanup, 1, fd, "deny", 4);
> +			SAFE_CLOSE(cleanup, fd);
> +		}
> +
>  		updatemap(cpid1, UID_MAP, CHILD1UID, parentuid);
>  		updatemap(cpid2, UID_MAP, CHILD2UID, parentuid);
>  
> -		if (setgroupstag == false) {
> -			updatemap(cpid1, GID_MAP, CHILD1GID, parentuid);
> -			updatemap(cpid2, GID_MAP, CHILD2GID, parentuid);
> -		}
> +		updatemap(cpid1, GID_MAP, CHILD1GID, parentuid);
> +		updatemap(cpid2, GID_MAP, CHILD2GID, parentuid);
>  
>  		TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 1);
>  
> --
> 1.9.1
> 
> 

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
