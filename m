From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Mar 2017 10:53:13 +0100
Subject: [LTP] [PATCH 1/1] lib: use tst_exit() instead of exit()
In-Reply-To: <20170316112359.8642-1-pvorel@suse.cz>
References: <20170316112359.8642-1-pvorel@suse.cz>
Message-ID: <20170320095313.GB2711@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm sorry for not important commit. It's more for me to understand whether
> tst_exit() should be used only for normal tests, or also for lib's tests or
> even in lib itself.

The answer here is that we do not care in these cases. The difference
between exit() and tst_exit() is that tst_exit() exits with correct exit
value (bitflags stored in the test library) when tst_res() is used to
report test results. And since the exit value from the code changed
below is not used the difference is merely cosmetic.

> diff --git a/lib/parse_opts.c b/lib/parse_opts.c
> index 3a879e44e..1af8e9a6e 100644
> --- a/lib/parse_opts.c
> +++ b/lib/parse_opts.c
> @@ -618,7 +618,7 @@ int main(int argc, char **argv)
>  
>  	TEST_CLEANUP;
>  
> -	exit(0);
> +	tst_exit();
>  }

This is ifdefed out testing code for the parse_opts() function, we
should rather remove it since it's not compiled by default...

>  #endif /* UNIT_TEST */
> diff --git a/lib/random_range.c b/lib/random_range.c
> index 510a4a1ff..c2534e0c7 100644
> --- a/lib/random_range.c
> +++ b/lib/random_range.c
> @@ -706,7 +706,7 @@ char **argv;
>  			}
>  		}
>  	}
> -	exit(0);
> +	tst_exit();
>  }
>  
>  #endif /* end if RANDOM_BIT_UNITTEST */
> @@ -886,7 +886,7 @@ char **argv;
>  
>  	}
>  
> -	exit(0);
> +	tst_exit();
>  }

This is the same case.

>  #endif
> diff --git a/lib/tests/tst_checkpoint.c b/lib/tests/tst_checkpoint.c
> index 2cb17a5f7..7008171db 100644
> --- a/lib/tests/tst_checkpoint.c
> +++ b/lib/tests/tst_checkpoint.c
> @@ -55,5 +55,5 @@ int main(void)
>  
>  	wait(NULL);
>  	tst_rmdir();
> -	return 0;
> +	tst_exit();
>  }
> diff --git a/lib/tests/tst_checkpoint_wait_timeout.c b/lib/tests/tst_checkpoint_wait_timeout.c
> index c5fae670e..eb69565c2 100644
> --- a/lib/tests/tst_checkpoint_wait_timeout.c
> +++ b/lib/tests/tst_checkpoint_wait_timeout.c
> @@ -54,5 +54,5 @@ int main(void)
>  	break;
>  	}
>  
> -	return 0;
> +	tst_exit();
>  }
> diff --git a/lib/tests/tst_checkpoint_wake_timeout.c b/lib/tests/tst_checkpoint_wake_timeout.c
> index 8af1feb18..6a71d80b6 100644
> --- a/lib/tests/tst_checkpoint_wake_timeout.c
> +++ b/lib/tests/tst_checkpoint_wake_timeout.c
> @@ -37,5 +37,5 @@ int main(void)
>  	TST_SAFE_CHECKPOINT_WAKE(tst_rmdir, 0);
>  	fprintf(stderr, "Parent: checkpoint reached\n");
>  
> -	return 0;
> +	tst_exit();
>  }
> diff --git a/lib/tests/tst_cleanup_once.c b/lib/tests/tst_cleanup_once.c
> index 328ed7492..73ac88db1 100644
> --- a/lib/tests/tst_cleanup_once.c
> +++ b/lib/tests/tst_cleanup_once.c
> @@ -43,5 +43,5 @@ int main(void)
>  	cleanup();
>  	cleanup();
>  
> -	return 0;
> +	tst_exit();
>  }
> diff --git a/lib/tests/tst_dataroot01.c b/lib/tests/tst_dataroot01.c
> index fab8bfea2..e4d8a3875 100644
> --- a/lib/tests/tst_dataroot01.c
> +++ b/lib/tests/tst_dataroot01.c
> @@ -51,4 +51,3 @@ int main(void)
>  
>  	tst_exit();
>  }
> -
> diff --git a/lib/tests/tst_process_state.c b/lib/tests/tst_process_state.c
> index dd4f0535d..33b87c569 100644
> --- a/lib/tests/tst_process_state.c
> +++ b/lib/tests/tst_process_state.c
> @@ -59,7 +59,7 @@ int main(void)
>  
>  		fprintf(stderr, "Child woken up\n");
>  
> -		return 0;
> +		tst_exit();
>  		break;
>  	default:
>  		/* Wait for child to sleep */
> @@ -71,5 +71,5 @@ int main(void)
>  	}
>  
>  	wait(NULL);
> -	return 0;
> +	tst_exit();
>  }
> diff --git a/lib/tests/tst_safe_macros.c b/lib/tests/tst_safe_macros.c
> index b5809f40d..6a417eff5 100644
> --- a/lib/tests/tst_safe_macros.c
> +++ b/lib/tests/tst_safe_macros.c
> @@ -36,5 +36,5 @@ int main(int argc LTP_ATTRIBUTE_UNUSED, char **argv)
>  	SAFE_WRITE(NULL, 1, fd, buf, 9);
>  	SAFE_PIPE(NULL, fds);
>  
> -	return 0;
> +	tst_exit();
>  }
> diff --git a/lib/tests/tst_strerrno.c b/lib/tests/tst_strerrno.c
> index dbee7642f..e9ad39cfd 100644
> --- a/lib/tests/tst_strerrno.c
> +++ b/lib/tests/tst_strerrno.c
> @@ -31,5 +31,5 @@ int main(void)
>  {
>  	fprintf(stderr, "0 = %s\n", tst_strerrno(0));
>  	fprintf(stderr, "EINVAL = %s\n", tst_strerrno(EINVAL));
> -	return 0;
> +	tst_exit();
>  }
> diff --git a/lib/tests/tst_strsig.c b/lib/tests/tst_strsig.c
> index 9a5ca80aa..d0b2184f2 100644
> --- a/lib/tests/tst_strsig.c
> +++ b/lib/tests/tst_strsig.c
> @@ -31,5 +31,5 @@ int main(void)
>  {
>  	fprintf(stderr, "SIGKILL = %s\n", tst_strsig(SIGKILL));
>  	fprintf(stderr, "SIGALRM = %s\n", tst_strsig(SIGALRM));
> -	return 0;
> +	tst_exit();
>  }
> diff --git a/lib/tests/tst_tmpdir_test.c b/lib/tests/tst_tmpdir_test.c
> index f394893a4..f58afc26a 100644
> --- a/lib/tests/tst_tmpdir_test.c
> +++ b/lib/tests/tst_tmpdir_test.c
> @@ -80,5 +80,5 @@ int main(void)
>  	else
>  		printf("Test completed successfully!\n");
>  
> -	return 0;
> +	tst_exit();
>  }

We can apply these since we should be using tst_exit() there, but in
practice it does not matter, since we are not executing these in LTP run
and hence the test exit value is not used at all.

-- 
Cyril Hrubis
chrubis@suse.cz
