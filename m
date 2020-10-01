From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 1 Oct 2020 13:03:36 +0200
Subject: [LTP] [RFC] ltp test add reboot function
In-Reply-To: <CY4PR13MB11757A2A70B0B80BACEA79E0FD330@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CAF12kFuE=4-T=eitwSb0F3fkGLLsmM3VEg4VNbioqJt2JiAEww@mail.gmail.com>
 <20200824074226.GB2466@yuki.lan>
 <CAF12kFvScxqxhY5wXTGL2RKnyM5vM0hEKDc+sHD-3Y=_C7FWcw@mail.gmail.com>
 <20200828130638.GD10501@yuki.lan>
 <CY4PR13MB11754F0072967B32B007D273FD520@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAF12kFspG2fQKUrA=HGWGQuHy=xJaL0gntqvksq+QmUK3mAdKw@mail.gmail.com>
 <20200903092448.GC6285@yuki.lan>
 <CAF12kFvbGhhwyAFnkv+3w2dwvVovTOeE5z+OnqiGz+rQ-5y6ZA@mail.gmail.com>
 <20200930140508.GA12097@yuki.lan>
 <CY4PR13MB11757A2A70B0B80BACEA79E0FD330@CY4PR13MB1175.namprd13.prod.outlook.com>
Message-ID: <20201001110336.GA7349@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that we would have to add a command line parameter to the test
> > library to tell the testcase to continue with the second half of the
> > test. Then after the reboot the testcase would be executed with that
> > option so that it knows that we are running it for a second time and
> > then we have to pass that to the testcases.
> > 
> > And since the uClinux support is dead, we are free to reuse the -C flag
> > for this purpose. Probably easiest solution would be to set a global
> > variable (named tst_rebooted or something similar) if -C was passed to
> > the test on a command line, then we can use the value of this variable
> > in the test setup/verify/cleanup functions.
> 
> Just brainstorming here...
> 
> How about an environment variable that contains the location to resume
> execution.  It could be a specific test case (within a test), or some value that the verify
> function uses to skip down to the place to resume.
> 
> If set, the library would skip the setup operation (or modify it appropriately).
> 
> Something like this:
> 
> LTP_RESUME_POS=reboot_test:testcase_6
> 
> (or some better name :-) )
> 
> The value for the resume position would have to be sent to the test framework,
> so it could set it (in the variable) on machine reboot.  The test framework has to know
> to set something (either -C or LTP_RESUME_POS) so that the test can recognize it is
> in a resume-after-reboot condition.
> 
> OR
> 
> Maybe it's sufficient for the test to create a temp file (in a temp directory that is known
> to be persistent across a reboot, which not all of them are).  The presence of the temp
> file could indicate a resume-after-reboot condition, and it's contents could be used
> to indicate the resume position.

That would mean defining a persistent directory and would be prone to
leftovers, i.e. what happends when a test crashes. I think that having a
environment variable would be much better solution.

> Question: does this "resume-after-reboot" condition need to be recognized by ltp-pan?

First of all I think that ltp-pan is something that does not fit into
this picture at all. Hopefully it will be replaced by runltp-ng in a few
years, which will run on a different host and will simply continue to
run during the time the SUT is rebooted.

> I'm still not sure what is envisioned for the interface between the test and the
> test framework, to detect that it should resume a particular test on DUT reboot.
> If the test is initiating the reboot, maybe it needs to communicate some data to 
> the test framework (or whatever is performing the reboot), so that things can be
> set up during boot to continue where the test left off.

I do see it as:

* The test advertizes to the test executing framework that it reboots
  the machine during the testrun

* When the test is executed the test executing framework will expect
  reboot, wait for the machine to boot and finally re-executes the test

* The execution framework will also pass down the evironment
  variable/command line parameters so that the test picks up where it's
  supposed to.

  This, among other things, makes sure that there is no state saved on
  the SUT and when a test fails after third reboot we will know exactly
  where since we are tracking the state in the execution framework.

Does this make sense?

> We have been envisioning in Fuego supporting an API like the following, for 
> a generic reboot mechanism for rebooting a board:
> 
> CLI:
> lc board {board_name} reboot
> 
> REST API:
> wget https://{lab-control-server}/api/devices/{board_name}/power/reboot
> 
> These are both intended to support immediate reboot of the board, and don't take
> any parameters.  It seems like there's a bit of "knowledge" about the board
> bringup that is outside the scope of just a simple board reboot operation, that would have
> to be conveyed to the test framework and possibly the on-board boot initialization
> code, to accomplish a resume operation for a test.  It's a bit hard to figure out
> where the extra information should reside.  Should the data be placed in
> the reboot API?  Should there be a separate call to the test framework/board control
> software to prepare for a reboot-and-resume-test operation?

Well for the parts that are related to the testrun these probably
belongs to the executing framework. The runltp-ng works in a way where
it drives the execution of the tests, i.e. it waits for a machine to
boot, then starts executing binaries. These binaries are really a single
testcases, each with it's own timemout, etc. Which really means that it
can also handle a test that needs reboot just fine since it will execute
the test binary for a first time, waits for a reboot, then execute the
binary for a second time with correspnding parameters.

What exactly do you mean by the board specific info? I suppose that's
about kernel image, rootfs and where to load these from, right? That
should be probably part of the lab-control to remmeber these between
test requested reboots.

-- 
Cyril Hrubis
chrubis@suse.cz
