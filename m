From: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Date: Wed, 18 Jul 2018 10:27:36 +0900
Subject: [LTP] [RFC] new LTP testrunner
In-Reply-To: <1174539544.33712886.1531838009077.JavaMail.zimbra@redhat.com>
References: <20180717114328.GB27873@rei>
 <1174539544.33712886.1531838009077.JavaMail.zimbra@redhat.com>
Message-ID: <001501d41e36$82a5acb0$87f10610$@toshiba.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Cyril, Jan:
Cc: Fuego mailing list

In the Fuego test project (http://fuegotest.org/) we are using LTP test wrappers and parsing tools [1] that have very similar functionality to your proof-of-concept LTP testrunner: execution backends (e.g.: ssh/serial/ttc/local), results parsing (json output), visualization (html/xls) or board power control (actually on-going work). In addition, we have support for cross-compilation, deployment, POSIX and RT test suites parsing, and pre-checks (kernel config, kernel version, runtime dependencies, etc).

As a user of LTP, I would like to contribute with a few learned lessons that you may want to consider if you go on and finish the testrunner.
- Reusable components: build scripts, results parsing, board control and visualization tools need to be independent (e.g.: separate commands with arguments). Once they are independent, you can create glue code on top of them to create your CI loop. For example, in Fuego we already have a visualization tool common to many tests, but it would be great to reuse your JSON parsing tool instead of having to maintain our own. Also, many CI frameworks execute tests in phases (e.g.: build, run, parse). If the testrunner tries to do everything at once it will be hard to split the CI loop into phases. Another important point is that those components need to provide an interface (e.g. --use-script myscript.sh) for users to overload certain operations. For example, it would be useful for users to be able to add new customized backends or board control scripts.
- Minimal runtime: the _execution_ of the test on the target (DUT/SUP) should not have big dependencies. This means that the script that runs on the target may depend on a posix shell, but should not depend (it can be optional) on perl, python, gcc or an internet connection being available.
- Individual tests: having support for building, deploying, executing and parsing single test cases is very useful. For example, some target boards have a small flash memory size or lack ethernet connection. Deploying all of the LTP binaries to such systems can be a hurdle. One of the problems we have now in Fuego is that deploying a single LTP test case is complicated [2]: I could not find a clear way to infer the runtime dependencies of a single test case. Some tests require multiple binaries and scripts that need to be deployed to the target.
- JSON format: tests that provide output in JSON format are easy to parse. When you have test cases inside test sets, the best json abstraction that I have found is the one used in the SQUAD project [3]
- Visualization: LTP has a ton of test cases. Visualization must let you find problems quickly (e.g. hide tests that passed) and let you see the error log for that particular test case.

Overall, I think your proof-of-concept is going in a good direction. I hope you find some of the above useful.

Thanks,
Daniel Sangorrin

[1] https://bitbucket.org/tbird20d/fuego-core/src/15e320785ce6a5633986f6b36d4e5cdbf5bee8ff/engine/tests/Functional.LTP/?at=master
[2] https://bitbucket.org/tbird20d/fuego-core/src/15e320785ce6a5633986f6b36d4e5cdbf5bee8ff/engine/tests/Functional.LTP_one_test/?at=master
[3] https://github.com/Linaro/squad/blob/master/doc/intro.rst

> -----Original Message-----
> From: ltp <ltp-bounces+daniel.sangorrin=toshiba.co.jp@lists.linux.it> On Behalf
> Of Jan Stancek
> Sent: Tuesday, July 17, 2018 11:33 PM
> To: Cyril Hrubis <chrubis@suse.cz>
> Cc: ltp@lists.linux.it
> Subject: Re: [LTP] [RFC] new LTP testrunner
> 
> 
> ----- Original Message -----
> > Hi!
> > I've been playing with the idea of replacing the runltp + ltp-pan with
> > something more modern and prototyped another take on the new LTP
> > testrunner during this SUSE hackweek.
> >
> > The key point of the new testrunner is that the logic that executes the
> > testcases and writes down the test results is being run on a separate
> > machine so that we can outlive and recover from kernel crashes.
> 
> Hi,
> 
> first impression comments below. I know you want
> to avoid "one solution fits all", but I'm listing
> some RFEs that I think are common.
> 
> - "installation of the system is left out"
> Agreed, there are many provisioning solutions out there.
> 
> - replacing runltp + ltp-pan
> What I'm missing is the local use-case we have now. Something
> like backend:local, that will run the test on local system
> and produce same format of results. ssh into localhost
> adds complexity - some test wrapper might not know the
> password for system it has been spawned on.
> 
> The way we coped with (fatal) issues is pre-processing
> runtest files based on kernel version, package versions,
> architecture, etc.
> 
> IMO backend:local (and ssh) might be closest to what people do now.
> 
> - RFE: filter tests
> have ability to run only some tests based on some filter
> which is very common question I get about runltp
> 
> - RFE: skip build/installation
> for some cross-compiling users
> 
> - "All backends needs to be able to reach internet"
> Why is this needed?
> 
> Regards,
> Jan
> 
> >
> > It's still in a proof-of-concept state but I've been able to execute the
> > CVE testrun or older distributions under qemu and outlive several kernel
> > crashes:
> >
> > http://metan.ucw.cz/outgoing/cve.html
> >
> > As well as to run the same testrun on RPI over SSH and reboot it via
> > relay connected to the reset pin header when the kernel has crashed:
> >
> > http://metan.ucw.cz/outgoing/rpi.html
> >
> > The code with a short README could be found here:
> >
> > https://github.com/metan-ucw/ltp/tree/master/tools/runltp-ng
> >
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp


