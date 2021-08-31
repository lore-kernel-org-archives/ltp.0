From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Tue, 31 Aug 2021 12:19:44 +0800
Subject: [LTP] [PATCH] gettid:Convert gettid01 to new API
In-Reply-To: <OSZP286MB08712631399F14EC1329DFEDCCCC9@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
References: <20210831024617.246758-1-threefifteen.wangkunfeng@huawei.com>
 <OSZP286MB08712631399F14EC1329DFEDCCCC9@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <OSZP286MB087197527B5E59DC13C2195CCCCC9@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


>> --- a/testcases/kernel/syscalls/gettid/gettid01.c
>> +++ b/testcases/kernel/syscalls/gettid/gettid01.c
>> @@ -1,3 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0
> The license here should be GPL-2.0-later.
Sorry, GPL-2.0-or-later.
>> ? /*
>> ?? * Crackerjack Project
>> ?? *

-- 
Best Regards,
Xie Ziyao
E-mail: ziyaoxie@outlook.com

