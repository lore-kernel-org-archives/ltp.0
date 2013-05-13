Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1UboJo-0000wE-Dz
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 08:41:16 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UboJn-0002Pa-FR
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 08:41:16 +0000
Date: Mon, 13 May 2013 16:41:03 +0800
From: Eryu Guan <eguan@redhat.com>
Message-ID: <20130513084103.GM2460@eguan-t400.nay.redhat.com>
References: <519052E3.9040801@cn.fujitsu.com> <51905A0B.5020508@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51905A0B.5020508@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2]mount/mount03.c:  fix several issues
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi,

For patch summary
    [LTP]  [PATCH 2/2]mount/mount03.c:  fix several issues
         ^^                           ^^ one extra space
                     ^^ one space is needed here
On Mon, May 13, 2013 at 11:12:11AM +0800, DAN LI wrote:
> Make following fixes:
> 1. In setup():
>       Create the file before calling stat(file).
>       Call get_current_dir_name() after tst_tmpdir().
>       Fix incorrect using of snprintf().
> 
> 2. For MS_NOEXEC test, change judgement method to
>       If errno is set to EACCES after execlp(exec-file), this case passes.

I don't think you need to indent commit message like this.
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/mount/mount03.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
> index ea4b0e9..1dc39f2 100644
> --- a/testcases/kernel/syscalls/mount/mount03.c
> +++ b/testcases/kernel/syscalls/mount/mount03.c
> @@ -206,7 +206,7 @@ int main(int argc, char *argv[])
> 
>  int test_rwflag(int i, int cnt)
>  {
> -	int fd, pid, status;
> +	int ret, fd, pid, status;
>  	char nobody_uid[] = "nobody";
>  	struct passwd *ltpuser;
> 
> @@ -259,7 +259,9 @@ int test_rwflag(int i, int cnt)
>  			tst_resm(TWARN | TERRNO, "opening %s failed", file);
>  		} else {
>  			close(fd);
> -			execlp(file, basename(file), NULL);
> +			ret = execlp(file, basename(file), NULL);
> +			if ((ret == -1) && (errno == EACCES))
> +				return 0;
Should we give out a TWARN or TBROK when execlp failed?

>  		}
>  		return 1;
>  	case 3:
> @@ -410,6 +412,8 @@ int setup_uid()
> 
>  void setup()
>  {
> +	int fd;
> +	char path[PATH_MAX];
>  	char *test_home;
>  	struct stat setuid_test_stat;
> 
> @@ -421,12 +425,12 @@ void setup()
>  		tst_brkm(TBROK, NULL, "Test must be run as root");
>  	}
> 
> -	/* Test home directory */
> -	test_home = get_current_dir_name();
> -
>  	/* make a temp directory */
>  	tst_tmpdir();
> 
> +	/* Test home directory */
Unwanted comment I think

> +	test_home = get_current_dir_name();
> +
>  	/* Unique mount point */
here too

>  	(void)sprintf(mntpoint, "mnt_%d", getpid());
        ^^^^^^ this is useless

All the three changes should go in the first cleanup patch.

Thanks,
Eryu Guan
> 
> @@ -442,7 +446,12 @@ void setup()
>  		tst_brkm(TBROK, cleanup, "chmod(%s, %#o) failed",
>  			 path_name, DIR_MODE);
> 
> -	snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
> +	snprintf(file, PATH_MAX, "%s/setuid_test", path_name);
> +	fd = open(file, O_CREAT | O_TRUNC);
> +	if (fd == -1)
> +		tst_brkm(TBROK, cleanup, "open file failed");
> +	close(fd);
> +
>  	if (stat(file, &setuid_test_stat) < 0) {
>  		tst_brkm(TBROK, cleanup, "stat for setuid_test failed");
>  	} else {
> @@ -460,8 +469,8 @@ void setup()
>  	/*
>  	 * under temporary directory
>  	 */
> -	snprintf(path_name, PATH_MAX, "%s/%s/", path_name, mntpoint);
> -
> +	strncpy(path, path_name, PATH_MAX);
> +	snprintf(path_name, PATH_MAX, "%s/%s/", path, mntpoint);
>  	strcpy(testhome_path, test_home);
>  	strcat(testhome_path, "/setuid_test");
> 
> -- 
> 1.8.3
> 
> 
> ------------------------------------------------------------------------------
> Learn Graph Databases - Download FREE O'Reilly Book
> "Graph Databases" is the definitive new guide to graph databases and 
> their applications. This 200-page book is written by three acclaimed 
> leaders in the field. The early access version is available now. 
> Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
