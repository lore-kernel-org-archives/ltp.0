From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Aug 2019 18:10:42 +0800
Subject: [LTP] [PATCH] tst_res: Print errno number in addition to error
 name
In-Reply-To: <20190820095602.GB22253@rei.lan>
References: <20190819133618.7538-1-rpalethorpe@suse.com>
 <20190820095521.GA22253@rei.lan> <20190820095602.GB22253@rei.lan>
Message-ID: <CAEemH2eCNk7tUadvcKcsyGZB+_Hgijg7-yd8Aw-RFtqrQhNLQQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 20, 2019 at 5:56 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > It appears we are atleast missing ENOTSUPP (524) which is probably returned by
> > > create_timer for some alarm clocks on none x86 arches. This isn't entirely
> > > clear, but what is clear is that it would help to know what the error number
> > > is without using strace.
> >
> > Can we please also patch the lib/errnos.h so that the ENOTSUPP is
> > included there as well?
>
> And also patch the timer_create() tests to return TCONF if we got
> ENOTSUPP?

I think we shouldn't TCONF this until we get clear the problem.

This failure very probably a bug for kernel:

# grep RTC_CLASS /boot/config-4.18.0-128.el8.aarch64
CONFIG_RTC_CLASS=y

# ./timer_create01
tst_test.c:1104: INFO: Timeout per run is 0h 05m 00s
...
timer_create01.c:87: FAIL: Failed to create timer for
CLOCK_BOOTTIME_ALARM: ??? (524)
timer_create01.c:87: FAIL: Failed to create timer for
CLOCK_REALTIME_ALARM: ??? (524)

# cat kernel/time/alarmtimer.c -n
...
   57  #ifdef CONFIG_RTC_CLASS
...
    72 struct rtc_device *alarmtimer_get_rtcdev(void)
    73 {
    74         unsigned long flags;
    75         struct rtc_device *ret;
    76
    77         spin_lock_irqsave(&rtcdev_lock, flags);
    78         ret = rtcdev;
    79         spin_unlock_irqrestore(&rtcdev_lock, flags);
    80
    81         return ret;
    82 }
    83 EXPORT_SYMBOL_GPL(alarmtimer_get_rtcdev);
...
   140 #else
   141 struct rtc_device *alarmtimer_get_rtcdev(void)
   142 {
   143         return NULL;
   144 }
   ...
   670 static int alarm_timer_create(struct k_itimer *new_timer)
   671 {
   672         enum  alarmtimer_type type;
   673
   674         if (!alarmtimer_get_rtcdev())
   675                 return -ENOTSUPP;
   676
   677         if (!capable(CAP_WAKE_ALARM))
   678                 return -EPERM;
   679
   680         type = clock2alarm(new_timer->it_clock);
   681         alarm_init(&new_timer->it.alarm.alarmtimer, type,
alarm_handle_timer);
   682         return 0;
   683 }

-- 
Regards,
Li Wang
