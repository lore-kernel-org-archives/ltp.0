From: Cixi Geng <gengcixi@gmail.com>
Date: Tue, 31 Mar 2020 17:06:58 +0800
Subject: [LTP] [PATCH V3] uart: add uart testcase in kernel
 device-drivers
In-Reply-To: <20200331074154.GA23091@dell5510>
References: <20200331065442.28591-1-gengcixi@gmail.com>
 <20200331074154.GA23091@dell5510>
Message-ID: <CAF12kFv9+Bu5q9XxbeUUBuSCWKgSt6dYEwmaepsCUP9qX8OxaQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr:
I hope the ltp test devices have a more convenient way?
like auto detect if the machine have these devices
and can run the device test.
Now we only test the uart device,we can export PORTxx for the test.
but if we have to test dozens or even hundreds devices,
the way to set device environment variable needed test is very trouble and
time consuming
So I don't think add need_devices is the best desirable way

Petr Vorel <pvorel@suse.cz> ?2020?3?31??? ??3:41???

> Hi Cixi,
>
> thanks for your patch and effort. While we appreciate it, I have to admit
> that
> Cyril's version is IMHO much cleaner and more adjusted to LTP style.
>
> So I'd vote for him to add the loopback and merge his version.
>
> Kind regards,
> Petr
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200331/1947c7b8/attachment.htm>
