From: Cixi Geng <gengcixi@gmail.com>
Date: Fri, 27 Mar 2020 10:44:31 +0800
Subject: [LTP] [PATCH v2] uart: add uart testcase in kernel
 device-drivers
In-Reply-To: <20200326070555.GA17560@dell5510>
References: <20200324121742.7130-1-gengcixi@gmail.com>
 <20200325102852.GD5404@yuki.lan> <20200325152821.GA21800@dell5510>
 <CAF12kFv0P4yTVVf-pfXOai8+3urEiWug_dbnTfAXpyfOvzi2ug@mail.gmail.com>
 <20200326070555.GA17560@dell5510>
Message-ID: <CAF12kFuqJQmiZW+otpb9Hp37kqVis9UzkOKJTMKQWCPnH1nPoQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr:
>> +    { sleep 1; serialcheck -b $UART_RATE -d $1 -f $temp_test_file -l
$UART_LOOPS -m t -${UART_HWFLOW}; }&
>Cyril already mentioned the need to use proper locks instead of sleep
I have realized the sleep is not a good way , but I don't have any idea
about the "proper locks"
Can you give me some help?

Petr Vorel <pvorel@suse.cz> ?2020?3?26??? ??3:05???

> Hi Cixi,
>
> > >We both Cyril and me mentioned that you don't need to use mktemp (+
> it'd be
> > >unnecessary dependency).
> > Now I knew  TST_NEEDS_TMPDIR  is make a temp direct and cd in it ,
> > but I need a file contains random data, this file is to used to test the
> > PORT,
> > Do you meaning I should creat a normal file use dd ,and named by myself?
> Yes. We do not care about test concurrency of the same test (i.e. the same
> test
> run more times simultaneously). And even if we care it could be solved by
> adding $$ -
> PID, i.e.: foo.$$ (but you don't need to).
> BTW I wrote it in
> https://lists.linux.it/pipermail/ltp/2020-March/016107.html
>
> > >> This is problematic as well, it expects that all ports that are not
> > >> in-use are loopback connected. This is not true in general case, which
> > >> means that we cannot add the test to the kernel_misc runtest file as
> it
> > >> is because it will fail on most of the systems out there.
> > >Oh, I didn't realize this obvious thing.
> > >> We will have to figure out how to pass which ports are interconnected
> to
> > >> the test somehow, because that is something that only the user who set
> > >> up the machine knows.
> > >Maybe expect user sets it in some variable before running the test?
> e.g.:
> > we can decide  which PORT can be test,  But just like Cyril said, we
> don't
> > know the machines is run int loopback mode or  HW flow control  mode,
> > So can I put the testcase tags into two file in the runtest, one is used
> to
> > test
> > loopback mode, and the other is test for   HW flow control  ?
> > runtest/uart-loopback
> > runtest/uart-HWflow
>
> Wouldn't it help this below?
> > > Maybe expect user sets it in some variable before running the test?
> e.g.:
>
> > > if [ -n "$UART_INTERCONNECTED_PORTS" ]; then
> > >     tst_brk TCONF "set space separated interconnected ports in
> > > \$UART_INTERCONNECTED_PORTS"
> > > fi
>
> Kind regards,
> Petr
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200327/b9353681/attachment.htm>
