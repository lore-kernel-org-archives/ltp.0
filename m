From: umeshyv <umeshyv@gmail.com>
Date: Tue, 26 Jun 2018 21:25:14 +0530
Subject: [LTP] runltp fails with Buildroot
In-Reply-To: <20180625134200.GB24288@rei>
References: <CA+Kjy2zzPOUcUP7yYu-OcA4NrKhp+fNW9PNObfxiAuPWsUw0eg@mail.gmail.com>
 <20180625134200.GB24288@rei>
Message-ID: <CA+Kjy2zehQeA8c1gfmj4jXDDdPwdTWkS41aH=B7guXnRDS8m4A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

Now I am able to run runltp on my raspberry pi target. I have added a new
i2c test case under testcases folder, please help me how could I run this
test alone with runltp and email the result.

I executed as follows

. /runltp -a <email > -p -o output.log <path to LTP in the
target>/testcases/bin/<testname>

When I executed the above all the test are running.

Also how could I add to runtest and runtestltplite.sh

Please suggest.

Thanks
UmaMahesh


On Mon 25 Jun, 2018, 19:12 Cyril Hrubis, <chrubis@suse.cz> wrote:

> Hi!
> > I compiled  LTP package with Buildroot for Raspberry target, when I
> execute
> > ./runltp it fails. Could anyone suggest on this.
>
> Can you please share the steps you did and the error trace you get?
>
> Without that we cannot help you at all.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180626/d26a69a9/attachment.html>
