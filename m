Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XKSqv-0006ws-SB
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 13:56:33 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XKSqu-0007hI-MG
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 13:56:33 +0000
Message-ID: <53F5FA85.90100@oracle.com>
Date: Thu, 21 Aug 2014 17:56:21 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <112335100.22365402.1408594496771.JavaMail.zimbra@redhat.com>
In-Reply-To: <112335100.22365402.1408594496771.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v3 2/3] diotest4: Some code cleanup in diotest4.c
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
To: Xiong Zhou <xzhou@redhat.com>, ltp-list@lists.sourceforge.net



On 08/21/2014 08:14 AM, Xiong Zhou wrote:
>
> Split dup code cleanup and function change from v2.

I suppose this message is directed to the LTP mailing list subscribers 
and should not be in `git log` after the patch is applied. Therefore put 
such messages after '---'.

One small comment below.

>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>   testcases/kernel/io/direct_io/diotest4.c | 100 ++++++++++---------------------
>   1 file changed, 32 insertions(+), 68 deletions(-)
>
> diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
> index 10281bf..8059f28 100644
> --- a/testcases/kernel/io/direct_io/diotest4.c
> +++ b/testcases/kernel/io/direct_io/diotest4.c
> @@ -171,6 +171,16 @@ void prg_usage()
>   	exit(1);
>   }
>
> +static void testcheck_end(int ret, int *failed, int *fail_count, char *msg)
> +{
> +	if (ret != 0) {
> +		*failed = TRUE;
> +		*fail_count++;

(*fail_count)++;

> +		tst_resm(TFAIL, msg);
> +	} else
> +		tst_resm(TPASS, msg);
> +}
> +
>   static void setup(void);
>   static void cleanup(void);
>   static int fd1 = -1;
> @@ -290,12 +300,7 @@ int main(int argc, char *argv[])
>   	count = bufsize;
>   	newfd = -1;
>   	ret = runtest_f(newfd, buf2, offset, count, EBADF, 5, "negative fd");
> -	if (ret != 0) {
> -		failed = TRUE;
> -		fail_count++;
> -		tst_resm(TFAIL, "Invalid file descriptor");
> -	} else
> -		tst_resm(TPASS, "Invalid file descriptor");
> +	testcheck_end(ret, &failed, &fail_count, "Invalid file descriptor");
>   	total++;
>
>   	/* Test-6: Out of range file descriptor */
> @@ -306,15 +311,10 @@ int main(int argc, char *argv[])
>   		failed = TRUE;
>   		tst_resm(TFAIL, "Out of range file descriptor");
>   	} else {
> -		ret =
> -		    runtest_f(newfd, buf2, offset, count, EBADF, 6,
> +		ret = runtest_f(newfd, buf2, offset, count, EBADF, 6,
>   			      "out of range fd");
> -		if (ret != 0) {
> -			failed = TRUE;
> -			fail_count++;
> -			tst_resm(TFAIL, "Out of range file descriptor");
> -		} else
> -			tst_resm(TPASS, "Out of range file descriptor");
> +		testcheck_end(ret, &failed, &fail_count,
> +					"Out of range file descriptor");
>   	}
>   	close(newfd);
>   	total++;
> @@ -327,12 +327,7 @@ int main(int argc, char *argv[])
>   			 strerror(errno));
>   	}
>   	ret = runtest_f(fd, buf2, offset, count, EBADF, 7, "closed fd");
> -	if (ret != 0) {
> -		failed = TRUE;
> -		fail_count++;
> -		tst_resm(TFAIL, "Closed file descriptor");
> -	} else
> -		tst_resm(TPASS, "Closed file descriptor");
> +	testcheck_end(ret, &failed, &fail_count, "Closed file descriptor");
>   	total++;
>
>   	/* Test-9: removed */
> @@ -345,12 +340,8 @@ int main(int argc, char *argv[])
>   		tst_resm(TCONF, "Direct I/O on /dev/null is not supported");
>   	} else {
>   		ret = runtest_s(newfd, buf2, offset, count, 9, "/dev/null");
> -		if (ret != 0) {
> -			failed = TRUE;
> -			fail_count++;
> -			tst_resm(TFAIL, "character device read, write");
> -		} else
> -			tst_resm(TPASS, "character device read, write");
> +		testcheck_end(ret, &failed, &fail_count,
> +					"character device read, write");
>   	}
>   	close(newfd);
>   	total++;
> @@ -373,12 +364,8 @@ int main(int argc, char *argv[])
>   			 strerror(errno));
>   	}
>   	ret = runtest_s(fd, buf2, offset, count, 10, "mmapped file");
> -	if (ret != 0) {
> -		failed = TRUE;
> -		fail_count++;
> -		tst_resm(TFAIL, "read, write to a mmaped file");
> -	} else
> -		tst_resm(TPASS, "read, write to a mmaped file");
> +	testcheck_end(ret, &failed, &fail_count,
> +				"read, write to a mmaped file");
>   	total++;
>
>   	/* Test-11: read, write to an unmaped file with munmap */
> @@ -387,12 +374,8 @@ int main(int argc, char *argv[])
>   			 strerror(errno));
>   	}
>   	ret = runtest_s(fd, buf2, offset, count, 11, "unmapped file");
> -	if (ret != 0) {
> -		failed = TRUE;
> -		fail_count++;
> -		tst_resm(TFAIL, "read, write to an unmapped file");
> -	} else
> -		tst_resm(TPASS, "read, write to an unmapped file");
> +	testcheck_end(ret, &failed, &fail_count,
> +				"read, write to an unmapped file");
>   	close(fd);
>   	total++;
>
> @@ -478,12 +461,8 @@ int main(int argc, char *argv[])
>   			l_fail = TRUE;
>   		}
>   	}
> -	if (l_fail) {
> -		failed = TRUE;
> -		fail_count++;
> -		tst_resm(TFAIL, "read, write with non-aligned buffer");
> -	} else
> -		tst_resm(TPASS, "read, write with non-aligned buffer");
> +	testcheck_end(l_fail, &failed, &fail_count,
> +				"read, write with non-aligned buffer");
>   	total++;
>   	close(fd);
>
> @@ -500,8 +479,7 @@ int main(int argc, char *argv[])
>   			 strerror(errno));
>   		l_fail = TRUE;
>   	} else {
> -		ret =
> -		    read(fd, (char *)((ulong) ADDRESS_OF_MAIN & pagemask),
> +		ret = read(fd, (char *)((ulong) ADDRESS_OF_MAIN & pagemask),
>   			 count);
>   		if (ret >= 0 || errno != EFAULT) {
>   			tst_resm(TFAIL,
> @@ -515,8 +493,7 @@ int main(int argc, char *argv[])
>   			 strerror(errno));
>   		l_fail = TRUE;
>   	} else {
> -		ret =
> -		    write(fd, (char *)((ulong) ADDRESS_OF_MAIN & pagemask),
> +		ret = write(fd, (char *)((ulong) ADDRESS_OF_MAIN & pagemask),
>   			  count);
>   		if (ret < 0) {
>   			tst_resm(TFAIL,
> @@ -525,12 +502,8 @@ int main(int argc, char *argv[])
>   			l_fail = TRUE;
>   		}
>   	}
> -	if (l_fail) {
> -		failed = TRUE;
> -		fail_count++;
> -		tst_resm(TFAIL, "read, write buffer in read-only space");
> -	} else
> -		tst_resm(TPASS, "read, write buffer in read-only space");
> +	testcheck_end(l_fail, &failed, &fail_count,
> +				"read, write buffer in read-only space");
>   	close(fd);
>   	total++;
>
> @@ -545,15 +518,10 @@ int main(int argc, char *argv[])
>   		tst_brkm(TBROK | TERRNO, cleanup,
>   			 "open(%s, O_DIRECT|O_RDWR) failed", filename);
>   	}
> -	ret =
> -	    runtest_f(fd, buf1, offset, count, EFAULT, 16,
> +	ret = runtest_f(fd, buf1, offset, count, EFAULT, 16,
>   		      " nonexistant space");
> -	if (ret != 0) {
> -		failed = TRUE;
> -		fail_count++;
> -		tst_resm(TFAIL, "read, write in non-existant space");
> -	} else
> -		tst_resm(TPASS, "read, write in non-existant space");
> +	testcheck_end(ret, &failed, &fail_count,
> +				"read, write in non-existant space");
>   	total++;
>   	close(fd);
>
> @@ -565,12 +533,8 @@ int main(int argc, char *argv[])
>   			 "open(%s, O_DIRECT|O_RDWR|O_SYNC failed)", filename);
>   	}
>   	ret = runtest_s(fd, buf2, offset, count, 17, "opened with O_SYNC");
> -	if (ret != 0) {
> -		failed = TRUE;
> -		fail_count++;
> -		tst_resm(TFAIL, "read, write for file with O_SYNC");
> -	} else
> -		tst_resm(TPASS, "read, write for file with O_SYNC");
> +	testcheck_end(ret, &failed, &fail_count,
> +				"read, write for file with O_SYNC");
>   	total++;
>   	close(fd);
>
>

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
