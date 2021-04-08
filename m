From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Apr 2021 12:33:25 +0200
Subject: [LTP] [PATCH 3/3] syscalls/semctl01: Convert into new api
In-Reply-To: <606E7268.8000603@fujitsu.com>
References: <1616497037-19158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1616497037-19158-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <46e7a46a-f3d2-078d-1126-5a8679cea7be@oracle.com>
 <606E7268.8000603@fujitsu.com>
Message-ID: <YG7b9c8b9DBpz3QS@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Does it really require root?
> See ftok(3) manpage, it said "The  ftok()  function uses the identity of 
> the file named by the given pathname (which must refer to an existing, 
> accessible file)".
> ftok source code
> key_t
> ftok (const char *pathname, int proj_id)
> {
>    struct stat64 st;
>    key_t key;
> 
>    if (__stat64 (pathname, &st) < 0)
>      return (key_t) -1;
> 
>    key = ((st.st_ino & 0xffff) | ((st.st_dev & 0xff) << 16)
>           | ((proj_id & 0xff) << 24));
> 
>    return key;
> }
> 
> To ensure ftok succeed, we must require root. Or, modify GETIPCKEY api, 
> we can use tmp directory. Anyhow, I will send a v2 to remove useless 
> funtion declartion firstly.

Unless we are sharing the semaphore with a process that wasn't worked
from the test process we can also pass IPC_PRIVATE instead of the key.

-- 
Cyril Hrubis
chrubis@suse.cz
