From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 9 Jun 2020 18:46:17 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: Get the logic_block_size
 dynamically
In-Reply-To: <1837993622.15296660.1591697802060.JavaMail.zimbra@redhat.com>
References: <1591691583-12442-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <218497387.15286923.1591694653027.JavaMail.zimbra@redhat.com>
 <b1a7a025-3875-86db-222d-5a1e40737b24@cn.fujitsu.com>
 <1837993622.15296660.1591697802060.JavaMail.zimbra@redhat.com>
Message-ID: <96ba542d-4ec7-bc5d-41d9-f533952f94cd@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan

> 
> 
> ----- Original Message -----
>> Hi Jan
>>
>>>
>>> ----- Original Message -----
>>>> In loop driver code, the sb_bsize was calculated as below
>>>> sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev),
>>>>
>>>> it is the super block's block size that the backing file's inode belongs
>>>> to,
>>>> not by using the st_blksize member of stat struct(it uses
>>>> inode->i_blkbits).
>>> I'm not sure I follow the above, are you saying the difference is bdev
>>> blksize
>>> vs. filesystem blksize?
>>
>> I said the loop driver used  dev_logical_block_size(inode->i_sb->s_bdev) but
>> not using
>> st_blksize.
> 
> I know, but I'm trying to understand what the difference is between those two.
AFAIK, st_blksize is used to standard io in user space as man-page said 
"/* Block size for filesystem I/O */", it maybe a buffer write used. It 
is a  block size that block in inode used.
But dev_logical_block_size is a min unit thatrequest queue used on block 
layer.

ps? this is my understanding. If it's wrong, please correct me.
> 
>>> Would BLKSSZGET work? It returns bdev_logical_block_size().
>>
>> But it needs a blockdev, in user space, we can specify bdev, but how can we
>> figure out this inode->i_sb->s_bdev block dev.
> 
> Isn't that the block device "test.img" is on?
Do you mean the test.img belong to some block dev, such as /dev/sda1 or 
our mounted block_dev? If so, I think it is.
> 
> 
> 


