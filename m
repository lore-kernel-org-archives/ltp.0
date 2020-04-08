From: Cixi Geng <gengcixi@gmail.com>
Date: Wed, 8 Apr 2020 12:15:30 +0800
Subject: [LTP] [PATCH 2/2] device_drivers/uart01: Add uart01 test
In-Reply-To: <CAF12kFsCfb12Yi=rhAqKSLPUBLkaWPs_-JCQOcucvyu=whYFsw@mail.gmail.com>
References: <20200327134707.4532-1-chrubis@suse.cz>
 <20200327134707.4532-3-chrubis@suse.cz>
 <CAF12kFteeJ6nerju6kwX+Ebzrzd_JPCiJ9jKW4tX9F4Y4s7FEg@mail.gmail.com>
 <20200330152122.GA2699@yuki.lan> <20200331180816.GE2900@yuki.lan>
 <CAF12kFs6H1FgU_77MAMhrn1pK15fp1cx+9wox4k9LN5GxCN=nA@mail.gmail.com>
 <20200401131220.GA3627@yuki.lan>
 <CAF12kFsFsG6Jk0citiGmicq+dyB90i_cG_bcDAMhHiyVPafRdA@mail.gmail.com>
 <20200402093127.GA28452@yuki.lan>
 <CAF12kFvDv8ksxMLDyniwQ=hty6J4Oy5-wvErX=DLrfWmhiwT0w@mail.gmail.com>
 <20200402112309.GA5732@yuki.lan>
 <CAF12kFsCfb12Yi=rhAqKSLPUBLkaWPs_-JCQOcucvyu=whYFsw@mail.gmail.com>
Message-ID: <CAF12kFvV=a5HJgDOAOGgdr2CMJhtVsYJ199T=SM1kyQSp-Js=w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Cyril Hrubis <chrubis@suse.cz> ?2020?4?2??? ??7:22???
>>
>> Hi!
>> > I am sorry that when I run the serialcheck on my laptop,
>> > there always has some error as follow,which mean I cannot
>> > verify the serialcheck on my computer for now.
>> > Failed to ioctl(,TIOCGICOUNT,)  -- test ttyUSB0
>>
>> This one can be ignored, that just means that the counters are not
>> implemented and the statistics are not printed at the test end.
>>
>> > tcgetattr() failed: Input/output error -- test ttyS0
>> > I am trying to find available machine and then run test.
>>
>> That looks like there is no UART to begin with.
>>
>> --
>> Cyril Hrubis
>> chrubis@suse.cz

Hi Cyril:
I would like to know how is it going? lastweek I send the test data .
hope it will helpful.
In my test result  we can found if Rx Tx in different rate,  the test will fail.

1. test ttyUSB0 in loopback use the same baudrate of Rx and Tx , test
pass with 5loop
root@Y50:/home/gcx/project/serialcheck# serialcheck  -b 115200 -d
/dev/ttyUSB0 -f binary -l 5 -m r -k
Needed 64 reads 0 writes loops 5 / 5
Failed to ioctl(,TIOCGICOUNT,)
gcx@Y50:~/project/serialcheck$ serialcheck -b 115200 -d /dev/ttyUSB0
-f binary -m t -l 5 -k
Needed 0 reads 1 writes loops 5 / 5
Failed to ioctl(,TIOCGICOUNT,)
2. test ttyUSB0 in loopback use different baudrate ,Error at the fist loop
root@Y50:/home/gcx/project/serialcheck# serialcheck  -b 9600 -d
/dev/ttyUSB0 -f binary -l 5 -m r -k &
[1] 20764
gcx@Y50:~/project/serialcheck$ serialcheck -b 115200 -d /dev/ttyUSB0
-f binary -m t -l 5 -k
Needed 0 reads 1 writes loops 5 / 5
Failed to ioctl(,TIOCGICOUNT,)
Needed 64 reads 0 writes Oh oh, inconsistency at pos 502 (0x1f6).

Original sample:
000001c0: 91 95 eb b6 82 e9 2a e6  16 5a da a3 c2 51 c4 c9   ......*..Z...Q..
000001d0: c5 51 e1 b7 c9 76 67 d5  09 57 80 77 eb bf 6d d7   .Q...vg..W.w..m.
000001e0: 08 a6 7b fd 52 1b 12 8e  f2 50 c1 b7 a7 52 35 39   ..{.R....P...R59
000001f0: 54 d4 50 96 49 55 35 30  33 52 80 89 8e a9 1e a2   T.P.IU503R......
00000200: 2c a5 0d 1a 26 f6 ea 77  a4 4a b9 69 34 17 cc bc   ,...&..w.J.i4...
00000210: e2 6e 0c f9 e1 11 39 9f  fd ce 94 9e 19 30 f4 1c   .n....9......0..

Received sample:
000001c0: 91 95 eb b6 82 e9 2a e6  16 5a da a3 c2 51 c4 c9   ......*..Z...Q..
000001d0: c5 51 e1 b7 c9 76 67 d5  09 57 80 77 eb bf 6d d7   .Q...vg..W.w..m.
000001e0: 08 a6 7b fd 52 1b 12 8e  f2 50 c1 b7 a7 52 35 39   ..{.R....P...R59
000001f0: 54 d4 50 96 49 55 06 9a  92 01 89 8e a9 1e a2 2c   T.P.IU.........,
00000200: a5 0d 1a 26 f6 ea 77 a4  4a b9 69 34 17 cc bc e2   ...&..w.J.i4....
00000210: 6e 0c f9 e1 11 39 9f fd  ce 94 9e 19 30 f4 1c 74   n....9......0..t
loops 1 / 5
