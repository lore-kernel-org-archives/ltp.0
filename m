From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Jul 2018 13:43:28 +0200
Subject: [LTP] [RFC] new LTP testrunner
Message-ID: <20180717114328.GB27873@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've been playing with the idea of replacing the runltp + ltp-pan with
something more modern and prototyped another take on the new LTP
testrunner during this SUSE hackweek.

The key point of the new testrunner is that the logic that executes the
testcases and writes down the test results is being run on a separate
machine so that we can outlive and recover from kernel crashes.

It's still in a proof-of-concept state but I've been able to execute the
CVE testrun or older distributions under qemu and outlive several kernel
crashes:

http://metan.ucw.cz/outgoing/cve.html

As well as to run the same testrun on RPI over SSH and reboot it via
relay connected to the reset pin header when the kernel has crashed:

http://metan.ucw.cz/outgoing/rpi.html

The code with a short README could be found here:

https://github.com/metan-ucw/ltp/tree/master/tools/runltp-ng

-- 
Cyril Hrubis
chrubis@suse.cz
