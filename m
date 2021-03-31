From: xieziyao <xieziyao@huawei.com>
Date: Wed, 31 Mar 2021 02:19:42 +0000
Subject: [LTP] =?gb2312?b?tPC4tDogIFtQQVRDSF0gc3lzY2FsbHMvY2hkaXIwMTog?=
 =?gb2312?b?QWRkIHVtYXNrIGJlZm9yZSBta2Rpcg==?=
In-Reply-To: <YGNXkZMqqJpviwkL@pevik>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389E8F1@dggeml531-mbx.china.huawei.com>
 <YGNXkZMqqJpviwkL@pevik>
Message-ID: <3bcb94a23de3476ca3c4c6f68fe3b1f6@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi, Petr,

Sorry, I didn't subscribe to the mail when Gongyi's patch was submitted.

Anyway, thank you for your discussion of this issue and for merging this patch.

Regards,
Ziyao

-----????-----
???: Petr Vorel [mailto:pvorel@suse.cz] 
????: 2021?3?31? 0:54
???: zhaogongyi <zhaogongyi@huawei.com>
??: xieziyao <xieziyao@huawei.com>; ltp@lists.linux.it
??: Re: [LTP] [PATCH] syscalls/chdir01: Add umask before mkdir

Hi Gongyi,

> Umask is always 022 in many system env. In this testcase, if umask is 
> not 022, for example, umask is 0077, test would fail because the file 
> mode is affected by umask.
Thanks a lot for a giving example. I tested only 0066.

I'm sorry I accepted the Ziyao version as it had better description, reverted back changes and will work on any mode in SAFE_MKDIR(). I put your Reported-by:
tag.

I'll also send one more fix for exfat.

Kind regards,
Petr
