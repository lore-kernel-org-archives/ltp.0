From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 15 Apr 2016 18:02:48 +0800
Subject: [LTP] question about running input testcase
In-Reply-To: <20160413094000.GA10941@rei.lan>
References: <570DEFC7.4080300@cn.fujitsu.com> <20160413094000.GA10941@rei.lan>
Message-ID: <5710BC48.9070106@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril

to 2016/04/13 17:40, Cyril Hrubis wrote:
> Hi!
> I'm afraid that cedric@suse.com no longer works as Cedric was here only
> for his internship. I can try to ask our kernel developers that he
> worked on these testcases with though.
>
I have runned these test cases in RHEL5.11GA and RHEL6.8Beta.
When above patch is not applied, input/04 and input/05 failed with the following messages.
-----------------------------------------------------------------------------------------
[root@linux6 input]# ./input04
input04     0  TINFO  :  Found uinput dev at /dev/uinput
input04     0  TINFO  :  Unexpected ev type=0 code=0 value=0
input04     1  TFAIL  :  input04.c:65: Data received /dev/inputX
[root@linux6 input]# ./input05
input05     0  TINFO  :  Found uinput dev at /dev/uinput
input05     0  TINFO  :  Unexpected ev type=0 code=0 value=0
input05     1  TFAIL  :  input05.c:69: Data received in eventX

When above patch is applied, input/04 and input/05 passed with the following messages.
-----------------------------------------------------------------------------------------
[root@linux6 input]# ./input04
input04     0  TINFO  :  Found uinput dev at /dev/uinput
input04     1  TPASS  :  No data received in /dev/inputX
[root@linux6 input]# ./input05
input05     0  TINFO  :  Found uinput dev at /dev/uinput
input05     1  TPASS  :  No data received in eventX

So, i think the above patch fixes this bug.

Regards,
Xiao Yang



