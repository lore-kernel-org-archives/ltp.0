From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Fri, 9 Apr 2021 07:59:41 +0000
Subject: [LTP] [PATCH 3/3] syscalls/semctl01: Convert into new api
In-Reply-To: <YG7b9c8b9DBpz3QS@yuki>
References: <1616497037-19158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1616497037-19158-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <46e7a46a-f3d2-078d-1126-5a8679cea7be@oracle.com>
 <606E7268.8000603@fujitsu.com> <YG7b9c8b9DBpz3QS@yuki>
Message-ID: <6070177F.8060404@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Alexey
> Hi!
>>> Does it really require root?
>> See ftok(3) manpage, it said "The  ftok()  function uses the identity of
>> the file named by the given pathname (which must refer to an existing,
>> accessible file)".
>> ftok source code
>> key_t
>> ftok (const char *pathname, int proj_id)
>> {
>>     struct stat64 st;
>>     key_t key;
>>
>>     if (__stat64 (pathname,&st)<  0)
>>       return (key_t) -1;
>>
>>     key = ((st.st_ino&  0xffff) | ((st.st_dev&  0xff)<<  16)
>>            | ((proj_id&  0xff)<<  24));
>>
>>     return key;
>> }
>>
>> To ensure ftok succeed, we must require root. Or, modify GETIPCKEY api,
>> we can use tmp directory. Anyhow, I will send a v2 to remove useless
>> funtion declartion firstly.
>
> Unless we are sharing the semaphore with a process that wasn't worked
> from the test process we can also pass IPC_PRIVATE instead of the key.

My ltp working directory is /root/ltp, then run "su xuyang" to run 
semctl01 case under /root/ltp/testcases/kernel/syscalls/ipc/semctl, then 
I got ftok failure as below:

[xuyang@localhost semctl]$ ./semctl01
tst_test.c:1289: TINFO: Timeout per run is 0h 05m 00s
libnewipc.c:44: TBROK: ftok() failed at semctl01.c:308: EACCES (13)

I guess this situation maybe meaningless(Usually, user has access 
privilege for their ltp directory or install directory ). So needs_root 
is useless.

I guess maintainers can remove this directly instead of sending a v3.

Best Regards
Yang Xu
>
