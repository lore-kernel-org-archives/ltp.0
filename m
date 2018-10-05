From: vishnu <vishnu@zilogic.com>
Date: Fri, 05 Oct 2018 12:35:59 -0000
Subject: [LTP] [PATCH v1] Test statx() with flag AT_NO_AUTOMOUNT.
References: <20180920112731.6108-1-vishnu@zilogic.com>
 <20181004104103.GA5070@rei>
Message-ID: <4bce235b57e880880c53fc56c6b8c20f.squirrel@pike.zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

>> +	pid = SAFE_FORK();
>> +	if (!pid) {
>> +		setpgrp();
>
> Why do you do this?

* Parent is getting the autofs notification message only by setting
  the process group ID of the child process to it's process ID.


>
>> +		TEST(statx(AT_FDCWD, MNTPOINT,
>> +			   (automount) ? 0 : AT_NO_AUTOMOUNT,
>> +			   0, &file_info)
>> +		     );
>> +
>> +		if (TST_RET == -1) {
>> +			/* 1 -> statx() fail*/
>> +			value = 1;
>> +			SAFE_WRITE(1, ev_fd, &value, sizeof(value));
>> +
>> +			exit(1);
>> +		}
>> +
>> +		/* 2 -> statx() pass*/
>> +		value = 2;
>> +		SAFE_WRITE(1, ev_fd, &value, sizeof(value));
>
> There is no need to propagate anything from the child process, if you
> call tst_res(TPASS, ...) in the child process the result will be
> propagated automatically to the parent. So there is no need for the
> eventfd at all.

* Parent won't get any autofs request from child if,
  ** statx fails
  ** statx with AT_NO_AUTOMOUNT flag

  We tried using event_fd() in order to identify between these two
  scenarios and read from pipe only if statx passed.
  Breaking the test from the child if statx fails is not affecting the
  parent.

Thanks and Regards,
Vishnu K




