From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Nov 2017 14:45:23 +0100
Subject: [LTP] [PATCH v2] kernel/input: fix failure on an old kernel
In-Reply-To: <1510137430-25555-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20171107142043.GA32659@rei.lan>
 <1510137430-25555-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20171109134523.GA23734@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * the value of sync_events_ignored:
> + * 0: cannot ignore EV_SYN/SYN_REPORT events received in /dev/input/eventX
> + * 1: ignore EV_SYN/SYN_REPORT events received in /dev/input/eventX
> + * On an old kernel(before v3.7.0), EV_SYN/SYN_REPORT events are always
> + * received even though we send empty moves.
> + */
> +int no_events_queued(int fd, int sync_events_ignored)
>  {
>  	struct pollfd fds = {.fd = fd, .events = POLLIN};
>  	int ret, res;
> @@ -241,9 +248,14 @@ int no_events_queued(int fd)
>  		res = read(fd, &ev, sizeof(ev));
>  
>  		if (res == sizeof(ev)) {
> -			tst_resm(TINFO,
> -			         "Unexpected ev type=%i code=%i value=%i",
> -			         ev.type, ev.code, ev.value);
> +			if (sync_events_ignored && !ev.type &&
> +			    !ev.code && !ev.value) {

The ev.value is undefined for sync events, it's 0 most of the time but I
remember that we had to fix the input06.c because it was failing for
somebody, see check_sync_event() there. Maybe we should just move the
check_event* and check_sync_event() helpers to the library so that we
can use them here as well.

> +				ret = 0;
> +			} else {
> +				tst_resm(TINFO,
> +					 "Unexpected ev type=%i code=%i value=%i",
> +					 ev.type, ev.code, ev.value);
> +			}
>  		}
>  	}
>  
> @@ -264,7 +276,40 @@ static int check_device(void)
>  			return 1;
>  	}
>  
> +
  ^
  Please do not add useless empty lines.

>  	fclose(file);
>  
>  	return 0;
>  }
> +
> +/*
> + * Use this function to check if the current kernel can get single
> + * EV_SYN/SYN_REPORT events.
> + */
> +int check_single_sync_event(int fd1, int fd2)
> +{
> +	pid_t pid;
> +	struct pollfd fds = {.fd = fd2, .events = POLLIN};
> +	struct input_event ev;
> +	int ret, ignored;
> +
> +	pid = tst_fork();
> +
> +	if (pid == -1)
> +		tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
> +
> +	if (!pid) {
> +		send_event(fd1, EV_SYN, 0, 0);
> +		exit(0);
> +	}
> +
> +	ret = poll(&fds, 1, 30);
> +	if (ret > 0 && SAFE_READ(NULL, 1, fd2, &ev, sizeof(ev)) == sizeof(ev)) {
> +		if (!ev.type && !ev.code && !ev.value)
> +			ignored = 1;
> +	}
> +
> +	SAFE_WAITPID(NULL, pid, NULL, 0);
> +
> +	return ignored;
> +}

This still does not fix the problem. Even if new kernel started to
produce stray sync events these testcases will still pass. What I think
is a good solution is simply to define first fixed kernel version and
expect that no stray sync events are produced on newer kernels.

> diff --git a/testcases/kernel/input/input_helper.h b/testcases/kernel/input/input_helper.h
> index 9b85dc9..1ef4d32 100644
> --- a/testcases/kernel/input/input_helper.h
> +++ b/testcases/kernel/input/input_helper.h
> @@ -29,6 +29,7 @@ int open_uinput(void);
>  void create_device(int fd);
>  void setup_mouse_events(int fd);
>  void destroy_device(int fd);
> -int no_events_queued(int fd);
> +int no_events_queued(int fd, int sync_events_ignored);
> +int check_single_sync_event(int fd1, int fd2);
>  
>  #endif /* INPUT_HELPER_H */
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
