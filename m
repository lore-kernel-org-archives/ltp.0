Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XKIJB-0004JW-VW
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 02:41:02 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XKIJ9-0003Nf-JI
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 02:41:01 +0000
Date: Wed, 20 Aug 2014 22:40:52 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <1686916829.22340995.1408588852554.JavaMail.zimbra@redhat.com>
In-Reply-To: <53F48DAE.4030704@oracle.com>
References: <970276274.18779164.1407818238974.JavaMail.zimbra@redhat.com>
	<53F48DAE.4030704@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] Skip some dio/fcntl cases on NFS
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Wednesday, August 20, 2014 7:59:42 PM
> Subject: Re: [LTP] [PATCH v2] Skip some dio/fcntl cases on NFS
> 
> Hi!
> 
> Sorry for delay.
> 

No problem. :)

Thanks for reviewing!

> On 08/12/2014 08:37 AM, Xiong Zhou wrote:
> >
> > According to description of NFS and directIO in open(2), especially
> > "The Linux NFS client places no alignment restrictions on
> > O_DIRECT I/O", ignore "odd count"/"non-aligned" read-write FAILs
> > in diotest4. Some dup code clean up btw.
> 
> I think it would be better to split the logic and cleanup parts into
> separate patches, because both parts are not small.
> 

Yes, It should be split. So does the change of different files.

> 
> >
> > According to nfs(5), NLM supports advisory file locks only. So skip
> > fcntl16 test if NFS.
> >
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> >   testcases/kernel/io/direct_io/diotest4.c  | 148
> >   ++++++++++++++----------------
> >   testcases/kernel/syscalls/fcntl/fcntl16.c |   8 ++
> >   2 files changed, 79 insertions(+), 77 deletions(-)
> >
> > diff --git a/testcases/kernel/io/direct_io/diotest4.c
> > b/testcases/kernel/io/direct_io/diotest4.c
> > index 10281bf..934d5b1 100644
> > --- a/testcases/kernel/io/direct_io/diotest4.c
> > +++ b/testcases/kernel/io/direct_io/diotest4.c
> > @@ -71,9 +71,11 @@
> >
> >   #include "test.h"
> >   #include "usctest.h"
> > +#include "tst_fs_type.h"
> >
> >   char *TCID = "diotest4";	/* Test program identifier.    */
> >   int TST_TOTAL = 17;		/* Total number of test conditions */
> > +int NO_NFS = 1;			/* Test on NFS or not */
> >
> >   #ifdef O_DIRECT
> >
> > @@ -171,6 +173,16 @@ void prg_usage()
> >   	exit(1);
> >   }
> >
> > +static void testcheck_end(int ret, int *failed, int *fail_count, char
> > *msg)
> > +{
> > +	if (ret != 0) {
> > +		*failed = TRUE;
> > +		*fail_count++;
> > +		tst_resm(TFAIL, msg);
> > +	} else
> > +		tst_resm(TPASS, msg);
> > +}
> > +
> >   static void setup(void);
> >   static void cleanup(void);
> >   static int fd1 = -1;
> > @@ -206,6 +218,10 @@ int main(int argc, char *argv[])
> >
> >   	setup();
> >
> > +	/* On NFS or not */
> > +	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC)
> > +		NO_NFS = 0;
> > +
> 
> Maybe put it to setup(). IMHO, it's logically coupled with setup().
> 

OK, It does and it meets the 'Unless' part of libltp guideline 3 in doc/style-guide.txt.

