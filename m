Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YpEwk-0002CH-PR
	for ltp-list@lists.sourceforge.net; Mon, 04 May 2015 11:54:02 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id E7D1CAD08
	for <ltp-list@lists.sourceforge.net>;
	Mon,  4 May 2015 11:53:54 +0000 (UTC)
Date: Mon, 4 May 2015 13:53:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150504115324.GB7674@rei.suse.de>
References: <20150504063425.GA9995@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150504063425.GA9995@localhost.localdomain>
Subject: Re: [LTP] [PATCH] performing test on loop device if noatime or
 relatime specified
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
To: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
> index 54ddfe0..f9be35b 100644
> --- a/testcases/kernel/syscalls/open/open12.c
> +++ b/testcases/kernel/syscalls/open/open12.c
> @@ -24,6 +24,7 @@
>  #include <stdio.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> +#include <sys/mount.h>
>  #include <unistd.h>
>  #include <mntent.h>
>  #include <errno.h>
> @@ -34,8 +35,16 @@
>  #define TEST_FILE	"test_file"
>  #define LARGE_FILE	"large_file"
>  
> +#define DIR_MODE 0755
> +#define MNTPOINT "mntpoint"
> +
>  char *TCID = "open12";
>  
> +static const char *device;
> +static const char *fs_type;
> +static unsigned int mount_flag = 0;
> +static unsigned int cd_flag = 0;
> +
>  static void setup(void);
>  static void cleanup(void);
>  static void test_append(void);
> @@ -114,10 +123,21 @@ static void test_noatime(void)
>  	}
>  
>  	if (tst_path_has_mnt_flags(cleanup, NULL, flags)) {
> -		tst_resm(TCONF,
> -			 "test O_NOATIME flag for open needs filesystems which "
> -			 "is mounted without noatime and relatime");
> -		return;
> +
> +		fs_type = tst_dev_fs_type();
> +		device = tst_acquire_device(cleanup);
> +
> +		if (!device)
> +			tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> +
> +		tst_mkfs(cleanup, device, fs_type, NULL);
> +
> +		SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);

What about creating a test directory in test temporary directory
unconditionally and change the TEST_FILE to point to a file in it? That
way we can just mount the loop device over the directory if needed and
avoid the ugly chdir here and in the cleanup.

> +		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_STRICTATIME, NULL);
> +		mount_flag = 1;
> +		SAFE_FILE_PRINTF(cleanup, MNTPOINT"/"TEST_FILE, TEST_FILE);
> +		SAFE_CHDIR(cleanup, MNTPOINT);
> +		cd_flag = 1;
>  	}
>  
>  	SAFE_STAT(cleanup, TEST_FILE, &old_stat);
> @@ -221,5 +241,18 @@ static void test_largefile(void)
>  
>  static void cleanup(void)
>  {
> +	if (cd_flag) {
> +		char *tmp_dir = tst_get_tmpdir();
> +		SAFE_CHDIR(NULL, tmp_dir);
> +		free(tmp_dir);
> +	}
> +
> +	if (mount_flag && tst_umount(MNTPOINT) == -1) {
> +		tst_brkm(TBROK | TERRNO, NULL, "umount(2) failed");

This should rather be tst_resm(TWARN | TERRNO, ...) so that we at least
attempt to continue the cleanup.

> +	}
> +
> +	if (device)
> +		tst_release_device(NULL, device);
> +
>  	tst_rmdir();

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
