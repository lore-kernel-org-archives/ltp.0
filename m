From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Fri, 10 Sep 2021 08:03:35 -0300
Subject: [LTP] [PATCH 2/2] rtc01: add workaround for broken CMOS RTC on
 Microsoft Hyper-V cloud
In-Reply-To: <d50543f0-6e41-8911-e24b-ba0ae61185fa@canonical.com>
References: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
 <20210909163326.42598-2-krzysztof.kozlowski@canonical.com>
 <YTsYqBJP8oWiuEGQ@yuki>
 <d50543f0-6e41-8911-e24b-ba0ae61185fa@canonical.com>
Message-ID: <YTs7h87f8bWd+/od@mussarela>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 10, 2021 at 10:35:32AM +0200, Krzysztof Kozlowski wrote:
> On 10/09/2021 10:34, Cyril Hrubis wrote:
> > Hi!
> >> rtc01 fails on missed alarm on multiple different Azure instances if the
> >> alarm is set for the next minute:
> >>
> >>   rtc01 0 TINFO : RTC READ TEST:
> >>   rtc01 1 TPASS : RTC READ TEST Passed
> >>   rtc01 0 TINFO : Current RTC date/time is 11-6-2021, 09:00:58.
> >>   rtc01 0 TINFO : RTC ALARM TEST :
> >>   rtc01 0 TINFO : Alarm time set to 09:01:03.
> >>   rtc01 0 TINFO : Waiting 5 seconds for the alarm...
> >>   rtc01 2 TFAIL : rtc01.c:151: Timed out waiting for the alarm
> >>
> >> Reproduced easily with rtcwake:
> >>
> >>   $ rtcwake -d rtc0 -m on -s 50 -v
> >>
> >> If alarm is set for now+60 seconds, it works fine.  Clearly Microsoft
> >> Hyper-V cloud instances have a broken CMOS RTC which unfortunately
> >> cannot be easily fixed.  Adding simple workaround to extend the time to
> >> 60 seconds allows to avoid false positives in expense of longer testing
> >> time.
> > 
> > I do not think that adding workarounds for a broken platforms into
> > testcases is a right thing to do.
> 
> I am actually also not sure, but the broken platform is one of three
> main cloud providers. :)
> 

The test here is doing the right thing, verifying that the driver behaves as
documented and expected. The kernel should be doing any workarounds/quirks
necessary to make the RTC interface behave as expected.

Once that is done, I think it would be valuable to add to the test the specific
scenario where this is failing. That is, add the specific test where the alarm
seconds is behind the date seconds.

By the way, I have tested it and the reason 60 seconds work is because the
seconds alarm value is most often after the current value. If you use 115, for
example, it will most likely fail, unless you are within that 5 second range
where it doesn't.

The RTC CMOS driver has changed a lot over the years. I wonder if using proper
UIE instead of simulating it with set_alarm would work. But, then,
RTC_ALM_SET+RTC_AIE_ON would still fail.

Also, of note, the VM instances are lacking an HPET, which is used instead of
the old CMOS RTC when present.

Cascardo.

> 
> Best regards,
> Krzysztof
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
