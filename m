From: nousi <bnousilal@gmail.com>
Date: Mon, 18 Jul 2016 17:23:14 +0530
Subject: [LTP] sendmsg01 failure
In-Reply-To: <764436440.5908995.1468841520559.JavaMail.zimbra@redhat.com>
References: <CAJ5vXcT-k95n1DqmZjcPo=y+K=ZMb=MHwWNX7_P9pV9Rsh2s5g@mail.gmail.com>
 <764436440.5908995.1468841520559.JavaMail.zimbra@redhat.com>
Message-ID: <CAJ5vXcTZnnpmGpOqjtTb-j+8ZJiUUjVp5XFqYmhrDf77ei8BNQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,

Please, have a look at the versions below.
Please, let me know if you need any further information.

Kernel: Linux 3.14.65
Archtecture: aarch64 GNU/Linux
LTP version : 20150119


On Mon, Jul 18, 2016 at 5:02 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > From: "nousi" <bnousilal@gmail.com>
> > To: ltp@lists.linux.it
> > Sent: Friday, 15 July, 2016 2:47:36 PM
> > Subject: [LTP] sendmsg01 failure
> >
> > Hi,
> >
> > what could be the reason for the below the error?
> > Please let me know if I need to enable something in the kernel.
> >
> > sendmsg01 13 TFAIL : sendmsg01.c:437: invalid flags set w/ control ;
> returned
> > -1 (expected -1), errno 22 (expected 95)
>
> That specific flag combination has been removed from test in February:
>
> https://github.com/linux-test-project/ltp/commit/44861ca152cbe5ffff890e055a304d3b74f8bf21
>
> In future it would be handy to include your LTP version, kernel version,
> architecture and distro you are running.
>
> Regards,
> Jan
>
> >
> > root@nousi:/opt/ltp# ./testcases/bin/sendmsg01
> > sendmsg01 1 TPASS : bad file descriptor successful
> > sendmsg01 2 TPASS : invalid socket successful
> > sendmsg01 3 TPASS : invalid send buffer successful
> > sendmsg01 4 TPASS : connected TCP successful
> > sendmsg01 5 TPASS : not connected TCP successful
> > sendmsg01 6 TPASS : invalid to buffer length successful
> > sendmsg01 7 TPASS : invalid to buffer successful
> > sendmsg01 8 TPASS : UDP message too big successful
> > sendmsg01 9 TPASS : local endpoint shutdown successful
> > sendmsg01 10 TPASS : invalid iovec pointer successful
> > sendmsg01 11 TPASS : invalid msghdr pointer successful
> > sendmsg01 12 TPASS : rights passing successful
> > sendmsg01 13 TFAIL : sendmsg01.c:437: invalid flags set w/ control ;
> returned
> > -1 (expected -1), errno 22 (expected 95)
> > sendmsg01 14 TPASS : invalid flags set successful
> > sendmsg01 15 TPASS : invalid cmsg length successful
> > sendmsg01 16 TPASS : invalid cmsg pointer successful
> >
> > --
> > Thanks & Regards,
> > B.Nousilal,
> >
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
>



-- 


*Thanks & Regards,B.Nousilal,*
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160718/eb4c445f/attachment.html>
