From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 24 Apr 2020 12:43:04 +0800
Subject: [LTP] [PATCH v2 09/10] syscalls/ioctl_loop07: Add dio with
 logic block size error test
In-Reply-To: <9084aae3-e98a-918d-9a0d-bdbe7da76f87@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1586429086-22975-9-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200422135856.GB5529@yuki.lan>
 <124d3b91-2025-d36e-f3b1-6c0b5528ae51@cn.fujitsu.com>
 <9084aae3-e98a-918d-9a0d-bdbe7da76f87@cn.fujitsu.com>
Message-ID: <46c50e18-faec-a428-6fcc-ffc3515b29dd@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi Cyril
> 
>> Hi Cyril
>>
>>
>>> Hi!
>>> This test fails for me, i.e. the attempt to enabe direct IO succeeds. I
>>> will have to have a closer look later on.
>> Now, I use 5.7.0-rc2 kernel to test, this case fails, I guess loop 
>> driver has changed its logic. I am trying.
> 
> I write this test on fedora31(tmp directory use tmpfs), so I got a 
> pseudo pass when setting dio.
> 
> I misunderstood the meaning of the comment in the kernel.
> kernel commet as below:
> "We support direct I/O only if lo_offset is aligned with the
> logical I/O size of backing device, and the logical block
> size of loop is bigger than the backing device's and the loop
> needn't transform transfer."
> 
> sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev);? //get block 
> size from backing device
> dio_align = sb_bsize - 1;
> 
> I use logic block size of loop(1024 > 512) , so this test pass.
> 
> Now, I think this test is meaningless and we can remove this.
> 
> Best Regards
> Yang Xu
>>
>> ps: when run ioctl_loop01.c, I also met another problem that 
>> /dev/loop0p1 and? the corresponding sys file doesn't existed. dmesg 
>> report error "loop_reread_partitions: partition scan of loop0 () 
>> failed (rc=-16)". Also trying .
Kernel commit d3ef55362("block: fix busy device checking in 
blk_drop_partitions")  and commit cb6b771b05("block: fix busy device 
checking in blk_drop_partitions again") introduced this 
failure(ioctl_loop01, EBUSY error). more info see[1]

[1]https://lkml.org/lkml/2020/4/23/380
>>>


