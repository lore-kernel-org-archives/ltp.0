From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 9 Jun 2020 17:48:24 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: Get the logic_block_size
 dynamically
In-Reply-To: <218497387.15286923.1591694653027.JavaMail.zimbra@redhat.com>
References: <1591691583-12442-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <218497387.15286923.1591694653027.JavaMail.zimbra@redhat.com>
Message-ID: <b1a7a025-3875-86db-222d-5a1e40737b24@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan

>
> ----- Original Message -----
>> In loop driver code, the sb_bsize was calculated as below
>> sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev),
>>
>> it is the super block's block size that the backing file's inode belongs to,
>> not by using the st_blksize member of stat struct(it uses inode->i_blkbits).
> I'm not sure I follow the above, are you saying the difference is bdev blksize
> vs. filesystem blksize?

I said the loop driver used  dev_logical_block_size(inode->i_sb->s_bdev) but not using
st_blksize. I don't see they have conversion formula so using st_blksize maybe wrong.

>   Is the test failing in some scenarios or is this
> fix based on code inspection?

It affects the result of? ("With nonzero offset less than logical_block_size").
When we can get sb_bdev on other machine(not s390), it should report EINVAL error.

But if we use stat.st_blksize, it passed.

not using st_blksize? result as below:
ioctl_loop05.c:81: INFO: With nonzero offset less than logical_block_size
ioctl_loop05.c:92: PASS: LOOP_SET_DIRECT_IO failed as expected: EINVAL (22)

using st_blksize? result as below:
ioctl_loop05.c:81: INFO: With nonzero offset less than logical_block_size
ioctl_loop05.c:87: PASS: LOOP_SET_DIRECT_IO succeeded


>
>> IMO, we don't have the direct ioctl to get this size, just try it from 512 to
>> page_size.
> Would BLKSSZGET work? It returns bdev_logical_block_size().

But it needs a blockdev, in user space, we can specify bdev, but how can we figure out this inode->i_sb->s_bdev block dev.

>
>
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200609/970d8e37/attachment.htm>
