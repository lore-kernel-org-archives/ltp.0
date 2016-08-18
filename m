From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Aug 2016 17:43:37 +0200
Subject: [LTP] [PATCH 3/8] syscalls/waitpid: implement waitpid_ret_test()
In-Reply-To: <57B5D10A.4070406@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160815152739.GG20680@rei.lan> <57B585E7.9020000@oracle.com>
 <20160818104245.GA24254@rei.lan> <57B5D10A.4070406@oracle.com>
Message-ID: <20160818154337.GB31953@rei.lan>
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

You can use just tst_res() there. (It will force the C processor to make
one more pass since the tes_res() would need to be expanded to
tst_res_()...) and the __FILE__ and __LINE__ should be expanded last and
should point to the location of code the macro has been used.

We can put the whole waitpid check into the macro, something as:

#define WAITPID_RET_TEST(waitpid_fn, exp_ret, exp_errno) \
	do {
		pid_t ret = waitpid_fn;
		if (ret != exp_ret) {
			tst_res(TFAIL,
			        #waitpid_fn " returned %i, expected %i",
				ret, exp_ret);
			return;
		}

		if (ret == -1 && errno != exp_errno) {
			tst_res(TFAIL | TERRNO,
			        #waitpid_fn "expected %s",
				tst_strerrno(exp_errno));
			return;
		}
	} while (0);

And call it as:

WAITPID_RET_TEST(waitpid(-1, &status, WNOHANG | WUNTRACED), 0, 0);

> A similar operation would be required for reap_children().

Hmm, that one would be overly complicated and ugly as a macro.

-- 
Cyril Hrubis
chrubis@suse.cz
