From: Cixi Geng <gengcixi@gmail.com>
Date: Thu, 26 Mar 2020 14:35:42 +0800
Subject: [LTP] [PATCH v2] uart: add uart testcase in kernel
 device-drivers
In-Reply-To: <20200325152821.GA21800@dell5510>
References: <20200324121742.7130-1-gengcixi@gmail.com>
 <20200325102852.GD5404@yuki.lan> <20200325152821.GA21800@dell5510>
Message-ID: <CAF12kFv0P4yTVVf-pfXOai8+3urEiWug_dbnTfAXpyfOvzi2ug@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi ALL:
Thank you very much for your guidance,
I will follow your some advises, and try to add serialcheck in next version
but I also have some questions

>We both Cyril and me mentioned that you don't need to use mktemp (+ it'd be
>unnecessary dependency).
Now I knew  TST_NEEDS_TMPDIR  is make a temp direct and cd in it ,
but I need a file contains random data, this file is to used to test the
PORT,
Do you meaning I should creat a normal file use dd ,and named by myself?

>> This is problematic as well, it expects that all ports that are not
>> in-use are loopback connected. This is not true in general case, which
>> means that we cannot add the test to the kernel_misc runtest file as it
>> is because it will fail on most of the systems out there.
>Oh, I didn't realize this obvious thing.
>> We will have to figure out how to pass which ports are interconnected to
>> the test somehow, because that is something that only the user who set
>> up the machine knows.
>Maybe expect user sets it in some variable before running the test? e.g.:
we can decide  which PORT can be test,  But just like Cyril said, we don't
know the machines is run int loopback mode or  HW flow control  mode,
So can I put the testcase tags into two file in the runtest, one is used to
test
loopback mode, and the other is test for   HW flow control  ?
runtest/uart-loopback
runtest/uart-HWflow

Petr Vorel <pvorel@suse.cz> ?2020?3?25??? ??11:28???

> Hi,
>
> > This is problematic as well, it expects that all ports that are not
> > in-use are loopback connected. This is not true in general case, which
> > means that we cannot add the test to the kernel_misc runtest file as it
> > is because it will fail on most of the systems out there.
> Oh, I didn't realize this obvious thing.
>
> > We will have to figure out how to pass which ports are interconnected to
> > the test somehow, because that is something that only the user who set
> > up the machine knows.
> Maybe expect user sets it in some variable before running the test? e.g.:
>
> if [ -n "$UART_INTERCONNECTED_PORTS" ]; then
>     tst_brk TCONF "set space separated interconnected ports in
> \$UART_INTERCONNECTED_PORTS"
> fi
>
> Kind regards,
> Petr
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200326/c89669dc/attachment.htm>