> >   	/* Open file and fill, allocate for buffer */
> >   	if ((fd = open(filename, O_DIRECT | O_RDWR | O_CREAT, 0666)) < 0) {
> >   		tst_brkm(TBROK, cleanup, "open failed for %s: %s",
> > @@ -251,17 +267,41 @@ int main(int argc, char *argv[])
> >   	/* Test-3: Odd count of read and write */
> >   	offset = 0;
> >   	count = 1;
> > +	l_fail = 0;
> >   	lseek(fd, 0, SEEK_SET);
> >   	if (write(fd, buf2, 4096) == -1) {
> >   		tst_resm(TFAIL, "can't write to file %d", ret);
> >   	}
> > -	ret = runtest_f(fd, buf2, offset, count, EINVAL, 3, "odd count");
> > -	if (ret != 0) {
> > -		failed = TRUE;
> > -		fail_count++;
> > -		tst_resm(TFAIL, "Odd count of read and write");
> > -	} else
> > -		tst_resm(TPASS, "Odd count of read and write");
> > +	if (lseek(fd, offset, SEEK_SET) < 0) {
> > +		if (errno != EINVAL) {
> > +			tst_resm(TFAIL, "lseek before read failed: %s",
> > +				 strerror(errno));
> > +			l_fail = TRUE;
> > +		}
> > +	} else {
> > +		ret = read(fd, buf2, count);
> > +		if ((ret >= 0 || errno != EINVAL) && NO_NFS) {
> > +			tst_resm(TFAIL, "read allows %s. returns %d: %s",
> > +				 "odd count", ret, strerror(errno));
> > +			l_fail = TRUE;
> > +		}
> > +	}
> > +	if (lseek(fd, offset, SEEK_SET) < 0) {
> > +		if (errno != EINVAL) {
> > +			tst_resm(TFAIL, "lseek before write failed: %s",
> > +				 strerror(errno));
> > +			l_fail = TRUE;
> > +		}
> > +	} else {
> > +		ret = write(fd, buf2, count);
> > +		if ((ret >= 0 || errno != EINVAL) && NO_NFS) {
> > +			tst_resm(TFAIL, "write allows %s.returns %d: %s",
> > +				 "odd count", ret, strerror(errno));
> > +			l_fail = TRUE;
> > +		}
> > +	}
> > +	testcheck_end(l_fail, &failed, &fail_count,
> > +				"Odd count of read and write");
> 
> You copied code from runtest_f(). I suppose it's easier to skip this
> entire test case on NFS, than skipping only write() and read() failures.
> Like:
> 
> offset = 0;
> count = 1;
> lseek(fd, 0, SEEK_SET);
> if (write(...)) {
>     ...
> }
> if (NO_NFS) {
>     ret = runtest_f();
>     testcheck_end();
> } else {
>     tst_resm(TCONF, "Statement that this test case is not applicable to
> NFS");
> }
> total++;

OK, This is better and more concise.


> 
> >   	total++;
> >
> >   	/* Test-4: Read beyond the file size */
> > @@ -290,12 +330,7 @@ int main(int argc, char *argv[])
> >   	count = bufsize;
> >   	newfd = -1;
> >   	ret = runtest_f(newfd, buf2, offset, count, EBADF, 5, "negative fd");
> > -	if (ret != 0) {
> > -		failed = TRUE;
> > -		fail_count++;
> > -		tst_resm(TFAIL, "Invalid file descriptor");
> > -	} else
> > -		tst_resm(TPASS, "Invalid file descriptor");
> > +	testcheck_end(ret, &failed, &fail_count, "Invalid file descriptor");
> >   	total++;
> >
> >   	/* Test-6: Out of range file descriptor */
> > @@ -306,15 +341,10 @@ int main(int argc, char *argv[])
> >   		failed = TRUE;
> >   		tst_resm(TFAIL, "Out of range file descriptor");
> >   	} else {
> > -		ret =
> > -		    runtest_f(newfd, buf2, offset, count, EBADF, 6,
> > +		ret = runtest_f(newfd, buf2, offset, count, EBADF, 6,
> >   			      "out of range fd");
> > -		if (ret != 0) {
> > -			failed = TRUE;
> > -			fail_count++;
> > -			tst_resm(TFAIL, "Out of range file descriptor");
> > -		} else
> > -			tst_resm(TPASS, "Out of range file descriptor");
> > +		testcheck_end(ret, &failed, &fail_count,
> > +					"Out of range file descriptor");
> >   	}
> >   	close(newfd);
> >   	total++;
> > @@ -327,12 +357,7 @@ int main(int argc, char *argv[])
> >   			 strerror(errno));
> >   	}
> >   	ret = runtest_f(fd, buf2, offset, count, EBADF, 7, "closed fd");
> > -	if (ret != 0) {
> > -		failed = TRUE;
> > -		fail_count++;
> > -		tst_resm(TFAIL, "Closed file descriptor");
> > -	} else
> > -		tst_resm(TPASS, "Closed file descriptor");
> > +	testcheck_end(ret, &failed, &fail_count, "Closed file descriptor");
> >   	total++;
> >
> >   	/* Test-9: removed */
> > @@ -345,12 +370,8 @@ int main(int argc, char *argv[])
> >   		tst_resm(TCONF, "Direct I/O on /dev/null is not supported");
> >   	} else {
> >   		ret = runtest_s(newfd, buf2, offset, count, 9, "/dev/null");
> > -		if (ret != 0) {
> > -			failed = TRUE;
> > -			fail_count++;
> > -			tst_resm(TFAIL, "character device read, write");
> > -		} else
> > -			tst_resm(TPASS, "character device read, write");
> > +		testcheck_end(ret, &failed, &fail_count,
> > +					"character device read, write");
> >   	}
> >   	close(newfd);
> >   	total++;
> > @@ -373,12 +394,8 @@ int main(int argc, char *argv[])
> >   			 strerror(errno));
> >   	}
> >   	ret = runtest_s(fd, buf2, offset, count, 10, "mmapped file");
> > -	if (ret != 0) {
> > -		failed = TRUE;
> > -		fail_count++;
> > -		tst_resm(TFAIL, "read, write to a mmaped file");
> > -	} else
> > -		tst_resm(TPASS, "read, write to a mmaped file");
> > +	testcheck_end(ret, &failed, &fail_count,
> > +				"read, write to a mmaped file");
> >   	total++;
> >
> >   	/* Test-11: read, write to an unmaped file with munmap */
> > @@ -387,12 +404,8 @@ int main(int argc, char *argv[])
> >   			 strerror(errno));
> >   	}
> >   	ret = runtest_s(fd, buf2, offset, count, 11, "unmapped file");
> > -	if (ret != 0) {
> > -		failed = TRUE;
> > -		fail_count++;
> > -		tst_resm(TFAIL, "read, write to an unmapped file");
> > -	} else
> > -		tst_resm(TPASS, "read, write to an unmapped file");
> > +	testcheck_end(ret, &failed, &fail_count,
> > +				"read, write to an unmapped file");
> >   	close(fd);
> >   	total++;
> >
> > @@ -459,7 +472,7 @@ int main(int argc, char *argv[])
> >   			 strerror(errno));
> >   		l_fail = TRUE;
> >   	} else {
> > -		if ((ret = read(fd, buf2 + 1, count)) != -1) {
> > +		if (((ret = read(fd, buf2 + 1, count)) != -1) && NO_NFS) {
> >   			tst_resm(TFAIL,
> >   				 "allows read nonaligned buf. returns %d: %s",
> >   				 ret, strerror(errno));
> > @@ -471,19 +484,15 @@ int main(int argc, char *argv[])
> >   			 strerror(errno));
> >   		l_fail = TRUE;
> >   	} else {
> > -		if ((ret = write(fd, buf2 + 1, count)) != -1) {
> > +		if (((ret = write(fd, buf2 + 1, count)) != -1) && NO_NFS) {
> >   			tst_resm(TFAIL,
> >   				 "allows write nonaligned buf. returns %d: %s",
> >   				 ret, strerror(errno));
> >   			l_fail = TRUE;
> >   		}
> >   	}
> > -	if (l_fail) {
> > -		failed = TRUE;
> > -		fail_count++;
> > -		tst_resm(TFAIL, "read, write with non-aligned buffer");
> > -	} else
> > -		tst_resm(TPASS, "read, write with non-aligned buffer");
> > +	testcheck_end(l_fail, &failed, &fail_count,
> > +				"read, write with non-aligned buffer");
> 
> Could we use runtest_f(EINVAL) here for Test-14 and apply the algorithm
> I described above for Test-3?
> 

Of course.

Thanks for reviewing!

Regards,
xzhou

> 
> >   	total++;
> >   	close(fd);
> >
> > @@ -500,8 +509,7 @@ int main(int argc, char *argv[])
> >   			 strerror(errno));
> >   		l_fail = TRUE;
> >   	} else {
> > -		ret =
> > -		    read(fd, (char *)((ulong) ADDRESS_OF_MAIN & pagemask),
> > +		ret = read(fd, (char *)((ulong) ADDRESS_OF_MAIN & pagemask),
> >   			 count);
> >   		if (ret >= 0 || errno != EFAULT) {
> >   			tst_resm(TFAIL,
> > @@ -515,8 +523,7 @@ int main(int argc, char *argv[])
> >   			 strerror(errno));
> >   		l_fail = TRUE;
> >   	} else {
> > -		ret =
> > -		    write(fd, (char *)((ulong) ADDRESS_OF_MAIN & pagemask),
> > +		ret = write(fd, (char *)((ulong) ADDRESS_OF_MAIN & pagemask),
> >   			  count);
> >   		if (ret < 0) {
> >   			tst_resm(TFAIL,
> > @@ -525,12 +532,8 @@ int main(int argc, char *argv[])
> >   			l_fail = TRUE;
> >   		}
> >   	}
> > -	if (l_fail) {
> > -		failed = TRUE;
> > -		fail_count++;
> > -		tst_resm(TFAIL, "read, write buffer in read-only space");
> > -	} else
> > -		tst_resm(TPASS, "read, write buffer in read-only space");
> > +	testcheck_end(l_fail, &failed, &fail_count,
> > +				"read, write buffer in read-only space");
> >   	close(fd);
> >   	total++;
> >
> > @@ -545,15 +548,10 @@ int main(int argc, char *argv[])
> >   		tst_brkm(TBROK | TERRNO, cleanup,
> >   			 "open(%s, O_DIRECT|O_RDWR) failed", filename);
> >   	}
> > -	ret =
> > -	    runtest_f(fd, buf1, offset, count, EFAULT, 16,
> > +	ret = runtest_f(fd, buf1, offset, count, EFAULT, 16,
> >   		      " nonexistant space");
> > -	if (ret != 0) {
> > -		failed = TRUE;
> > -		fail_count++;
> > -		tst_resm(TFAIL, "read, write in non-existant space");
> > -	} else
> > -		tst_resm(TPASS, "read, write in non-existant space");
> > +	testcheck_end(ret, &failed, &fail_count,
> > +				"read, write in non-existant space");
> >   	total++;
> >   	close(fd);
> >
> > @@ -565,12 +563,8 @@ int main(int argc, char *argv[])
> >   			 "open(%s, O_DIRECT|O_RDWR|O_SYNC failed)", filename);
> >   	}
> >   	ret = runtest_s(fd, buf2, offset, count, 17, "opened with O_SYNC");
> > -	if (ret != 0) {
> > -		failed = TRUE;
> > -		fail_count++;
> > -		tst_resm(TFAIL, "read, write for file with O_SYNC");
> > -	} else
> > -		tst_resm(TPASS, "read, write for file with O_SYNC");
> > +	testcheck_end(ret, &failed, &fail_count,
> > +				"read, write for file with O_SYNC");
> >   	total++;
> >   	close(fd);
> >
> > diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c
> > b/testcases/kernel/syscalls/fcntl/fcntl16.c
> > index 44b6a80..7dba6ea 100644
> > --- a/testcases/kernel/syscalls/fcntl/fcntl16.c
> > +++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
> > @@ -51,6 +51,8 @@
> >   #include <sys/types.h>
> >   #include <sys/wait.h>
> >
> > +#include "tst_fs_type.h"
> > +
> >   #define SKIPVAL 0x0f00
> >   //#define       SKIP    SKIPVAL, 0, 0L, 0L, IGNORED
> >   #define SKIP 0,0,0L,0L,0
> > @@ -412,6 +414,12 @@ void setup(void)
> >
> >   	tst_tmpdir();
> >
> > +	/* On NFS or not */
> > +	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
> > +		tst_brkm(TCONF, cleanup, "Cannot test madatory locking "
> > +			"on a file located on an NFS filesystem");
> > +	}
> > +
> >   	/* set up temp filename */
> >   	sprintf(tmpname, "fcntl4.%d", parent);
> >
> >
> 
> ------------------------------------------------------------------------------
> Slashdot TV.
> Video for Nerds.  Stuff that matters.
> http://tv.slashdot.org/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
