Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SrQcw-0004re-0O
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 09:33:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SrQct-0004EQ-Qo
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 09:33:01 +0000
Message-ID: <5006829C.7080308@cn.fujitsu.com>
Date: Wed, 18 Jul 2012 17:32:12 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1342194676-15275-1-git-send-email-marios.makris@gmail.com>
	<1342194676-15275-4-git-send-email-marios.makris@gmail.com>
In-Reply-To: <1342194676-15275-4-git-send-email-marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH 4/6] /lib/tst_tmpdir.c removed / and * checks
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

On 07/13/2012 11:51 PM, Marios Makris wrote:
> These checks are implemented in the rmobj.c file therefore there is no
> need to repeat them here since rmobj() is called for deletions.
> 
> Signed-off-by: Marios Makris <marios.makris@gmail.com>
> ---
>  lib/tst_tmpdir.c |   17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index b6f4d2e..a9dd78c 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -194,8 +194,6 @@ void tst_tmpdir(void)
>  
>  void tst_rmdir(void)
>  {
> -	struct stat buf1;
> -	struct stat buf2;
>  	char current_dir[PATH_MAX];
>  	char *errmsg;
>  	char *parent_dir;
> @@ -229,21 +227,6 @@ void tst_rmdir(void)
>  	}
>  
>  	/*
> -	 * Check that the value of TESTDIR is not "*" or "/".  These could
> -	 * have disastrous effects in a test run by root.
> -	 */
> -	if (stat(TESTDIR, &buf1) == 0 && stat("/", &buf2) == 0 &&
> -		buf1.st_ino == buf2.st_ino) {
> -		tst_resm(TWARN, "%s: will not remove /", __func__);
> -		return;
> -	}
> -
> -	if (strchr(TESTDIR, '*') != NULL) {
> -		tst_resm(TWARN, "%s: will not remove *", __func__);
> -		return;
> -	}

Seems that rmobj() doesn't check the "*" there?

Thanks,
Wanlong Gao

> -
> -	/*
>  	 * Get the directory name of TESTDIR.  If TESTDIR is a relative path,
>  	 * get full path.
>  	 */
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
