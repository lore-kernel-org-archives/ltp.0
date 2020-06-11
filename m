From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 11 Jun 2020 12:56:35 +0800
Subject: [LTP] [PATCH v2] syscalls/ioctl_loop05: Use correct blockdev to
 get logical_block_size
In-Reply-To: <660069492.15476972.1591794243308.JavaMail.zimbra@redhat.com>
References: <828833321.15301509.1591700517554.JavaMail.zimbra@redhat.com>
 <1591767427-29383-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1904123764.15455071.1591784009893.JavaMail.zimbra@redhat.com>
 <787d0f86-269b-1e23-2631-2c420d6dd884@cn.fujitsu.com>
 <3cdd6be2-c27a-e9dc-2559-c6577239a1bc@cn.fujitsu.com>
 <660069492.15476972.1591794243308.JavaMail.zimbra@redhat.com>
Message-ID: <4c75396e-6578-ecbb-e8e5-d0569d289f9f@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan


> 
> 
> ----- Original Message -----
>>>>
>>>> What I had in mind when I referred to df was something like:
>>>>  ?? stat("test.img", &statbuf);
>>>>  ?? SAFE_MKNOD("blkdev", S_IFBLK | S_IRWXU, statbuf.st_dev);
>>>>  ?? block_devfd = SAFE_OPEN("blkdev", O_RDWR);
>>>> What do you think?
>>>>
>> It works well on ext4 or xfs filesystem(user may mount wanted filesystem
>> on tmpdir). But if we use btrfs, this
>> BLKSSZGET will fail because major dev numer is 0. When we meet this
>> situation, we don't need to call this ioctl and we can directly test
>> becuase it doesn' t have backing file block device align limit.
>> What do you thin about it?
> 
> This I didn't expect. If it's not reliable then perhaps your method
> in v1 that incrementally increases it until it works is perhaps most
> universal approach. Sorry for the detour to get there.
> 
After I trace the stat syscall, btrfs uses virtual block dev, so major 
dev number is 0 since kernel commit[1].

Originally, I want to use that major dev number is 0 to judge whether 
loop driver has align limit on some fileystems. But it sees that they 
don't have direct connection between inode->i_sb->s_bdev (loop used)and 
inode->st_dev(stat used). So using the major dev number to judge whether 
loop driver code has align limits sounds unreasonable.

To aovid this, I will use v1 method with some improvement.


[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/btrfs/inode.c?id=3394e1607eaf870ebba37d303fbd590a4c569908 

> 
> 


