From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 17 Jul 2018 10:33:29 -0400 (EDT)
Subject: [LTP] [RFC] new LTP testrunner
In-Reply-To: <20180717114328.GB27873@rei>
References: <20180717114328.GB27873@rei>
Message-ID: <1174539544.33712886.1531838009077.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> I've been playing with the idea of replacing the runltp + ltp-pan with
> something more modern and prototyped another take on the new LTP
> testrunner during this SUSE hackweek.
> 
> The key point of the new testrunner is that the logic that executes the
> testcases and writes down the test results is being run on a separate
> machine so that we can outlive and recover from kernel crashes.

Hi,

first impression comments below. I know you want
to avoid "one solution fits all", but I'm listing
some RFEs that I think are common.

- "installation of the system is left out"
Agreed, there are many provisioning solutions out there.

- replacing runltp + ltp-pan
What I'm missing is the local use-case we have now. Something
like backend:local, that will run the test on local system
and produce same format of results. ssh into localhost
adds complexity - some test wrapper might not know the
password for system it has been spawned on.

The way we coped with (fatal) issues is pre-processing
runtest files based on kernel version, package versions,
architecture, etc.

IMO backend:local (and ssh) might be closest to what people do now.

- RFE: filter tests
have ability to run only some tests based on some filter
which is very common question I get about runltp

- RFE: skip build/installation
for some cross-compiling users
  
- "All backends needs to be able to reach internet"
Why is this needed?

Regards,
Jan

> 
> It's still in a proof-of-concept state but I've been able to execute the
> CVE testrun or older distributions under qemu and outlive several kernel
> crashes:
> 
> http://metan.ucw.cz/outgoing/cve.html
> 
> As well as to run the same testrun on RPI over SSH and reboot it via
> relay connected to the reset pin header when the kernel has crashed:
> 
> http://metan.ucw.cz/outgoing/rpi.html
> 
> The code with a short README could be found here:
> 
> https://github.com/metan-ucw/ltp/tree/master/tools/runltp-ng
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
