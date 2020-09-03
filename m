From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Sep 2020 11:24:48 +0200
Subject: [LTP] [RFC] ltp test add reboot function
In-Reply-To: <CAF12kFspG2fQKUrA=HGWGQuHy=xJaL0gntqvksq+QmUK3mAdKw@mail.gmail.com>
References: <CAF12kFuE=4-T=eitwSb0F3fkGLLsmM3VEg4VNbioqJt2JiAEww@mail.gmail.com>
 <20200824074226.GB2466@yuki.lan>
 <CAF12kFvScxqxhY5wXTGL2RKnyM5vM0hEKDc+sHD-3Y=_C7FWcw@mail.gmail.com>
 <20200828130638.GD10501@yuki.lan>
 <CY4PR13MB11754F0072967B32B007D273FD520@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAF12kFspG2fQKUrA=HGWGQuHy=xJaL0gntqvksq+QmUK3mAdKw@mail.gmail.com>
Message-ID: <20200903092448.GC6285@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >Also I do consider the whole concept of running the test exectution
> >framework on the same machine as the testcases broken by desing for
> >kernel related tests. The way forward is the patchset send by Richard
> >that implements simple test executor that runs on the machine under test
> >and communicates with a execution framework that runs on a central
> >server.
> 
> I agree with some of your views??? the test architecture server/slave is most
> common test method. but I also want to know what kind of connection
> method between test machine and central server,  the ssh , adb or serial?
> 
> because my test machine is a cellphone, our purpose is test the kernel before
> androidOS , so I build debianOS on our haraware, and we can only used the
> serial port communicate with our testmachine.

As for LTP the tool Richard is working on is a daemon that runs on the
SUT[1], will be quite possibly started during the boot and will listen
on pre-defined transport channels, e.g. TCP, serial, bluetooth, etc. The
protocol itself should be transport agnostic and should work over
anything that can transport bytes. But that is something that is under
development at the moment.

-- 
Cyril Hrubis
chrubis@suse.cz
