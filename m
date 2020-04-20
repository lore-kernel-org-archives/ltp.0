From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 20 Apr 2020 10:23:48 +0800
Subject: [LTP] [PATCH v2 02/10] syscalls/ioctl:add common c file for
 loop ioctl
In-Reply-To: <20200417151050.GA2491@yuki.lan>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1586429086-22975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200417151050.GA2491@yuki.lan>
Message-ID: <8dd0a496-c46f-55d2-2393-5566eff618ff@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi!
>> +/*
>> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> + */
>> +#define TST_NO_DEFAULT_MAIN
>> +#include "ioctl_loop_support.h"
>> +#include "tst_test.h"
>> +
>> +void check_sys_value(char *path, int setvalue)
>> +{
>> +	int getvalue;
>> +
>> +	SAFE_FILE_SCANF(path, "%d", &getvalue);
>> +	if (setvalue == getvalue)
>> +		tst_res(TPASS, "%s value is %d", path, setvalue);
>> +	else
>> +		tst_res(TFAIL, "%s value expected %d got %d", path, setvalue, getvalue);
>> +}
>> +
>> +void check_sys_string(char *path, char *setmessage)
>> +{
>> +	char getmessage[1024];
>> +
>> +	SAFE_FILE_SCANF(path, "%s", getmessage);
>> +	if (strcmp(setmessage, getmessage))
>> +		tst_res(TFAIL, "%s expected %s got %s", path, setmessage, getmessage);
>> +	else
>> +		tst_res(TPASS, "%s string is %s", path, getmessage);
>> +}
> 
> In the end I've renamed and moved these functions into the test library
> because the functionality is generic enough and I doubt that these
> tests would be the only one using it.
That's great.  I remember prctl cases use this function. Also, in some 
cap cases, it needs bitwise operators(I only know prctl08.c). Maybe we 
can add TST_ASSERT_BITWISE?
> 


