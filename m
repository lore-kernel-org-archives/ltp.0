From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Apr 2021 12:11:14 +0200
Subject: [LTP] [PATCH 3/3] syscalls/semctl01: Convert into new api
In-Reply-To: <6070177F.8060404@fujitsu.com>
References: <1616497037-19158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1616497037-19158-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <46e7a46a-f3d2-078d-1126-5a8679cea7be@oracle.com>
 <606E7268.8000603@fujitsu.com> <YG7b9c8b9DBpz3QS@yuki>
 <6070177F.8060404@fujitsu.com>
Message-ID: <YHAoQooWArsl2rgD@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> To ensure ftok succeed, we must require root. Or, modify GETIPCKEY api,
> >> we can use tmp directory. Anyhow, I will send a v2 to remove useless
> >> funtion declartion firstly.
> >
> > Unless we are sharing the semaphore with a process that wasn't worked
> > from the test process we can also pass IPC_PRIVATE instead of the key.
> 
> My ltp working directory is /root/ltp, then run "su xuyang" to run 
> semctl01 case under /root/ltp/testcases/kernel/syscalls/ipc/semctl, then 
> I got ftok failure as below:
> 
> [xuyang@localhost semctl]$ ./semctl01
> tst_test.c:1289: TINFO: Timeout per run is 0h 05m 00s
> libnewipc.c:44: TBROK: ftok() failed at semctl01.c:308: EACCES (13)
> 
> I guess this situation maybe meaningless(Usually, user has access 
> privilege for their ltp directory or install directory ). So needs_root 
> is useless.
> 
> I guess maintainers can remove this directly instead of sending a v3.

The point I was trying to make is that you can pass IPC_PRIVATE instead
of the key to semget() and you don't have to use ftok() at all.

-- 
Cyril Hrubis
chrubis@suse.cz
