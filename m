From: Cixi Geng <gengcixi@gmail.com>
Date: Tue, 25 Aug 2020 09:52:33 +0800
Subject: [LTP] [RFC] ltp test add reboot function
In-Reply-To: <20200824074226.GB2466@yuki.lan>
References: <CAF12kFuE=4-T=eitwSb0F3fkGLLsmM3VEg4VNbioqJt2JiAEww@mail.gmail.com>
 <20200824074226.GB2466@yuki.lan>
Message-ID: <CAF12kFvScxqxhY5wXTGL2RKnyM5vM0hEKDc+sHD-3Y=_C7FWcw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thanks for you experiences on the reboot?
So far my opinion is add a reboot service by chkconfig or something like that.
the service will start runltp scripts from last break off point.
when the tst_test have .tst_needs_reboot =1 flag, it wil strore the
run status and
reboot the machine before run the test case.
Now I want to know what needs to be preserved?

Cyril Hrubis <chrubis@suse.cz> ?2020?8?24??? ??3:41???
>
> Hi!
> > I want to add a reboot function in LTP for my team write a memory page
> > related case???
> > and need reboot to make the memory cache or some likely it pure clear.
> >
> > So I want to add a tst_needs_reboot. when it was set, reboot the
> > machine and continue run test from the point before.
> >
> > I think  this requirement is meaningful??? So can you give me some advise?
>
> Yes it is, actually you are not the only one who needs that. There are
> plenty of other testcases that will have to reboot the machine, for
> example the kexec() syscall tests, MCE injection tests, etc.
>
> What I wanted to add is a bit similar to your proposal.
>
> I wanted to add reboots_machine flag to the tst_test structure, which
> will inform the test framework that the test will reboot the machine in
> the middle of the test.
>
> * The framework will have to inevitably run on a differen machine, but the
>   runltp-ng already does that.
>
> * The framework will reconnect to the machine after a reboot and
>   re-execute the test with a flag that would say that this is a second
>   stage of the test, i.e. after reboot.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
