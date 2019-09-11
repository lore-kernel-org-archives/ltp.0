From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Sep 2019 14:47:14 +0200
Subject: [LTP] [PATCH v2] syscalls/statx04: use stx_attributes_mask
 before test
In-Reply-To: <05330771-04f6-0fe4-f99d-eb55ff8b733c@cn.fujitsu.com>
References: <20190802115046.GB27727@rei>
 <1566282838-2980-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190827092520.GA28859@dell5510> <20190827095858.GB28859@dell5510>
 <20190827101644.GA30582@rei>
 <05330771-04f6-0fe4-f99d-eb55ff8b733c@cn.fujitsu.com>
Message-ID: <20190911124714.GA21670@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Do you mean use getxattr to ensure bitflags are enable or a functions test?
> I am confused.

For a given filesystem the support for filling in these flags was added
at some point to the kernel. If any kernel newer that this version fails
to fill them up it's a bug.

For ext2 it has been added in:

commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
Author: yangerkun <yangerkun@huawei.com>
Date:   Mon Feb 18 09:07:02 2019 +0800

    ext2: support statx syscall

Hence starting kernel 5.0 ext2 (with ext2 driver) has to set the mask.

For ext4 it has been added in:

commit 3209f68b3ca4667069923a325c88b21131bfdf9f
Author: David Howells <dhowells@redhat.com>
Date:   Fri Mar 31 18:32:17 2017 +0100

	statx: Include a mask for stx_attributes in struct statx


Hence for ext4 the flags should be enabled since kernel 4.11

etc.

-- 
Cyril Hrubis
chrubis@suse.cz
