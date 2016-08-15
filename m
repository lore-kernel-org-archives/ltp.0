From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Aug 2016 16:36:02 +0200
Subject: [LTP] [PATCH 2/8] waitpid10: use the new API
In-Reply-To: <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160815143602.GF20680@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void do_child_1(void)
>  {

Why do we run the test in the do_child_1() here?

As far as I remember the whole point was to start some of the child
processes in different process group and we don't do that in this test,
so we may as well put this function as the test function into the struct
tst_test.


Otherwise this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
