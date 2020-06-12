From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 12 Jun 2020 10:57:04 +0800
Subject: [LTP] [PATCH v3] syscalls/ioctl_loop05: Use correct blockdev to
 get logical_block_size
In-Reply-To: <1004907592.15616646.1591873760020.JavaMail.zimbra@redhat.com>
References: <660069492.15476972.1591794243308.JavaMail.zimbra@redhat.com>
 <1591853524-17011-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1004907592.15616646.1591873760020.JavaMail.zimbra@redhat.com>
Message-ID: <9b93f001-49f4-27ec-8860-65b7ab75e442@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan

> 
> 
> ----- Original Message -----
>> Using inode block size is also wrong because it is for filesystem io(such as
>> we format
>> filesystem can specify block size for data or log or metadata), it is not
>> suitable
>> for logical block size.
> 
> If this copes correctly with btrfs too, I don't have objections.
For btrfs, I think it is also right.
> I retested on failing s390 setup and v3 works there OK.
Thanks for your retest.

Best Regards
Yang Xu
> 
> 
> 


