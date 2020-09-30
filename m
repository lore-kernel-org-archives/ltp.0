From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Sep 2020 16:05:08 +0200
Subject: [LTP] [RFC] ltp test add reboot function
In-Reply-To: <CAF12kFvbGhhwyAFnkv+3w2dwvVovTOeE5z+OnqiGz+rQ-5y6ZA@mail.gmail.com>
References: <CAF12kFuE=4-T=eitwSb0F3fkGLLsmM3VEg4VNbioqJt2JiAEww@mail.gmail.com>
 <20200824074226.GB2466@yuki.lan>
 <CAF12kFvScxqxhY5wXTGL2RKnyM5vM0hEKDc+sHD-3Y=_C7FWcw@mail.gmail.com>
 <20200828130638.GD10501@yuki.lan>
 <CY4PR13MB11754F0072967B32B007D273FD520@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAF12kFspG2fQKUrA=HGWGQuHy=xJaL0gntqvksq+QmUK3mAdKw@mail.gmail.com>
 <20200903092448.GC6285@yuki.lan>
 <CAF12kFvbGhhwyAFnkv+3w2dwvVovTOeE5z+OnqiGz+rQ-5y6ZA@mail.gmail.com>
Message-ID: <20200930140508.GA12097@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I considered  running ltp with reboot function by HOST controller.
> And here I found that if case need reboot before or after it run. the
> HOST controller
> is easy to implement, BUT when the case want reboot between it's verify_func
> I hava no idea that how to continue run the rest verify_func
> continuing after reboot.
> Can you give some guidance?

I guess that we would have to add a command line parameter to the test
library to tell the testcase to continue with the second half of the
test. Then after the reboot the testcase would be executed with that
option so that it knows that we are running it for a second time and
then we have to pass that to the testcases.

And since the uClinux support is dead, we are free to reuse the -C flag
for this purpose. Probably easiest solution would be to set a global
variable (named tst_rebooted or something similar) if -C was passed to
the test on a command line, then we can use the value of this variable
in the test setup/verify/cleanup functions.

-- 
Cyril Hrubis
chrubis@suse.cz
