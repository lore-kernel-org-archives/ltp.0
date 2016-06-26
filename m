From: Arjan van de Ven <arjanvandeven@gmail.com>
Date: Sun, 26 Jun 2016 12:21:46 -0700
Subject: [LTP] [patch V2 00/20] timer: Refactor the timer wheel
In-Reply-To: <20160626190025.GC11162@amd>
References: <20160617121134.417319325@linutronix.de>
 <1466581044.3188.34.camel@gmail.com>
 <alpine.DEB.2.11.1606221037310.5839@nanos> <20160626190025.GC11162@amd>
Message-ID: <CADyApD27DEZ+gWijd9Mgqg-riBQcv3zhBfP1+xvhe44ePJk_7w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, Jun 26, 2016 at 12:00 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> Umm. I'm not sure if you should be designing kernel...
>
> I have alarm clock application. It does sleep(60) many times till its
> time to wake me up. I'll be very angry if sleep(60) takes 65 seconds
> without some very, very good reason.

I'm fairly sure you shouldn't be designing alarm clock applications!
Because on busy systems you get random (scheduler) delays added to your timer.

Having said that, your example is completely crooked here, sleep()
does not use these kernel timers, it uses hrtimers instead.
(hrtimers also have slack, but an alarm clock application that is this
broken would have the choice to set such slack to 0)

What happened here is that these sigtimewait were actually not great,
it is just about the only application visible interface that's still
in jiffies/HZ,
and in the follow-on patch set, Thomas converted them properly to
hrtimers as well to make them both accurate and CONFIG_HZ independent.
