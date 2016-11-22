From: nousi <bnousilal@gmail.com>
Date: Tue, 22 Nov 2016 17:00:20 +0530
Subject: [LTP] setregid04_16
In-Reply-To: <20161122082110.GF5620@rei.lan>
References: <CAJ5vXcT-GH08vsrmGFtSnB+jW=9vJbpC6Csw0AbG_otK5FJJpw@mail.gmail.com>
 <20161122082110.GF5620@rei.lan>
Message-ID: <CAJ5vXcRNEmDk-sbbvc_6yFACeB=z78T1_MdbjdMQ3kEhTV1+uA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

please find the details about the running machine.

LTP ver: 20150119
Kernel Version: 3.14.65
glibc version 2.19
I am using ARM architecture.

Do not have strace support on my system

Thanks,
Nousi.


On Tue, Nov 22, 2016 at 1:53 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> please, help with the below error.
>
> What LTP version you have? What kernel version? What glibc version? What
> architecture? Have you tried to strace the testcase to check that
> correct syscall is called?
>
>> root@:/opt/ltp# ./testcases/bin/setregid04_16
>> setregid04_16    1  TPASS  :  real or effective gid was modified as expected
>> setregid04_16    2  TFAIL  :  setregid04.c:146: ERROR: After
>> setregid(users, -1) real gid = 100; effective gid = 65535
>> setregid04_16    0  TINFO  :  Expected: real gid = 100; effective gid = 0
>> setregid04_16    3  TFAIL  :  setregid04.c:146: ERROR: After
>> setregid(root,-1), real gid = 0; effective gid = 65535
>> setregid04_16    0  TINFO  :  Expected: real gid = 0; effective gid = 0
>> setregid04_16    4  TFAIL  :  setregid04.c:146: ERROR: After
>> setregid(-1, -1), real gid = 65535; effective gid = 65535
>> setregid04_16    0  TINFO  :  Expected: real gid = 0; effective gid = 0
>> setregid04_16    5  TFAIL  :  setregid04.c:146: ERROR: After
>> setregid(-1, root) real gid = 65535; effective gid = 0
>> setregid04_16    0  TINFO  :  Expected: real gid = 0; effective gid = 0
>> setregid04_16    6  TFAIL  :  setregid04.c:146: ERROR: After
>> setregid(root, -1), real gid = 0; effective gid = 65535
>> setregid04_16    0  TINFO  :  Expected: real gid = 0; effective gid = 0
>> setregid04_16    7  TPASS  :  real or effective gid was modified as expected
>> setregid04_16    8  TFAIL  :  setregid04.c:146: ERROR: After
>> setregid(-1, -1) real gid = 65535; effective gid = 65535
>> setregid04_16    0  TINFO  :  Expected: real gid = 1; effective gid = 100
>> setregid04_16    9  TFAIL  :  setregid04.c:146: ERROR: After
>> setregid(-1, users) real gid = 65535; effective gid = 100
>> setregid04_16    0  TINFO  :  Expected: real gid = 1; effective gid = 100
>
> Hmm, the gid set to -1 should not change the real/efective gid something
> is wrong here and the value -1 (65535 when printed as unsigned int) does
> change it. No idea what went wrong though.
>
> --
> Cyril Hrubis
> chrubis@suse.cz



-- 
Thanks & Regards,
B.Nousilal,
