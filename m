From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Jan 2019 14:54:52 +0100
Subject: [LTP] [PATCH RFC] fzsync: tst_fzsync_pair_wait exit when parent
 hit accidental break
In-Reply-To: <20190104095256.12266-1-liwang@redhat.com>
References: <20190104095256.12266-1-liwang@redhat.com>
Message-ID: <20190108135452.GD30528@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> For system(rhel7.6, s390x) without __NR_recvmmsg supported, run
> cve-2016-7117 result in timeout and killed by LTP framework. The
> root reason is tst_syscall break with cleanup() function calling
> in this trace path:
> 
>   tst_syscall(__NR_recvmmsg, ...)
>     tst_brk()
>       cleanup()
>         tst_fzsync_pair_cleanup()
>           SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
> 
> cve-2016-7117 hung at here to wait for thread_b send_and_close() finishing.
> But thread_b fall into infinite loop because of tst_fzsync_wait_b without
> an extra condition to exit. Eventually, test get timeout error like:
> 
>   cve-2016-7117.c:145: CONF: syscall(-1) __NR_recvmmsg not supported
>   Test timeouted, sending SIGKILL!
>   tst_test.c:1125: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
>   tst_test.c:1126: BROK: Test killed! (timeout?)

Looks like the complete solution will be more complex, so what about we
do a simple solution that would make it to the release?

We can change the cve-2016-7117 to check if __NR_recvmmsg() is supported
in the test setup(), then we can avoid this problem to begin with.

-- 
Cyril Hrubis
chrubis@suse.cz
