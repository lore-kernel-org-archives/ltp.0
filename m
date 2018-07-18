From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Jul 2018 10:52:12 +0200
Subject: [LTP] [RFC] new LTP testrunner
In-Reply-To: <001501d41e36$82a5acb0$87f10610$@toshiba.co.jp>
References: <20180717114328.GB27873@rei>
 <1174539544.33712886.1531838009077.JavaMail.zimbra@redhat.com>
 <001501d41e36$82a5acb0$87f10610$@toshiba.co.jp>
Message-ID: <20180718085212.GA24922@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In the Fuego test project (http://fuegotest.org/) we are using LTP
> test wrappers and parsing tools [1] that have very similar
> functionality to your proof-of-concept LTP testrunner: execution
> backends (e.g.: ssh/serial/ttc/local), results parsing (json output),
> visualization (html/xls) or board power control (actually on-going
> work). In addition, we have support for cross-compilation, deployment,
> POSIX and RT test suites parsing, and pre-checks (kernel config,
> kernel version, runtime dependencies, etc).
>
> As a user of LTP, I would like to contribute with a few learned lessons that you may want to consider if you go on and finish the testrunner.

Thanks for the feedback!

BTW: the current testrunner lacks support for openposix testsuite but
that is something I want to add once I have time for it. It should be
reasonably easy job, we just need to locate the binaries instead of
parsing the rutnest files and parse the exit statuses a bit differently
but that should be it.

Can you elaborate a bit more about the pre-checks? I suppose that is
something similar to what Jan was talking about, e.g. disabling known
failures that would crash the target machine etc.

> - Reusable components: build scripts, results parsing, board control
> and visualization tools need to be independent (e.g.: separate
> commands with arguments). Once they are independent, you can create
> glue code on top of them to create your CI loop. For example, in Fuego
> we already have a visualization tool common to many tests, but it
> would be great to reuse your JSON parsing tool instead of having to
> maintain our own. Also, many CI frameworks execute tests in phases
> (e.g.: build, run, parse). If the testrunner tries to do everything at
> once it will be hard to split the CI loop into phases. Another
> important point is that those components need to provide an interface
> (e.g. --use-script myscript.sh) for users to overload certain
> operations. For example, it would be useful for users to be able to
> add new customized backends or board control scripts.

I was trying to isolate different functionalities into separate perl
libraries, the idea is that once the API has stabilized enough you could
for example replace the backend.pm with your implementation and reuse
the rest.

So yes there is modularity in my concept but it not about having
binaries but rather about having reusable libaries you can build on. The
question is how much we can make easily reusable while keeping the code
small and straightforward.

Hoewever I think that with the new testrunner we will eliminate the
parsing phase, the idea is to write the test logs in the target format
right from the beginning by supplying a log formatter. That makes much
more sense if the testrunner runs on a separate machine from the target
machine since that way we will produce a valid JSON or anything else
even if the target machine has crashed.

> - Minimal runtime: the _execution_ of the test on the target (DUT/SUP)
> should not have big dependencies. This means that the script that runs
> on the target may depend on a posix shell, but should not depend (it
> can be optional) on perl, python, gcc or an internet connection being
> available.

Agreed.

> - Individual tests: having support for building, deploying, executing
> and parsing single test cases is very useful. For example, some target
> boards have a small flash memory size or lack ethernet connection.
> Deploying all of the LTP binaries to such systems can be a hurdle. One
> of the problems we have now in Fuego is that deploying a single LTP
> test case is complicated [2]: I could not find a clear way to infer
> the runtime dependencies of a single test case. Some tests require
> multiple binaries and scripts that need to be deployed to the target.

That is a valid point itself, but nothing that we can fix with a new
test execution framework.

I can give you a few hints on that but overall there is no well defined
way how to figure out runtime dependencies for a given test.

I guess that we should discuss this in a separate thread or create a
GitHub issue so that we can follow up on this.

> - JSON format: tests that provide output in JSON format are easy to
> parse. When you have test cases inside test sets, the best json
> abstraction that I have found is the one used in the SQUAD project [3]

Nice hint, thanks for pointing that up, I will look into that.

So far we do not report subtests, the JSON my execution framework
produces is just serialization of the perl data structures I record the
test overall result and logs into, we may do something better later
on...

> - Visualization: LTP has a ton of test cases. Visualization must let
> you find problems quickly (e.g. hide tests that passed) and let you
> see the error log for that particular test case.

This handled by the new testrunner as well, it can produce a html table
with a bit of javascript that allows for all of this. It's still
something I've written over three evenings but it's far better than what
we have currently...

> Overall, I think your proof-of-concept is going in a good direction. I
> hope you find some of the above useful.

Yes I do :-).

-- 
Cyril Hrubis
chrubis@suse.cz
