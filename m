From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Aug 2016 19:38:19 +0200
Subject: [LTP] [PATCH 3/8] syscalls/waitpid: implement waitpid_ret_test()
In-Reply-To: <57B6D5AF.2040003@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160815152739.GG20680@rei.lan> <57B585E7.9020000@oracle.com>
 <20160818104245.GA24254@rei.lan> <57B5D10A.4070406@oracle.com>
 <20160818155423.GC31953@rei.lan> <57B6D5AF.2040003@oracle.com>
Message-ID: <20160822173819.GC22470@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > #define TST_TRACE(expr) \
> > 	({int ret = expr; ret != 0 ? tst_res(TINFO, #expr " failed"), ret : ret;})
> 
> I like this idea with '#expr'.
> 
> Do you want me to put this in tst_test.h, or is it acceptable if I keep
> this in waitpid_common.h? If it's acceptable, I'd rename it to
> WAITPID_TEST and used the 'return' statement"

I guess that this is useful enough to be included in the test library.

I mildy oppose to the return in the macro, since that hides the actuall
code flow. Maybe we can make it clearer by including RET in the macro
name. I couldn't come up with something short and descriptive though,
maybe something as TRACE_RET_ON_FAIL(waitpid_ret_test(...)) or
TRET_ON_FAIL(...).

-- 
Cyril Hrubis
chrubis@suse.cz
