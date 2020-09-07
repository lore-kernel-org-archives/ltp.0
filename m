From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Sep 2020 13:16:40 +0200
Subject: [LTP] [PATCH 3/9] syscalls/ipc: shmctl04: Rewrite from scratch.
In-Reply-To: <CAEemH2dHcasASDdXKypSwYkg7Yq1+ynO3-Z6QcxMwP6M=Qh3mQ@mail.gmail.com>
References: <20200717163453.9587-1-chrubis@suse.cz>
 <20200717163453.9587-4-chrubis@suse.cz>
 <CAEemH2dHcasASDdXKypSwYkg7Yq1+ynO3-Z6QcxMwP6M=Qh3mQ@mail.gmail.com>
Message-ID: <20200907111640.GA10649@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It failed many times on my personal laptop (5.4.19-100.fc30.x86_64).
> 
> $ cat /proc/sysvipc/shm
>        key      shmid   perms        size      cpid    lpid    nattch   uid
>   gid    cuid    cgid      atime         dtime              ctime
>      rss        swap
>          0          6         1600      524288   2778   5447      2     1000
>  1000  1000  1000 1595120306 1595120306 1595119412      4096        0
>          0          8         1600      524288   1903   2043      2     1000
>  1000  1000  1000 1595119515     0                 1595119515     24576
>    0
> 
> $ ./shmctl04
> tst_test.c:1245: INFO: Timeout per run is 0h 05m 00s
> shmctl04.c:119: PASS: SHM_INFO returned valid index 8
> shmctl04.c:70: PASS: used_ids = 3
> shmctl04.c:77: PASS: shm_rss = 7
> shmctl04.c:84: PASS: shm_swp = 0
> shmctl04.c:91: PASS: shm_tot = 257
> shmctl04.c:95: FAIL: highest shmid = 8, expected 65537
> 
> Summary:
> passed   5
> failed   1
> skipped  0
> warnings 0
> 
> After printing the shm_proc during test running, I guess the 'shmid' is not
> listing in number order sometimes which probably caused that failure.

Looking at the result closely, I guess that I messed up and got confused
here, the return value from SHM_INFO is highest index into the kernel
array, which is equal to highest shmid only by an accident on a freshly
booted machine. I will fix that part in v2.

> 'SHM_STAT_ANY' is introduced since Linux 4.17. We have to confirm the SUT
> supporting before we running it.
> 
> Also, we'd better define it in "ipcshm.h" to avoid compiling errors with
> the old distro.
> 
> shmctl04.c: In function 'verify_shminfo':
> shmctl04.c:114: error: 'SHM_STAT_ANY' undeclared (first use in this
> function)
> shmctl04.c:114: error: (Each undeclared identifier is reported only once
> shmctl04.c:114: error: for each function it appears in.)

Will fix as well.

-- 
Cyril Hrubis
chrubis@suse.cz
