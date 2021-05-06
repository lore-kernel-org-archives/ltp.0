From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 May 2021 15:35:48 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls: modify_ldt02: Fix failure
In-Reply-To: <d133afe6b6be43b089a68e0a72b15960@huawei.com>
References: <d133afe6b6be43b089a68e0a72b15960@huawei.com>
Message-ID: <YJPwtLIVaudLO6vy@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am sorry, It's my fault. It seems that restore to origin code is
> more better since it might create a core file.

No this is not solution either, since the original code was broken to
begin with.

We do have tst_no_corefile() in the test library, which should be called
by tests that cause SEGFAULT on purpose in order to avoid dumping a
core, but it looks like it's available only for new library tests. We
would have to convert the test to new library first if we wanted to
that.

-- 
Cyril Hrubis
chrubis@suse.cz
