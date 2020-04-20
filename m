From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 20 Apr 2020 14:08:10 +0800
Subject: [LTP] [PATCH v2 02/10] syscalls/ioctl:add common c file for
 loop ioctl
In-Reply-To: <8dd0a496-c46f-55d2-2393-5566eff618ff@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1586429086-22975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200417151050.GA2491@yuki.lan>
 <8dd0a496-c46f-55d2-2393-5566eff618ff@cn.fujitsu.com>
Message-ID: <48142e6b-8169-2934-e8b2-f71927cd62b0@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi Cyril
> 
> 
>> Hi!
>>> +/*
>>> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
>>> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>> + */
>>> +#define TST_NO_DEFAULT_MAIN
>>> +#include "ioctl_loop_support.h"
>>> +#include "tst_test.h"
>>> +
>>> +void check_sys_value(char *path, int setvalue)
>>> +{
>>> +??? int getvalue;
>>> +
>>> +??? SAFE_FILE_SCANF(path, "%d", &getvalue);
>>> +??? if (setvalue == getvalue)
>>> +??????? tst_res(TPASS, "%s value is %d", path, setvalue);
>>> +??? else
>>> +??????? tst_res(TFAIL, "%s value expected %d got %d", path, 
>>> setvalue, getvalue);
>>> +}
>>> +
>>> +void check_sys_string(char *path, char *setmessage)
>>> +{
>>> +??? char getmessage[1024];
>>> +
>>> +??? SAFE_FILE_SCANF(path, "%s", getmessage);
>>> +??? if (strcmp(setmessage, getmessage))
>>> +??????? tst_res(TFAIL, "%s expected %s got %s", path, setmessage, 
>>> getmessage);
>>> +??? else
>>> +??????? tst_res(TPASS, "%s string is %s", path, getmessage);
>>> +}
>>
>> In the end I've renamed and moved these functions into the test library
>> because the functionality is generic enough and I doubt that these
>> tests would be the only one using it.
> That's great.? I remember prctl cases use this function. Also, in some 
> cap cases, it needs bitwise operators(I only know prctl08.c). Maybe we 
> can add TST_ASSERT_BITWISE?
This situation is rarely seen. I want to add two functions such as 
TST_ASSERT_FILE_STR/INT to compare file field string with expected 
string. So, I can use this api for prctl NoNewPrivs and Seccomp field in 
/proc/[pid]/status. What do you think about this?

--- a/lib/tst_assert.c
+++ b/lib/tst_assert.c
@@ -22,6 +22,20 @@ void tst_assert_int(const char *file, const int 
lineno, const char *path, int va
         tst_res_(file, lineno, TFAIL, "%s != %d got %d", path, val, 
sys_val);
  }

+void tst_assert_file_int(const char *file, const int lineno, const char 
*path, const char *buf, int val)
+{
+       int sys_val;
+
+       SAFE_FILE_LINES_SCANF(path, buf, &sys_val);
+
+       if (val == sys_val) {
+               tst_res_(file, lineno, TPASS, "%s %s field = %d", path, 
buf, sys_val);
+               return;
+       }
+
+       tst_res_(file, lineno, TFAIL, "%s %s field != %d got %d", path, 
buf, val, sys_val);
+}
+
  void tst_assert_str(const char *file, const int lineno, const char 
*path, const char *val)
  {
         char sys_val[1024];
@@ -34,3 +48,17 @@ void tst_assert_str(const char *file, const int 
lineno, const char *path, const

         tst_res_(file, lineno, TFAIL, "%s != '%s' got '%s'", path, val, 
sys_val);
  }
+
+void tst_assert_file_str(const char *file, const int lineno, const char 
*path, const char *buf, const char *val)
+{
+       char sys_val[1024];
+
+       SAFE_FILE_LINES_SCANF(path, buf, sys_val);
+
+       if (!strcmp(val, sys_val)) {
+               tst_res_(file, lineno, TPASS, "%s %s field = %s", path, 
buf, sys_val);
+               return;
+       }
+
+       tst_res_(file, lineno, TFAIL, "%s %s field != %s got %s", path, 
buf, val, sys_val);
+}


Best Regards
Yang Xu

>>


