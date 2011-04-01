Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q5fDX-0004nj-Fx
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 14:20:51 +0000
Date: Fri, 1 Apr 2011 16:44:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110401144407.GA24854@saboteur.suse.cz>
References: <1301233261-25499-1-git-send-email-czhang@redhat.com>
	<1301235188-26579-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1301235188-26579-1-git-send-email-czhang@redhat.com>
Subject: Re: [LTP] [PATCH] [syscalls] io_submit: fix broken testcase
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
To: czhang@redhat.com
Cc: ltp-list@lists.sourceforge.net, emcnabb@redhat.com

Hi!
> +		/* EINVAL-2: invalid nr */
> +		expected_return = -EINVAL;
> +		rval = io_setup(1, &ctx);
> +		if (rval != 0)
> +			tst_brkm(TBROK, cleanup, "io_setup failed: %d", rval);
> +		TEST(io_submit(ctx, -1, NULL));
> +		if (TEST_RETURN == 0) {
> +			tst_resm(TFAIL, "call succeeded unexpectedly");
> +		} else if (TEST_RETURN == expected_return) {
> +			tst_resm(TPASS, "expected failure - "
> +				 "returned value = %ld : %s", (-1 * TEST_RETURN),
> +				 strerror(-1 * TEST_RETURN));
> +		} else {
> +			tst_resm(TFAIL, "unexpected returned value - %ld - "
> +				 "expected %ld", TEST_RETURN, expected_return);
> +		}
> +

I would preffer to write a function that does this instead of copying
this code block several times.

>  		TEST(io_submit(ctx, 1, (void *)-1));

Here it should rather be (io_context_t)-1 as the io_context_t is choosen
to be opaque type...

> @@ -116,51 +152,42 @@ int main(int argc, char *argv[])
>  				 "expected %ld", TEST_RETURN, expected_return);
>  		}
>  
> -		/* Special case EFAULT or EINVAL (indetermination)
> -
> -		   The errno depends on the per architecture implementation
> -		   of io_submit. On the architecture using compat_sys_io_submit
> -		   as its implementation, errno is set to -EINVAL. */
> -		{
> -			long expected_fault = -EFAULT;
> -			long expected_inval = -EINVAL;
> -
> -			TEST(io_submit(ctx, 0, (void *)-1));
> -			if (TEST_RETURN == 0)
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> -			else if (TEST_RETURN == expected_fault
> -				   || TEST_RETURN == expected_inval) {
> -				tst_resm(TPASS, "expected failure - "
> -					 "returned value = %ld : %s",
> -					 (-1 * TEST_RETURN),
> -					 strerror(-1 * TEST_RETURN));
> -			} else {
> -				tst_resm(TFAIL,
> -					 "unexpected returned value - %ld - "
> -					 "expected %ld(%s) or %ld(%s)",
> -					 TEST_RETURN, expected_fault,
> -					 strerror(-1 * expected_fault),
> -					 expected_inval,
> -					 strerror(-1 * expected_inval));
> -			}
> -
> +		/*
> +		 * Special case EFAULT or EINVAL (indetermination)
> +		 *
> +		 * The errno depends on the per architecture implementation
> +		 * of io_submit. On the architecture using compat_sys_io_submit
> +		 * as its implementation, errno is set to -EINVAL.
> +		 */
> +		TEST(io_submit(ctx, -1, (void *)-1));

Here too.

> +		if (TEST_RETURN == 0) {
> +			tst_resm(TFAIL, "call succeeded unexpectedly");
> +		} else if (TEST_RETURN == expected_fault
> +			   || TEST_RETURN == expected_inval) {
> +			tst_resm(TPASS, "expected failure - "
> +				 "returned value = %ld : %s",
> +				 (-1 * TEST_RETURN),
> +				 strerror(-1 * TEST_RETURN));
> +		} else {
> +			tst_resm(TFAIL,
> +				 "unexpected returned value - %ld - "
> +				 "expected %ld(%s) or %ld(%s)",
> +				 TEST_RETURN, expected_fault,
> +				 strerror(-1 * expected_fault),
> +				 expected_inval,
> +				 strerror(-1 * expected_inval));
>  		}
>  
>  		/*
> -		   EBADF  The file descriptor specified in the first iocb is invalid.
> +		 * EBADF: The file descriptor specified in the first iocb is invalid.
>  		 */
>  		expected_return = -EBADF;
>  		io_prep_pread(&iocb, -1, (void *)buf, sizeof(buf), 0);

The void cast is not needed here. Generally all pointers in C are
compatible with void * pointer and casted automatically.


>  		iocbs[0] = &iocb;
> -		memset(&ctx, 0, sizeof(io_context_t));
> -		rval = io_setup(1, &ctx);
> -		if (rval != 0)
> -			tst_brkm(TBROK, cleanup, "io_setup failed: %d", rval);
> -
>  		TEST(io_submit(ctx, 1, iocbs));
> -		if (TEST_RETURN == 0)
> +		if (TEST_RETURN == 0) {
>  			tst_resm(TFAIL, "call succeeded unexpectedly");
> -		else if (TEST_RETURN == expected_return) {
> +		} else if (TEST_RETURN == expected_return) {
>  			tst_resm(TPASS, "expected failure - "
>  				 "returned value = %ld : %s", (-1 * TEST_RETURN),
>  				 strerror(-1 * TEST_RETURN));
> @@ -168,6 +195,34 @@ int main(int argc, char *argv[])
>  			tst_resm(TFAIL, "unexpected returned value - %ld - "
>  				 "expected %ld", TEST_RETURN, expected_return);
>  		}
> +
> +		/* positive test: nr == 0 */
> +		TEST(io_submit(ctx, 0, NULL));
> +		if (TEST_RETURN == 0) {
> +			tst_resm(TPASS, "call succeeded expectedly");
> +		} else {
> +			tst_resm(TFAIL, "unexpected failure - "
> +				 "returned value = %ld : %s", (-1 * TEST_RETURN),
> +				 strerror(-1 * TEST_RETURN));
> +		}
> +
> +		/* positive test: valid fd */
> +		fd = open("/etc/fstab", O_RDONLY);

Hmm, I would preffer to create temporary file for this rather than
relying on that some magical file exists in system.


> +		if (fd == -1)
> +			tst_resm(TBROK, "open /etc/fstab fail");
> +		io_prep_pread(&iocb, fd, (void *)buf, sizeof(buf), 0);

The cast again.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
