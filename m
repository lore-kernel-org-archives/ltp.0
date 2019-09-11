From: Xu, =?unknown-8bit?b?WWFuZy/lvpAg5p2o?= <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 11 Sep 2019 18:22:37 +0800
Subject: [LTP] [PATCH v2] syscalls/statx04: use stx_attributes_mask
 before test
In-Reply-To: <20190827101644.GA30582@rei>
References: <20190802115046.GB27727@rei>
 <1566282838-2980-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190827092520.GA28859@dell5510> <20190827095858.GB28859@dell5510>
 <20190827101644.GA30582@rei>
Message-ID: <05330771-04f6-0fe4-f99d-eb55ff8b733c@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/08/27 18:16, Cyril Hrubis wrote:

> Hi!
>> also Cyril noted on Github issue #557 [1]:
>> "However I'm not sure that we should do this since kernel devs declared this to be bug after all."
>>
>> So maybe we should wait before applying it.
>>
>> @Cyril: can you please post link to discussion in LKML?
> I've talked to Jan Kara in person while developing these tests, so there
> is no track of this discussion.
>
> I guess that the best we can do here is to:
>
> * Apply this patch, since the test should generally check only for flags
>    that are supported in the bitflag returned by the syscall
>
> * Add another test that checks that these bitflags are enabled for new
>    enough kernels for certain set of filesystems

Hi Cyril

Do you mean use getxattr to ensure bitflags are enable or a functions test?
I am confused.

Thanks
Yang Xu

>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190911/674e33a1/attachment.htm>
