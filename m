From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri, 10 Sep 2021 10:35:32 +0200
Subject: [LTP] [PATCH 2/2] rtc01: add workaround for broken CMOS RTC on
 Microsoft Hyper-V cloud
In-Reply-To: <YTsYqBJP8oWiuEGQ@yuki>
References: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
 <20210909163326.42598-2-krzysztof.kozlowski@canonical.com>
 <YTsYqBJP8oWiuEGQ@yuki>
Message-ID: <d50543f0-6e41-8911-e24b-ba0ae61185fa@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/09/2021 10:34, Cyril Hrubis wrote:
> Hi!
>> rtc01 fails on missed alarm on multiple different Azure instances if the
>> alarm is set for the next minute:
>>
>>   rtc01 0 TINFO : RTC READ TEST:
>>   rtc01 1 TPASS : RTC READ TEST Passed
>>   rtc01 0 TINFO : Current RTC date/time is 11-6-2021, 09:00:58.
>>   rtc01 0 TINFO : RTC ALARM TEST :
>>   rtc01 0 TINFO : Alarm time set to 09:01:03.
>>   rtc01 0 TINFO : Waiting 5 seconds for the alarm...
>>   rtc01 2 TFAIL : rtc01.c:151: Timed out waiting for the alarm
>>
>> Reproduced easily with rtcwake:
>>
>>   $ rtcwake -d rtc0 -m on -s 50 -v
>>
>> If alarm is set for now+60 seconds, it works fine.  Clearly Microsoft
>> Hyper-V cloud instances have a broken CMOS RTC which unfortunately
>> cannot be easily fixed.  Adding simple workaround to extend the time to
>> 60 seconds allows to avoid false positives in expense of longer testing
>> time.
> 
> I do not think that adding workarounds for a broken platforms into
> testcases is a right thing to do.

I am actually also not sure, but the broken platform is one of three
main cloud providers. :)


Best regards,
Krzysztof
