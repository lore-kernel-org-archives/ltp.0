From: Tim.Bird@sony.com <Tim.Bird@sony.com>
Date: Tue, 20 Apr 2021 17:21:38 +0000
Subject: [LTP] runltp-ng and possible ltp-pan deprecation
In-Reply-To: <YH7Z8nOX90qjsMpa@yuki>
References: <YH7Z8nOX90qjsMpa@yuki>
Message-ID: <BN7PR13MB249975B793E09DE0D217775DFD489@BN7PR13MB2499.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf Of Cyril Hrubis
> 
> Hi!
> As you may have know some time ago I have started to work on runltp-ng a
> script to replace runltp and ltp-pan.
> 
> The new executor is different in several key aspects, for example:
> 
> - it can and is supposed to run on a different machine from the system
>   under test (although it still supports running on the same machine)
> 
> - there are different backends, it can run tests locally, over ssh, or
>   start a VM with qemu
> 
> - produces different output formats currently html or json
> 
> We have been using runltp-ng in SUSE for a while and it works for us
> quite well and I think that we need a larger user base now to iron out
> all the quirks. So unless someone strongly disagrees I think that it's
> time to make it officialy supported test executor for LTP.
> 
> I would like to eventually get rid of runltp and ltp-pan, but if that
> happens it should be done once everyone switched over to a different
> solution and it's probably still at least a year or two from now.
> 
> To remind you the code still lives in my private repository at:
> 
> https://github.com/metan-ucw/runltp-ng
> 
> For a start I would like to move the code somewhere to the
> linux-test-project github just to make it more visible. Does everyone
> agree to that?

Sounds great to me!  I'm very interested in the new functionality.

It sounds like I might be interested in adding a backend for running
tests over a Fuego transport.  Fuego mostly ends up using
ssh, but it provides other transports as well, so I'll be
interested to see what your backend API for test-running looks like.

> 
> Also there are two different options how to do that. Either we put it
> into runltp-ng directory to the LTP git root or we may as well create a
> separate repository under the linux-test-project and make it a ltp git
> submodule. Any preferencies to that?

If this is intended to be run with LTP only, then my preference would be to
put it into the LTP repository.
 -- Tim

