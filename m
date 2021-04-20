From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Apr 2021 15:41:06 +0200
Subject: [LTP] runltp-ng and possible ltp-pan deprecation
Message-ID: <YH7Z8nOX90qjsMpa@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
As you may have know some time ago I have started to work on runltp-ng a
script to replace runltp and ltp-pan.

The new executor is different in several key aspects, for example:

- it can and is supposed to run on a different machine from the system
  under test (although it still supports running on the same machine)

- there are different backends, it can run tests locally, over ssh, or
  start a VM with qemu

- produces different output formats currently html or json

We have been using runltp-ng in SUSE for a while and it works for us
quite well and I think that we need a larger user base now to iron out
all the quirks. So unless someone strongly disagrees I think that it's
time to make it officialy supported test executor for LTP.

I would like to eventually get rid of runltp and ltp-pan, but if that
happens it should be done once everyone switched over to a different
solution and it's probably still at least a year or two from now.

To remind you the code still lives in my private repository at:

https://github.com/metan-ucw/runltp-ng

For a start I would like to move the code somewhere to the
linux-test-project github just to make it more visible. Does everyone
agree to that?

Also there are two different options how to do that. Either we put it
into runltp-ng directory to the LTP git root or we may as well create a
separate repository under the linux-test-project and make it a ltp git
submodule. Any preferencies to that?

-- 
Cyril Hrubis
chrubis@suse.cz
