From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Jun 2020 11:18:50 +0200
Subject: [LTP] 303cc571d1: ltp.setns01.fail
In-Reply-To: <20200615085836.GR12456@shao2-debian>
References: <20200615085836.GR12456@shao2-debian>
Message-ID: <20200615091850.GA3373@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> setns01     6  TFAIL  :  setns01.c:176: regular file fd exp_errno=22: errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(12, 0x20000)
> setns01     7  TFAIL  :  setns01.c:176: regular file fd exp_errno=22: errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(12, 0x40000000)
> setns01     8  TFAIL  :  setns01.c:176: regular file fd exp_errno=22: errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(12, 0x20000000)
> setns01     9  TFAIL  :  setns01.c:176: regular file fd exp_errno=22: errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(12, 0x4000000)
> setns01    10  TFAIL  :  setns01.c:176: regular file fd exp_errno=22: errno=EBADF(9): Bad file descriptor

The messages here are a bit cryptic, I will fix that later on, but what
it means here is that the errno has changed from EINVAL to EBADF in a
case we pass file descriptor to a regular file to setns().

-- 
Cyril Hrubis
chrubis@suse.cz
