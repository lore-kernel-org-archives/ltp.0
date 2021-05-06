From: zhaogongyi <zhaogongyi@huawei.com>
Date: Thu, 6 May 2021 05:06:06 +0000
Subject: [LTP] [PATCH 4/4] syscalls/fcntl: Replace TINFO with TPASS or
 TFAIL
Message-ID: <b27402acadd9426489bc82d6a1697978@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I am very sorry for my fault, I will check the patch format before send out in the future, thanks for your review!

I have resubmit the patch and corrected the error.

Thanks so much!

Best Regards,
Gongyi

> 
> Hi!
> > 1)remove redundant variable
> > 2)remove redundant log
> > 3)replace TINFO with TPASS or TFAIL
> >
> > For those:
> > 	testcases/kernel/syscalls/fcntl/fcntl16.c
> > 	testcases/kernel/syscalls/fcntl/fcntl18.c
> 
> First of all it looks like the patch got corrupted, possibly by your email
> client, there is a missing space somewhere in the middle of the patch
> which prevents it from being applied.
> 
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  testcases/kernel/syscalls/fcntl/fcntl16.c | 70
> > +++++++----------------  testcases/kernel/syscalls/fcntl/fcntl18.c |
> > 40 ++-----------
> >  2 files changed, 27 insertions(+), 83 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c
> > b/testcases/kernel/syscalls/fcntl/fcntl16.c
> > index a77a81298..04d86202c 100644
> > --- a/testcases/kernel/syscalls/fcntl/fcntl16.c
> > +++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
> > @@ -441,7 +441,7 @@ void setup(void)
> >  	sigaction(SIGALRM, &sact, NULL);
> >  }
> >
> > -int run_test(int file_flag, int file_mode, int start, int end)
> > +static void run_test(int file_flag, int file_mode, int start, int
> > +end)
> >  {
> >  	int child_count;
> >  	int child;
> > @@ -468,7 +468,7 @@ int run_test(int file_flag, int file_mode, int start,
> int end)
> >  				 errno);
> >  			close(fd);
> >  			unlink(tmpname);
> > -			return 1;
> > +			goto err;
> >  		}
> >
> >  		/* Initialize second parent lock structure */ @@ -482,7 +482,7
> @@
> > int run_test(int file_flag, int file_mode, int start, int end)
> >  					 test + 1, errno);
> >  				close(fd);
> >  				unlink(tmpname);
> > -				return 1;
> > +				goto err;
> >  			}
> >  		}
> >
> > @@ -502,7 +502,7 @@ int run_test(int file_flag, int file_mode, int start,
> int end)
> >  					if (self_exec(argv0, "ddddd", i, parent,
> >  						      test, thislock, fd) < 0) {
> >  						perror("self_exec failed");
> > -						return 1;
> > +						goto err;
> > 					}
> >  #else
> >  					dochild(i);
> > @@ -510,7 +510,7 @@ int run_test(int file_flag, int file_mode, int start,
> int end)
> >  				}
> >  				if (child < 0) {
> >  					perror("Fork failed");
> > -					return 1;
> > +					goto err;
> >  				}
> >  				child_count++;
> >  				child_pid[i] = child;
> > @@ -553,7 +553,7 @@ int run_test(int file_flag, int file_mode, int start,
> int end)
> >  				 test + 1, errno);
> >  			close(fd);
> >  			unlink(tmpname);
> > -			return 1;
> > +			goto err;
> >  		}
> >
> >  		/* Initialize fourth parent lock structure */ @@ -567,7 +567,7
> @@
> > int run_test(int file_flag, int file_mode, int start, int end)
> >  					 test + 1, errno);
> >  				close(fd);
> >  				unlink(tmpname);
> > -				return 1;
> > +				goto err;
> >  			}
> >  		}
> >
> > @@ -640,12 +640,16 @@ int run_test(int file_flag, int file_mode, int
> start, int end)
> >  		close(fd);
> >  	}
> >  	unlink(tmpname);
> > -	if (fail) {
> > -		return 1;
> > -	} else {
> > -		return 0;
> > +
> > +	if (!fail) {
> > +		tst_resm(TPASS, "locking test successed");
> > +		return;
> >  	}
> > -	return 0;
> > +err:
> > +	if (file_mode & S_ISGID && !NO_NFS)
> > +		tst_resm(TCONF, "NFS does not support mandatory locking");
> > +	else
> > +		tst_resm(TFAIL, "locking test failed");
> 
> This does not help at all, we print TFAIL messages before we do goto err, so
> this would be still a failed test.
> 
> Looking at the code we should rather skip the test in the main instead as it
> was done in the original code as:
> 
> 	if (NO_NFS)
> 		run_test(...);
> 	else
> 		tst_resm(TCONF, "Skipping mandatory locking on NFS");
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
