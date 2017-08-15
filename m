From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Aug 2017 15:33:50 +0200
Subject: [LTP] [PATCH v3 2/3] fanotify: rewrite old cases with new lib
In-Reply-To: <1502719311-18774-3-git-send-email-xzhou@redhat.com>
References: <20170811084138.GA3341@rei.lan>
 <1502719311-18774-1-git-send-email-xzhou@redhat.com>
 <1502719311-18774-3-git-send-email-xzhou@redhat.com>
Message-ID: <20170815133350.GC30800@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
> index 4799d54..bca0f47 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify01.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
> @@ -35,12 +35,9 @@
>  #include <errno.h>
>  #include <string.h>
>  #include <sys/syscall.h>
> -#include "test.h"
> -#include "lapi/syscalls.h"
> +#include "tst_test.h"
>  #include "fanotify.h"
> -#include "safe_macros.h"
>  
> -char *TCID = "fanotify01";
>  int TST_TOTAL = 12;

Can we declare this to be macro instead?

Otherwise it looks like we left old library leftovers here.

>  #if defined(HAVE_SYS_FANOTIFY_H)
> @@ -52,9 +49,6 @@ int TST_TOTAL = 12;
>  /* reasonable guess as to size of 1024 events */
>  #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
>  
> -static void setup(void);
> -static void cleanup(void);
> -
>  #define BUF_SIZE 256
>  static char fname[BUF_SIZE];
>  static char buf[BUF_SIZE];
> @@ -64,308 +58,282 @@ static unsigned long long event_set[EVENT_MAX];
>  
>  static char event_buf[EVENT_BUF_LEN];
>  
> -int main(int ac, char **av)
> +void test01(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		int ret, len, i = 0, test_num = 0;
> -
> -		tst_count = 0;
> -
> -		if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS | FAN_MODIFY |
> -				    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
> -			    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
> -			    "failed", fd_notify, fname);
> -		}
> -
> -		/*
> -		 * generate sequence of events
> -		 */
> -		fd = SAFE_OPEN(cleanup, fname, O_RDONLY);
> -		event_set[tst_count] = FAN_OPEN;
> -		tst_count++;
> -
> -		SAFE_READ(cleanup, 0, fd, buf, BUF_SIZE);
> -		event_set[tst_count] = FAN_ACCESS;
> -		tst_count++;
> -
> -		SAFE_CLOSE(cleanup, fd);
> -		event_set[tst_count] = FAN_CLOSE_NOWRITE;
> -		tst_count++;
> -
> -		/*
> -		 * Get list of events so far. We get events here to avoid
> -		 * merging of following events with the previous ones.
> -		 */
> -		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf, EVENT_BUF_LEN);
> -		len = ret;
> -
> -		fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
> -		event_set[tst_count] = FAN_OPEN;
> -		tst_count++;
> -
> -		SAFE_WRITE(cleanup, 1, fd, fname, strlen(fname));
> -		event_set[tst_count] = FAN_MODIFY;
> -		tst_count++;
> -
> -		SAFE_CLOSE(cleanup, fd);
> -		event_set[tst_count] = FAN_CLOSE_WRITE;
> -		tst_count++;
> +	int ret, len, i = 0, test_num = 0;
>  
> -		/*
> -		 * get another list of events
> -		 */
> -		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
> -				EVENT_BUF_LEN - len);
> -		len += ret;
> -
> -		/*
> -		 * Ignore mask testing
> -		 */
> -
> -		/* Ignore access events */
> -		if (fanotify_mark(fd_notify,
> -				    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK,
> -				    FAN_ACCESS, AT_FDCWD, fname) < 0) {
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -			     "fanotify_mark (%d, FAN_MARK_ADD | "
> -			     "FAN_MARK_IGNORED_MASK, FAN_ACCESS, "
> -			     "AT_FDCWD, %s) failed", fd_notify, fname);
> -		}
> -
> -		fd = SAFE_OPEN(cleanup, fname, O_RDWR);
> -		event_set[tst_count] = FAN_OPEN;
> -		tst_count++;
> -
> -		/* This event should be ignored */
> -		SAFE_READ(cleanup, 0, fd, buf, BUF_SIZE);
> +	int tst_count = 0;
>  
> -		/*
> -		 * get another list of events to verify the last one got ignored
> -		 */
> -		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
> -				EVENT_BUF_LEN - len);
> -		len += ret;
> -
> -		lseek(fd, 0, SEEK_SET);
> -		/* Generate modify event to clear ignore mask */
> -		SAFE_WRITE(cleanup, 1, fd, fname, 1);
> -		event_set[tst_count] = FAN_MODIFY;
> -		tst_count++;
> -
> -		/*
> -		 * This event shouldn't be ignored because previous modification
> -		 * should have removed the ignore mask
> -		 */
> -		SAFE_READ(cleanup, 0, fd, buf, BUF_SIZE);
> -		event_set[tst_count] = FAN_ACCESS;
> -		tst_count++;
> -
> -		SAFE_CLOSE(cleanup, fd);
> -		event_set[tst_count] = FAN_CLOSE_WRITE;
> -		tst_count++;
> -
> -		/* Read events to verify previous access was properly generated */
> -		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
> -				EVENT_BUF_LEN - len);
> -		len += ret;
> +	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS | FAN_MODIFY |
> +			    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
> +		tst_brk(TBROK | TERRNO,
> +		    "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
> +		    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
> +		    "failed", fd_notify, fname);
> +	}
>  
> -		/*
> -		 * Now ignore open & close events regardless of file
> -		 * modifications
> -		 */
> -		if (fanotify_mark(fd_notify,
> -				    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
> -				    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -			     "fanotify_mark (%d, FAN_MARK_ADD | "
> -			     "FAN_MARK_IGNORED_MASK | "
> -			     "FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN | "
> -			     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
> -			     fname);
> -		}
> +	/*
> +	 * generate sequence of events
> +	 */
> +	fd = SAFE_OPEN(fname, O_RDONLY);
> +	event_set[tst_count] = FAN_OPEN;
> +	tst_count++;
> +
> +	SAFE_READ(0, fd, buf, BUF_SIZE);
> +	event_set[tst_count] = FAN_ACCESS;
> +	tst_count++;
> +
> +	SAFE_CLOSE(fd);
> +	event_set[tst_count] = FAN_CLOSE_NOWRITE;
> +	tst_count++;
> +
> +	/*
> +	 * Get list of events so far. We get events here to avoid
> +	 * merging of following events with the previous ones.
> +	 */
> +	ret = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
> +	len = ret;
> +
> +	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
> +	event_set[tst_count] = FAN_OPEN;
> +	tst_count++;
> +
> +	SAFE_WRITE(1, fd, fname, strlen(fname));
> +	event_set[tst_count] = FAN_MODIFY;
> +	tst_count++;
> +
> +	SAFE_CLOSE(fd);
> +	event_set[tst_count] = FAN_CLOSE_WRITE;
> +	tst_count++;
> +
> +	/*
> +	 * get another list of events
> +	 */
> +	ret = SAFE_READ(0, fd_notify, event_buf + len,
> +			EVENT_BUF_LEN - len);
> +	len += ret;
> +
> +	/*
> +	 * Ignore mask testing
> +	 */
> +
> +	/* Ignore access events */
> +	if (fanotify_mark(fd_notify,
> +			    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK,
> +			    FAN_ACCESS, AT_FDCWD, fname) < 0) {
> +		tst_brk(TBROK | TERRNO,
> +		     "fanotify_mark (%d, FAN_MARK_ADD | "
> +		     "FAN_MARK_IGNORED_MASK, FAN_ACCESS, "
> +		     "AT_FDCWD, %s) failed", fd_notify, fname);
> +	}
>  
> -		/* This event should be ignored */
> -		fd = SAFE_OPEN(cleanup, fname, O_RDWR);
> -
> -		SAFE_WRITE(cleanup, 1, fd, fname, 1);
> -		event_set[tst_count] = FAN_MODIFY;
> -		tst_count++;
> -
> -		/* This event should be still ignored */
> -		SAFE_CLOSE(cleanup, fd);
> -
> -		/* This event should still be ignored */
> -		fd = SAFE_OPEN(cleanup, fname, O_RDWR);
> -
> -		/* Read events to verify open & close were ignored */
> -		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
> -				EVENT_BUF_LEN - len);
> -		len += ret;
> -
> -		/* Now remove open and close from ignored mask */
> -		if (fanotify_mark(fd_notify,
> -				    FAN_MARK_REMOVE | FAN_MARK_IGNORED_MASK,
> -				    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -			     "fanotify_mark (%d, FAN_MARK_REMOVE | "
> -			     "FAN_MARK_IGNORED_MASK, FAN_OPEN | "
> -			     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
> -			     fname);
> -		}
> +	fd = SAFE_OPEN(fname, O_RDWR);
> +	event_set[tst_count] = FAN_OPEN;
> +	tst_count++;
> +
> +	/* This event should be ignored */
> +	SAFE_READ(0, fd, buf, BUF_SIZE);
> +
> +	/*
> +	 * get another list of events to verify the last one got ignored
> +	 */
> +	ret = SAFE_READ(0, fd_notify, event_buf + len,
> +			EVENT_BUF_LEN - len);
> +	len += ret;
> +
> +	lseek(fd, 0, SEEK_SET);
> +	/* Generate modify event to clear ignore mask */
> +	SAFE_WRITE(1, fd, fname, 1);
> +	event_set[tst_count] = FAN_MODIFY;
> +	tst_count++;
> +
> +	/*
> +	 * This event shouldn't be ignored because previous modification
> +	 * should have removed the ignore mask
> +	 */
> +	SAFE_READ(0, fd, buf, BUF_SIZE);
> +	event_set[tst_count] = FAN_ACCESS;
> +	tst_count++;
> +
> +	SAFE_CLOSE(fd);
> +	event_set[tst_count] = FAN_CLOSE_WRITE;
> +	tst_count++;
> +
> +	/* Read events to verify previous access was properly generated */
> +	ret = SAFE_READ(0, fd_notify, event_buf + len,
> +			EVENT_BUF_LEN - len);
> +	len += ret;
> +
> +	/*
> +	 * Now ignore open & close events regardless of file
> +	 * modifications
> +	 */
> +	if (fanotify_mark(fd_notify,
> +			    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
> +			    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
> +		tst_brk(TBROK | TERRNO,
> +		     "fanotify_mark (%d, FAN_MARK_ADD | "
> +		     "FAN_MARK_IGNORED_MASK | "
> +		     "FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN | "
> +		     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
> +		     fname);
> +	}
>  
> -		SAFE_CLOSE(cleanup, fd);
> -		event_set[tst_count] = FAN_CLOSE_WRITE;
> -		tst_count++;
> +	/* This event should be ignored */
> +	fd = SAFE_OPEN(fname, O_RDWR);
> +
> +	SAFE_WRITE(1, fd, fname, 1);
> +	event_set[tst_count] = FAN_MODIFY;
> +	tst_count++;
> +
> +	/* This event should be still ignored */
> +	SAFE_CLOSE(fd);
> +
> +	/* This event should still be ignored */
> +	fd = SAFE_OPEN(fname, O_RDWR);
> +
> +	/* Read events to verify open & close were ignored */
> +	ret = SAFE_READ(0, fd_notify, event_buf + len,
> +			EVENT_BUF_LEN - len);
> +	len += ret;
> +
> +	/* Now remove open and close from ignored mask */
> +	if (fanotify_mark(fd_notify,
> +			    FAN_MARK_REMOVE | FAN_MARK_IGNORED_MASK,
> +			    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
> +		tst_brk(TBROK | TERRNO,
> +		     "fanotify_mark (%d, FAN_MARK_REMOVE | "
> +		     "FAN_MARK_IGNORED_MASK, FAN_OPEN | "
> +		     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
> +		     fname);
> +	}
>  
> -		/* Read events to verify close was generated */
> -		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
> -				EVENT_BUF_LEN - len);
> -		len += ret;
> +	SAFE_CLOSE(fd);
> +	event_set[tst_count] = FAN_CLOSE_WRITE;
> +	tst_count++;
>  
> -		if (TST_TOTAL != tst_count) {
> -			tst_brkm(TBROK, cleanup,
> -				 "TST_TOTAL (%d) and tst_count (%d) are not "
> -				 "equal", TST_TOTAL, tst_count);
> -		}
> -		tst_count = 0;
> +	/* Read events to verify close was generated */
> +	ret = SAFE_READ(0, fd_notify, event_buf + len,
> +			EVENT_BUF_LEN - len);
> +	len += ret;
>  
> -		/*
> -		 * check events
> -		 */
> -		while (i < len) {
> -			struct fanotify_event_metadata *event;
> -
> -			event = (struct fanotify_event_metadata *)&event_buf[i];
> -			if (test_num >= TST_TOTAL) {
> -				tst_resm(TFAIL,
> -					 "get unnecessary event: mask=%llx "
> -					 "pid=%u fd=%u",
> -					 (unsigned long long)event->mask,
> -					 (unsigned)event->pid, event->fd);
> -			} else if (!(event->mask & event_set[test_num])) {
> -				tst_resm(TFAIL,
> -					 "get event: mask=%llx (expected %llx) "
> -					 "pid=%u fd=%u",
> +	if (TST_TOTAL != tst_count) {
> +		tst_brk(TBROK,
> +			 "TST_TOTAL (%d) and tst_count (%d) are not "
> +			 "equal", TST_TOTAL, tst_count);
> +	}
> +	tst_count = 0;
> +
> +	/*
> +	 * check events
> +	 */
> +	while (i < len) {
> +		struct fanotify_event_metadata *event;
> +
> +		event = (struct fanotify_event_metadata *)&event_buf[i];
> +		if (test_num >= TST_TOTAL) {
> +			tst_res(TFAIL,
> +				 "get unnecessary event: mask=%llx "
> +				 "pid=%u fd=%u",
> +				 (unsigned long long)event->mask,
> +				 (unsigned)event->pid, event->fd);
> +		} else if (!(event->mask & event_set[test_num])) {
> +			tst_res(TFAIL,
> +				 "get event: mask=%llx (expected %llx) "
> +				 "pid=%u fd=%u",
> +				 (unsigned long long)event->mask,
> +				 event_set[test_num],
> +				 (unsigned)event->pid, event->fd);
> +		} else if (event->pid != getpid()) {
> +			tst_res(TFAIL,
> +				 "get event: mask=%llx pid=%u "
> +				 "(expected %u) fd=%u",
> +				 (unsigned long long)event->mask,
> +				 (unsigned)event->pid,
> +				 (unsigned)getpid(),
> +				 event->fd);
> +		} else {
> +			if (event->fd == -2)
> +				goto pass;
> +			ret = read(event->fd, buf, BUF_SIZE);
> +			if (ret != strlen(fname)) {
> +				tst_res(TFAIL,
> +					 "cannot read from returned fd "
> +					 "of event: mask=%llx pid=%u "
> +					 "fd=%u ret=%d (errno=%d)",
>  					 (unsigned long long)event->mask,
> -					 event_set[test_num],
> -					 (unsigned)event->pid, event->fd);
> -			} else if (event->pid != getpid()) {
> -				tst_resm(TFAIL,
> -					 "get event: mask=%llx pid=%u "
> -					 "(expected %u) fd=%u",
> +					 (unsigned)event->pid,
> +					 event->fd, ret, errno);
> +			} else if (memcmp(buf, fname, strlen(fname))) {
> +				tst_res(TFAIL,
> +					 "wrong data read from returned fd "
> +					 "of event: mask=%llx pid=%u "
> +					 "fd=%u",
>  					 (unsigned long long)event->mask,
>  					 (unsigned)event->pid,
> -					 (unsigned)getpid(),
>  					 event->fd);
>  			} else {
> -				if (event->fd == -2)
> -					goto pass;
> -				ret = read(event->fd, buf, BUF_SIZE);
> -				if (ret != strlen(fname)) {
> -					tst_resm(TFAIL,
> -						 "cannot read from returned fd "
> -						 "of event: mask=%llx pid=%u "
> -						 "fd=%u ret=%d (errno=%d)",
> -						 (unsigned long long)event->mask,
> -						 (unsigned)event->pid,
> -						 event->fd, ret, errno);
> -				} else if (memcmp(buf, fname, strlen(fname))) {
> -					tst_resm(TFAIL,
> -						 "wrong data read from returned fd "
> -						 "of event: mask=%llx pid=%u "
> -						 "fd=%u",
> -						 (unsigned long long)event->mask,
> -						 (unsigned)event->pid,
> -						 event->fd);
> -				} else {
>  pass:
> -					tst_resm(TPASS,
> -					    "get event: mask=%llx pid=%u fd=%u",
> -					    (unsigned long long)event->mask,
> -					    (unsigned)event->pid, event->fd);
> -				}
> +				tst_res(TPASS,
> +				    "get event: mask=%llx pid=%u fd=%u",
> +				    (unsigned long long)event->mask,
> +				    (unsigned)event->pid, event->fd);
>  			}
> -			/*
> -			 * We have verified the data now so close fd and
> -			 * invalidate it so that we don't check it again
> -			 * unnecessarily
> -			 */
> -			close(event->fd);
> -			event->fd = -2;
> -			event->mask &= ~event_set[test_num];
> -			/* No events left in current mask? Go for next event */
> -			if (event->mask == 0) {
> -				i += event->event_len;
> -			}
> -			test_num++;
> -		}
> -		for (; test_num < TST_TOTAL; test_num++) {
> -			tst_resm(TFAIL, "didn't get event: mask=%llx",
> -				 event_set[test_num]);
> -
>  		}
> -		/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
> -		if (fanotify_mark(fd_notify, FAN_MARK_REMOVE, FAN_ACCESS | FAN_MODIFY |
> -				    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -			    "fanotify_mark (%d, FAN_MARK_REMOVE, FAN_ACCESS | "
> -			    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
> -			    "failed", fd_notify, fname);
> +		/*
> +		 * We have verified the data now so close fd and
> +		 * invalidate it so that we don't check it again
> +		 * unnecessarily
> +		 */
> +		close(event->fd);
> +		event->fd = -2;
> +		event->mask &= ~event_set[test_num];
> +		/* No events left in current mask? Go for next event */
> +		if (event->mask == 0) {
> +			i += event->event_len;
>  		}
> -
> +		test_num++;
>  	}
> +	for (; test_num < TST_TOTAL; test_num++) {
> +		tst_res(TFAIL, "didn't get event: mask=%llx",
> +			 event_set[test_num]);
>  
> -	cleanup();
> -	tst_exit();
> +	}
> +	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
> +	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE, FAN_ACCESS | FAN_MODIFY |
> +			    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
> +		tst_brk(TBROK | TERRNO,
> +		    "fanotify_mark (%d, FAN_MARK_REMOVE, FAN_ACCESS | "
> +		    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
> +		    "failed", fd_notify, fname);
> +	}
>  }
>  
>  static void setup(void)
>  {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
>  	sprintf(fname, "tfile_%d", getpid());
> -	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
> -	SAFE_WRITE(cleanup, 1, fd, fname, 1);
> -
> +	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
> +	SAFE_WRITE(1, fd, fname, 1);
>  	/* close the file we have open */
> -	SAFE_CLOSE(cleanup, fd);
> +	SAFE_CLOSE(fd);
>  
> -	if ((fd_notify = fanotify_init(FAN_CLASS_NOTIF, O_RDONLY)) < 0) {
> -		if (errno == ENOSYS) {
> -			tst_brkm(TCONF, cleanup,
> -				 "fanotify is not configured in this kernel.");
> -		} else {
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -				 "fanotify_init failed");
> -		}
> -	}
> +	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
>  }
>  
>  static void cleanup(void)
>  {
>  	if (fd_notify > 0 && close(fd_notify))
> -		tst_resm(TWARN | TERRNO, "close(%d) failed", fd_notify);
> -
> -	tst_rmdir();
> +		tst_res(TWARN | TERRNO, "close(%d) failed", fd_notify);

We can use safe macros in test cleanup now, so this should be changed to:

	if (fd_notify > 0)
		SAFE_CLOSE(fd_notify);

And that applies to most of the tests, otherwise it looks pretty much
straightforward.

-- 
Cyril Hrubis
chrubis@suse.cz
