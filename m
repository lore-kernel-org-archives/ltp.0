From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 10 Jun 2020 20:19:48 +0800
Subject: [LTP] [PATCH v2] syscalls/ioctl_loop05: Use correct blockdev to
 get logical_block_size
In-Reply-To: <787d0f86-269b-1e23-2631-2c420d6dd884@cn.fujitsu.com>
References: <828833321.15301509.1591700517554.JavaMail.zimbra@redhat.com>
 <1591767427-29383-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1904123764.15455071.1591784009893.JavaMail.zimbra@redhat.com>
 <787d0f86-269b-1e23-2631-2c420d6dd884@cn.fujitsu.com>
Message-ID: <3cdd6be2-c27a-e9dc-2559-c6577239a1bc@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan


> Hi Jan
> 
> 
>>
>>
>> ----- Original Message -----
>>>
>>> Using df cmd (df -T /tmp/xxxxx/test.img)to get the correct block dev.
>>
>> What I had in mind was to take "df -T" as inspiration, not call it 
>> directly,
>> but that could work too. See notes below.
>>
>>> +static void find_backing_bdpath(char *buf)
>>> +{
>>> +??? char line[PATH_MAX];
>>> +??? FILE *file;
>>> +
>>> +??? file = SAFE_FOPEN("1.txt", "r");
>>> +
>>> +??? while (fgets(line, sizeof(line), file) != NULL)
>>> +??????? sscanf(line, "%s", buf);
>>
>> This will take the last line of output, which can be a problem as some
>> version align output differently. For example:
>>
>> # df -T .
>> Filesystem?????????? Type 1K-blocks??? Used Available Use% Mounted on
>> /dev/mapper/vg_dhcp13579-lv_root
>> ????????????????????? ext4? 46967160 3102232? 41472456?? 7% /
>>
>> can break output into two lines.
> Yes.
>>
>>> +??? SAFE_FCLOSE(file);
>>> +}
>>> +
>>> ? static void setup(void)
>>> ? {
>>> -??? int fd;
>>> -??? struct stat buf;
>>> +??? char buf[100];
>>> +??? const char *const df_cmd[] = {"df", "-T", ".", NULL};
>>> ????? if (tst_fs_type(".") == TST_TMPFS_MAGIC)
>>> ????????? tst_brk(TCONF, "tmpfd doesn't support O_DIRECT flag");
>>> @@ -109,13 +122,6 @@ static void setup(void)
>>> ????? sprintf(sys_loop_diopath, "/sys/block/loop%d/loop/dio", dev_num);
>>> ????? tst_fill_file("test.img", 0, 1024, 1024);
>>> -??? fd = SAFE_OPEN("test.img", O_RDONLY);
>>> -??? SAFE_FSTAT(fd, &buf);
>>> -??? SAFE_CLOSE(fd);
>>> -
>>> -??? logical_block_size = buf.st_blksize;
>>> -??? tst_res(TINFO, "backing dev logical_block_size is %d", 
>>> logical_block_size);
>>> -
>>> ????? tst_attach_device(dev_path, "test.img");
>>> ????? attach_flag = 1;
>>> ????? dev_fd = SAFE_OPEN(dev_path, O_RDWR);
>>> @@ -130,13 +136,24 @@ static void setup(void)
>>> ?????? *?? size of loop is bigger than the backing device's and the loop
>>> ?????? *?? needn't transform transfer.
>>> ?????? */
>>> -??? TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, 
>>> logical_block_size),
>>> TST_RETVAL_EQ0);
>>> +??? SAFE_CMD(df_cmd, "1.txt", NULL);
>>
>> This could be part of find_backing_bdpath() function.
> Yes.
>>
>> What I had in mind when I referred to df was something like:
>> ?? stat("test.img", &statbuf);
>> ?? SAFE_MKNOD("blkdev", S_IFBLK | S_IRWXU, statbuf.st_dev);
>> ?? block_devfd = SAFE_OPEN("blkdev", O_RDWR);
>> What do you think?
>>
It works well on ext4 or xfs filesystem(user may mount wanted filesystem 
on tmpdir). But if we use btrfs, this
BLKSSZGET will fail because major dev numer is 0. When we meet this 
situation, we don't need to call this ioctl and we can directly test 
becuase it doesn' t have backing file block device align limit.
What do you thin about it?



> Oh, yes, it is more easier (I have tried this). I will send a v3 for this.
> 
> ps: I think I can use this in my other loop patches for loop_configure 
> ioctl.
>>
>>
> 
> 
> 


