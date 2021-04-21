From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Apr 2021 10:32:37 +0200
Subject: [LTP] runltp-ng and possible ltp-pan deprecation
In-Reply-To: <BN7PR13MB249975B793E09DE0D217775DFD489@BN7PR13MB2499.namprd13.prod.outlook.com>
References: <YH7Z8nOX90qjsMpa@yuki>
 <BN7PR13MB249975B793E09DE0D217775DFD489@BN7PR13MB2499.namprd13.prod.outlook.com>
Message-ID: <YH/jJbdk9j7LNu7D@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > For a start I would like to move the code somewhere to the
> > linux-test-project github just to make it more visible. Does everyone
> > agree to that?
> 
> Sounds great to me!  I'm very interested in the new functionality.
> 
> It sounds like I might be interested in adding a backend for running
> tests over a Fuego transport.  Fuego mostly ends up using
> ssh, but it provides other transports as well, so I'll be
> interested to see what your backend API for test-running looks like.

Backend is basically implemented with these functions:

* foo_init() that parses backend specific parameters
             and prepares a handle that is used later on

* foo_start() that boots machine, connects to SUT, ...

	      This gets SUT into a state where we can execute commands
	      on (remote) shell and stores pair of file descriptors to
	      the backend handle

	      for qemu it boots the machine and logs in

	      for ssh it connects to remote machine

	      for sh (local execution) it just forks shell

* foo_stop() that does the oposite of foo_start()

             Closes connection, poweroff qemu OS, etc.

* foo_force_stop() that attempts to force stop the machine after it
                   stopped responding so that we can bring it up again
		   and continue with next test

		   for qemu it just kills the process, we do have
		   overlay for the disks in place, so we always start
		   with a clean state

		   for ssh it's expected that user supplies a script

		     - when I was testing the test runner I had a script
		       that toggled relay to reset the machine

		     - for public cloud testing we pass a short script
		       that requests the machine to be rebooted


If machine crashes we do force_stop() followed by a start() to bring it
back to a defined state.

Everything else is build on a top of these functions. The testcases are
executed using a (remote) shell and the output is parsed, which is not
optimal for a several reasons and may change later on. I guess that the
general API will not change in this case, the difference would be that
once machine starts we would start a binary and talk to it via the file
descriptors instead of shell.

We are also working on parallel test execution, which will require such
binary running on the SUT that will dispatch testcases and report
results, but that haven't been finished yet.

Also in the short term we would like to make use of the metadata.json
produced by LTP build to make smarter decisions, probably easiest and
quite usefull would be adjusting timeout expectations. LTP generally
consists of two types of tests, most of the syscall test are fast and
take only miliseconds, then there are tests that run for minutes or even
scale its runtime based on test timeout. And this is all multiplied by
tests that do several iterations, for instance for each filesystem. I
really need to sit down and think how all this should work toghether.

-- 
Cyril Hrubis
chrubis@suse.cz
