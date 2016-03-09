From: Zirong Lang <zlang@redhat.com>
Date: Wed, 9 Mar 2016 11:05:12 -0500 (EST)
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <20160309155258.GA32248@rei.lan>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309130709.GA28171@rei.lan>
 <1202691488.27788761.1457537492316.JavaMail.zimbra@redhat.com>
 <20160309155258.GA32248@rei.lan>
Message-ID: <617741409.27804234.1457539512488.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- 原始邮件 -----
> 发件人: "Cyril Hrubis" <chrubis@suse.cz>
> 收件人: "Zirong Lang" <zlang@redhat.com>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期三, 2016年 3 月 09日 下午 11:52:58
> 主题: Re: [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for create appointed size fs
> 
> Hi!
> > > Also why have you added the blocksize parameter as well? The block size
> > > is needed only for the mmap16 test while limiting filesystem size seems
> > > like good addition to the library?
> > 
> > Block size is needed because some fs need to know the block count, if you
> > want to create a sized fs. For example if we want to make 512m ext4 and
> > xfs:
> > 
> > xfs can directly use mkfs -t xfs -d size=512m device
> > 
> > but mkfs.ext4 need to do like: mkfs -t ext4 -b $block_size device
> > 512*1024*1024/$block_size
> > 
> > So we need to know block size for some fs, as I know udf fs need to know
> > block count too.
> 
> Looking at the a few different mkfs programs there is no unified way to
> pass the size parameter. And looks like only mke2fs and mkfs.fat
> supports one paramter after the device.
> 
> So after all the easiest solution may be just to add one more const
> char* fs-size parameter to tst_mkfs that could be used to pass block
> count to these two.

Yes, this likes what I just said to you. add another parameter char *fs_opts[], which
store all parameters for mkfs need to behind device name.

Or maybe my "|" method is the simplest, even it's ugly:)

Thanks,
Zorro

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
