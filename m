From: Filip Bozuta <fbozuta1@gmail.com>
Date: Fri, 24 Apr 2020 21:54:21 +0200
Subject: [LTP] [PATCH v2 0/3] Add tests for a group of real time clock
 ioctls
In-Reply-To: <20200424145838.GA3421@yuki.lan>
References: <20200423150626.12672-1-fbozuta1@gmail.com>
 <20200424145838.GA3421@yuki.lan>
Message-ID: <CAGbDZEonwc3TALEE0EsmU1=K3pxQuhdY_hZKDKGNWck1JPw2tQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Cyrill,

Thank you for your response!

I didn't take a look at the file
testcases/kernel/device-drivers/rtc/rtc01.c when writing rtc ioctl tests.
I see that it runs tests for certain ioctls that are covered in the patches
I sent (i.e. RTC_RD_TIME, RTC_SET_TIME, RTC_AIE_ON,...).

As I see, this file runs tests for certain ioctls more thoroughly than my
test since it is meant to test the functionality of the rtc driver. My
tests are only meant to test the functionalities of rtc ioctls without
testing whether the driver works correctly. For instance, when running
tests for ioctls used for interrupts (RTC_AIE_ON, RTC_AIE_OFF,
RTC_PIE_ON,...), I only check whether these ioctls work to turn on/off rtc
interrupts (alarm, periodic, update, watchdog). I don't check whether the
interrupts work on the driver correctly.

Anyway, I am new to LTP so I am not that familiar with the scope of
functionalities ioctl tests should cover. Any feedback you can give me on
this would be greatly appreciated.

I am looking forward to your review of my patches.

Best regards,
Filip

On Fri, Apr 24, 2020 at 4:58 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> Looking at these I guess that we should also delete the
> testcases/kernel/device-drivers/rtc/ as a last patch in this series
> since these tests seems to cover a bit more than the original test.
>
> I will have a closer look at the patchset next week.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200424/2a05c03b/attachment.htm>
