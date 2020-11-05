From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Nov 2020 13:57:01 +0100
Subject: [LTP] [stable-rc 4.14] shmctl04.c:115: TFAIL: SHM_INFO haven't
 returned a valid index: SUCCESS (0)
In-Reply-To: <CA+G9fYu4RdH7zdd5MU=E-o+azMRx-EqR-7VYuJCUastKRd0KCA@mail.gmail.com>
References: <CA+G9fYu4RdH7zdd5MU=E-o+azMRx-EqR-7VYuJCUastKRd0KCA@mail.gmail.com>
Message-ID: <20201105125701.GD10395@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> LTP syscalls test shmctl04 test modified in latest LTP release 20200930
> and this test reported as fail. so reporting to LTP mailing list.
> Failed on stable-rc 4.14, 4.9 and 4.4 branches but
> passed on stable-rc 4.19, 5.4 and 5.9 branches for arm64, arm, x86_64 and i386.
> 
> shmctl04.c:115: TFAIL: SHM_INFO haven't returned a valid index: SUCCESS (0)
> shmctl04.c:131: TFAIL: Counted used = 0, used_ids = 1
> shmctl04.c:72: TPASS: used_ids = 1
> shmctl04.c:79: TPASS: shm_rss = 0
> shmctl04.c:86: TPASS: shm_swp = 0
> shmctl04.c:93: TPASS: shm_tot = 1

Looks like SHM_STAT_ANY was added to kernel 4.17, that would explain why
shmctl() with SHM_STATA_ANY returns -1 on 4.14 and older but in that
case errno should be EINVAL and not set to zero.

-- 
Cyril Hrubis
chrubis@suse.cz
