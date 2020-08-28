From: Bird, Tim <Tim.Bird@sony.com>
Date: Fri, 28 Aug 2020 15:37:52 +0000
Subject: [LTP] [RFC] ltp test add reboot function
In-Reply-To: <20200828130638.GD10501@yuki.lan>
References: <CAF12kFuE=4-T=eitwSb0F3fkGLLsmM3VEg4VNbioqJt2JiAEww@mail.gmail.com>
 <20200824074226.GB2466@yuki.lan>
 <CAF12kFvScxqxhY5wXTGL2RKnyM5vM0hEKDc+sHD-3Y=_C7FWcw@mail.gmail.com>
 <20200828130638.GD10501@yuki.lan>
Message-ID: <CY4PR13MB11754F0072967B32B007D273FD520@CY4PR13MB1175.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From:  Cyril Hrubis
> 
> Hi!
> > Thanks for you experiences on the reboot???
> > So far my opinion is add a reboot service by chkconfig or something like that.
> > the service will start runltp scripts from last break off point.
> > when the tst_test have .tst_needs_reboot =1 flag, it wil strore the
> > run status and
> > reboot the machine before run the test case.
> > Now I want to know what needs to be preserved???
> 
> The runltp script and ltp-pan cannot save and restore a testrun,
> although something like that may be possible to implement, I doubt that
> it could be easily added to the current infrastructure. Not to mention
> that ltp-pan has been in a maintenance mode (which means no new
> features) for years now.
> 
> Also I do consider the whole concept of running the test exectution
> framework on the same machine as the testcases broken by desing for
> kernel related tests. The way forward is the patchset send by Richard
> that implements simple test executor that runs on the machine under test
> and communicates with a execution framework that runs on a central
> server.

I don't have anything to contribute to the primary discussion topic,
but I just have to chime in here that it's very nice to hear someone
else express this idea.  Fuego's architecture is built on having the test
execution driven from a machine external to the machine under test.
To me, having the machine under test drive its own test execution seems weird,
in that it requires the machine to potentially perform actions (like reboot,
or saving panic data), that require operational fitness - which is the very thing
being tested.

Sorry - just had to vent a little.  I "preach" this a lot, and it's nice to the same
opinion from someone else.
 -- Tim

