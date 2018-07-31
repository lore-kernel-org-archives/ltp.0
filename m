From: Eddie Horng <eddiehorng.tw@gmail.com>
Date: Tue, 31 Jul 2018 14:46:04 +0800
Subject: [LTP] [PATCH] syscalls/execveat01: new test to verify execveat
 unlinked fd
In-Reply-To: <20180727094703.GB914@rei>
References: <1532678306.28611.1.camel@mtkswgap22> <20180727094703.GB914@rei>
Message-ID: <CALLuPvrDgQX8XB-oVL_gm58cwRSinVNXTk5PzyUxcG8fG+Wcmw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

2018-07-27 17:47 GMT+08:00 Cyril Hrubis <chrubis@suse.cz>:
>> +int main(void)
>> +{
>> +     printf("Hello World\n");
>> +     exit(0);
>
> You can print the TPASS message from here and the result will be
> propagated to the parent program. You just need to call tst_reinit()
> that will initialize the test library. See creat07_child.c.
>

Hi Cyril,
I removed "if (status == 0) tst_res(TPASS, ..." from execveat01.c and
add "tst_res(TPASS, ..." in execveat_child.c, but I got a no reported
result error:

execveat_child.c:44: PASS: execveat_child run as expected
tst_test.c:869: BROK: Test haven't reported results!

It seems child's test result doesn't propagated to parent.
Do I use wrong API in child or miss something in parent?

thanks,
Eddie
