From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 5 Aug 2019 15:11:53 +0800
Subject: [LTP] [PATCH v7 3/3] syscalls/copy_file_range02: increase
 coverage and remove EXDEV test
In-Reply-To: <20190805065832.ti6vpoviykfaxcj7@XZHOUW.usersys.redhat.com>
References: <20190730110555.GB7528@rei.lan>
 <1564569629-2358-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1564569629-2358-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190805065832.ti6vpoviykfaxcj7@XZHOUW.usersys.redhat.com>
Message-ID: <5D47D6B9.9090306@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/08/05 14:58, Murphy Zhou  wrote:

>> + * 13) Try to copy contents to a file with target file range
>> >  + *     beyond maximum supported file size ->EFBIG
> Test 13) fails on latest Linus tree. Is there any report or working on this?
Hi Murphy

    Test 13)  passed on my system(64bit, 5.2.0+, ext4,vfat,btrfs,xfs ).
    Do you provide more infomation(filesystem, 32bit or 64bit)?

Thanks
Yang Xu

> Thanks!
> M
>



