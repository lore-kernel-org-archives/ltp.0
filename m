From: Xu, =?unknown-8bit?b?WWFuZy/lvpAg5p2o?= <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 12 Sep 2019 11:28:35 +0800
Subject: [LTP] [PATCH v2] syscalls/statx04: use stx_attributes_mask
 before test
In-Reply-To: <20190911124714.GA21670@rei.lan>
References: <20190802115046.GB27727@rei>
 <1566282838-2980-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190827092520.GA28859@dell5510> <20190827095858.GB28859@dell5510>
 <20190827101644.GA30582@rei>
 <05330771-04f6-0fe4-f99d-eb55ff8b733c@cn.fujitsu.com>
 <20190911124714.GA21670@rei.lan>
Message-ID: <234dd7e2-8347-28f4-52d5-a1318f3f8efd@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/09/11 20:47, Cyril Hrubis wrote:

> Hi!
>> Do you mean use getxattr to ensure bitflags are enable or a functions test?
>> I am confused.
> For a given filesystem the support for filling in these flags was added
> at some point to the kernel. If any kernel newer that this version fails
> to fill them up it's a bug.
>
> For ext2 it has been added in:
>
> commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
> Author: yangerkun <yangerkun@huawei.com>
> Date:   Mon Feb 18 09:07:02 2019 +0800
>
>      ext2: support statx syscall
>
> Hence starting kernel 5.0 ext2 (with ext2 driver) has to set the mask.
>
> For ext4 it has been added in:
>
> commit 3209f68b3ca4667069923a325c88b21131bfdf9f
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Mar 31 18:32:17 2017 +0100
>
> 	statx: Include a mask for stx_attributes in struct statx
>
>
> Hence for ext4 the flags should be enabled since kernel 4.11

Hi Cyril

Thanks, I see. It seems that kernel version check is useful for upstream kernel. But if an LTS linux distribution backports the commit
93bc420 for ext2, this kernel version will make no sense.  I remember ltp has a discussion between EISDIR and EBDAF about
copy_file_range[1]. Also ext2 should enable CONFIG_EXT2_FS_XATTR if we don't use ext4 instead of it.

IMO, we don't need to add kernel enable version check for various filesystems because QA or user can find their system doesn't support
these flags and report this to linux distribution vendor. So these flags may be supported on next release.

If kernel enables these flags fails to fill them up it's a bug.  We can only give some comments  about their enabled commit information.
So user can know it is a bug or a non-supported feature.

ps: I have a question about min_kernel all the time. If a new feature(such as PR_CAP_AMBIENT ) is introduced since upstream kernel 4.3,
but this feature is also backported on low version kernel on some linux distributions. What kind of situation can we use the min_kernel
to distinguish it? what kind of situation we don't need? test-writing-guidelines.txt doesn't mention it.

Thanks
Yang Xu

>
> etc.
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190912/4b3a53b7/attachment-0001.htm>
