From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Mar 2020 17:14:44 +0200
Subject: [LTP] [PATCH V3] uart: add uart testcase in kernel
 device-drivers
In-Reply-To: <CAF12kFv9+Bu5q9XxbeUUBuSCWKgSt6dYEwmaepsCUP9qX8OxaQ@mail.gmail.com>
References: <20200331065442.28591-1-gengcixi@gmail.com>
 <20200331074154.GA23091@dell5510>
 <CAF12kFv9+Bu5q9XxbeUUBuSCWKgSt6dYEwmaepsCUP9qX8OxaQ@mail.gmail.com>
Message-ID: <20200331151444.GC2900@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I hope the ltp test devices have a more convenient way???
> like auto detect if the machine have these devices
> and can run the device test.
> Now we only test the uart device,we can export PORTxx for the test.
> but if we have to test dozens or even hundreds devices,
> the way to set device environment variable needed test is very trouble and
> time consuming
> So I don't think add need_devices is the best desirable way

I think that the right way is that the detection is in the test
execution framework, not it the test, where it does not belong.

So either the execution framework has to be able to re-run the test for
each UART pair, or we have to be able to pass more structured data to
the test. I will think a bit more about this.

-- 
Cyril Hrubis
chrubis@suse.cz
