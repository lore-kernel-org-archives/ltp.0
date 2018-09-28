From: Nixiaoming <nixiaoming@huawei.com>
Date: Fri, 28 Sep 2018 07:11:36 +0000
Subject: [LTP] [PATCH v4] syscalls/fanotify11: new test for report
	thread id
In-Reply-To: <CAOQ4uxh4E-9sZqZ7n7DaeDTS1wT6LHMJwq=oO3=cLMrhNaZTow@mail.gmail.com>
References: <20180928010958.20601-1-nixiaoming@huawei.com>
 <CAOQ4uxh4E-9sZqZ7n7DaeDTS1wT6LHMJwq=oO3=cLMrhNaZTow@mail.gmail.com>
Message-ID: <E490CD805F7529488761C40FD9D26EF12A7DC60D@DGGEMM527-MBS.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sept 28, 2018  3:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
>On Fri, Sep 28, 2018 at 4:58 AM nixiaoming <nixiaoming@huawei.com> wrote:
>>
>> syscalls/fanotify11
>> test fanotify_init with FAN_EVENT_INFO_TID
>>         data->pid is ID(pid)  of the thread that caused the event
>> test fanotify_init without FAN_EVENT_INFO_TID
>>         data->pid is ID(tgid) of the process that caused the event
>>
>> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
>> ---
>>
>> this is not testing an upstream feature, only RFC.
>>
.....
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
>> new file mode 100644
>> index 0000000..45959b4
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
>> @@ -0,0 +1,131 @@
>> +/*
>> + * Copyright (c) 2018 Huawei.  All Rights Reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of version 2 of the GNU General Public License as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it would be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> + *
>> + * Further, this software is distributed without any warranty that it is
>> + * free of the rightful claim of any third person regarding infringement
>> + * or the like.  Any license provided herein, whether implied or
>> + * otherwise, applies only to this software file.  Patent licenses, if
>> + * any, provided herein do not apply to combinations of this program with
>> + * other software, or any other product whatsoever.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, write the Free Software Foundation, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + *
>
>I also need your permission to use license
>SPDX-License-Identifier: GPL-2.0-or-later
>
>Instead of only GPL 2.0.
>
>Thanks,
>Amir.
>

ok, I will update and re-send patch
thanks
