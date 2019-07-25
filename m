From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 25 Jul 2019 18:13:58 +0800
Subject: [LTP] [PATCH v6 3/3] syscalls/copy_file_range02: increase
 coverage and remove EXDEV test
In-Reply-To: <CAOQ4uxg7w51AVD6fig9HH0s7vjC=G2fz8H1nauBZ3V5TiRzuVQ@mail.gmail.com>
References: <5D30200B.4050306@cn.fujitsu.com>
 <1564030915-3211-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1564030915-3211-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAOQ4uxg-5UUTB6Z=4Ma9+6LkLVnCz6NBFS4=7Zq_pJfNhZFRqA@mail.gmail.com>
 <5D3941C4.2070601@cn.fujitsu.com>
 <CAOQ4uxg7w51AVD6fig9HH0s7vjC=G2fz8H1nauBZ3V5TiRzuVQ@mail.gmail.com>
Message-ID: <5D3980E6.8010104@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/07/25 16:08, Amir Goldstein wrote:

> On Thu, Jul 25, 2019 at 8:44 AM Yang Xu<xuyang2018.jy@cn.fujitsu.com>  wrote:
>> on 2019/07/25 13:24, Amir Goldstein wrote:
>>
>>> On Thu, Jul 25, 2019 at 8:02 AM Yang Xu<xuyang2018.jy@cn.fujitsu.com>   wrote:
>>>>
>>>>    static void setup(void)
>>>>    {
>>>>           syscall_info();
>>>> +       char dev_path[1024];
>>> Why? What is the point of filling this string if you're not going to
>>> use it. That's exactly what tst_find_free_loopdev(NULL, 0) is for.
>>> I don't think you understood Cyril's comment about the API
>>> correctly.
>>> He meant he rather keep the *option* in the API to fill out the
>>> suggested loopdev file name. Not that you *have* to fill it.
>>>
>>> Thanks,
>>> Amir.
>>>
>> Hi Amir
>>
>>    I think you don't see the whole patch.
>>
>>    I use this dev_path as below:
>>
>>    fd_blkdev = SAFE_OPEN(dev_path, O_RDWR, 0600);
>>
>> on v5 patch, I use  tst_find_free_loopdev(NULL, 0) and create a customized loop dev named "file_block" by mknod .
>>
>> But why we don't use a path directly filled by tst_find_free_loopdev(dev_path, len)? It will not change lib internal state or overwirte data.
>>
>> I only use a standard loop device as same as char device use "/dev/null".
>>
> Right, sorry, missed that.
> It is generally better not to define 1024 array on the stack.
> Most LTP tests define test path vars as static char arrays in top of test file.
Hi Amir

  I think it is a code-style preference. IMO, 1024 array is not enough large and this function is not
interate or recursion call.  It don't make stack overflow. Also, this test path is only used in setup().
  So, I think keeping it is no problem.

>
>>
>>>>           if (access(FILE_DIR_PATH, F_OK) == -1)
>>>>                   SAFE_MKDIR(FILE_DIR_PATH, 0777);
>>>> +       /*
>>>> +        * call tst_find_free_loopdev(), avoid overwriting its
>>>> +        * content on used loopdev.
>>>> +        */
>>>> +       loop_devn = tst_find_free_loopdev(dev_path, sizeof(dev_path));
>>>> +
>>>> +       SAFE_MKNOD(FILE_FIFO, S_IFIFO | 0777, 0);
>>>>
>>>>           fd_src    = SAFE_OPEN(FILE_SRC_PATH, O_RDWR | O_CREAT, 0664);
>>>>           fd_dest   = SAFE_OPEN(FILE_DEST_PATH, O_RDWR | O_CREAT, 0664);
>>>>           fd_rdonly = SAFE_OPEN(FILE_RDONL_PATH, O_RDONLY | O_CREAT, 0664);
>>>> -       fd_mnted  = SAFE_OPEN(FILE_MNTED_PATH, O_RDWR | O_CREAT, 0664);
>>>>           fd_dir    = SAFE_OPEN(FILE_DIR_PATH, O_DIRECTORY);
>>>>           fd_closed = -1;
>>>>           fd_append = SAFE_OPEN(FILE_DEST_PATH,
>>>>                           O_RDWR | O_CREAT | O_APPEND, 0664);
>>>> +       fd_immutable = SAFE_OPEN(FILE_IMMUTABLE_PATH, O_RDWR | O_CREAT, 0664);
>>>> +       fd_swapfile = SAFE_OPEN(FILE_SWAP_PATH, O_RDWR | O_CREAT, 0600);
>>>> +
>>>> +       if (loop_devn == -1)
>>>> +               fd_blkdev = SAFE_OPEN(dev_path, O_RDWR, 0600);
>>>> +
>>         I use the dev_path string.
> (loop_devn != 1) ??
Sorry for the obvious error.


Hi Cyril

Would you mind me to send a v7 patch or you merge this patchset with changing this obvious error
if you think it is ok?


> Thanks,
> Amir.
>
>
>



