From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Aug 2016 17:54:23 +0200
Subject: [LTP] [PATCH 3/8] syscalls/waitpid: implement waitpid_ret_test()
In-Reply-To: <57B5D10A.4070406@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160815152739.GG20680@rei.lan> <57B585E7.9020000@oracle.com>
 <20160818104245.GA24254@rei.lan> <57B5D10A.4070406@oracle.com>
Message-ID: <20160818155423.GC31953@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> #define WAITPID_RET_TEST(wp_pid, wp_status, wp_opts, wp_ret, wp_errno)  \
>         do {                                                            \
>                 if (waitpid_ret_test(wp_pid, wp_status,                 \
>                                      wp_opts, wp_ret, wp_errno)) {      \
>                         tst_res_(__FILE__, __LINE__, TFAIL,             \
>                                  "waitpid_ret_test() failed");          \
>                         return;                                         \
>                 }                                                       \
>         } while (0)
> 
> ?
> 
> This will produce:
> 
> [stas@kholmanskikh waitpid]$ ./waitpid07
> tst_test.c:756: INFO: Timeout per run is 0h 05m 00s
> waitpid_common.h:97: FAIL: waitpid() returned 0, expected 666
> waitpid07.c:51: FAIL: waitpid_ret_test() failed

I guess that we can go this way and turn the last TFAIL into the TINFO.

Well, we may also do something as:

#define TST_TRACE(expr) \
	({int ret = expr; ret != 0 ? tst_res(TINFO, #expr " failed"), ret : ret;})


Then call it as:

	if (TST_TRACE(waitpid_ret_test(...)))
		return;

-- 
Cyril Hrubis
chrubis@suse.cz
