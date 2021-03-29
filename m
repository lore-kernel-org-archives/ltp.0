From: zhaogongyi <zhaogongyi@huawei.com>
Date: Mon, 29 Mar 2021 01:56:07 +0000
Subject: [LTP] [PATCH] syscalls/shmctl: Using TERRNO to macth errno
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389DCB7@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

Actually, I have no effective tools to find out all of this type problems.

Thanks for your review!

Best Regards,
Gongyi



Hi Gongyi,

On Sat, Mar 27, 2021 at 6:24 PM Zhao Gongyi <zhaogongyi@huawei.com<mailto:zhaogongyi@huawei.com>> wrote:
When "shmid == -1", we need print the errno with TERRNO. It must have no error in
TEST, otherwise it has return early.

Right, but it is mostly caused by copy&past.

And, I guess you are working on fix the TERRNO/TTERRNO issues currently,
so it would be great to combine them together in one patch, other than sending
it one by one separately.

Anyway, I help push this. Thanks!

--
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210329/48eecfeb/attachment.htm>
