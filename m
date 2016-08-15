From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Aug 2016 17:27:39 +0200
Subject: [LTP] [PATCH 3/8] syscalls/waitpid: implement waitpid_ret_test()
In-Reply-To: <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160815152739.GG20680@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Several test cases call waitpid() and then verify the returned
> value and errno set. Moved this code into a function.

One thing I do not like about this that this will report the file and
line from the waitpid_common.h in the test output rather than the
respective line where the check has failed.

We could decleare these as a macros that call the function with __FILE__
and __LINE__ and call the tst_res_() with these instead. But I'm not
sure that this is worth the added complexity...

-- 
Cyril Hrubis
chrubis@suse.cz
