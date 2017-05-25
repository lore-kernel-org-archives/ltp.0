From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 25 May 2017 16:57:47 +0200
Subject: [LTP] [PATCH 1/2] docs: Add running the tests section
In-Reply-To: <20170525123508.GC13101@rei.suse.de>
References: <20170525115744.21720-1-rpalethorpe@suse.com>
 <20170525123508.GC13101@rei.suse.de>
Message-ID: <87lgpl6l1w.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Cyril Hrubis writes:

> Hi!
>> The simplest/shortest possible guide to installing from source and running the tests.
>
> This is a great addition, thanks for writing it, a few comments below.

Thanks for cleaning up the LTP ;-)

I also think it would be a good idea to do a step-by-step tutorial on
writing a simple test case. Then do another one which extends it to fork
a child.

The current guidelines are quite abstract, which is nice as a reference,
but I think most people learn quicker with examples as well and maybe it
would reduce the amount of review time.

>> +
>> +To run a particular test suite
>> +
>> +$ ./runltp -f syscalls
>> +
>> +To run all tests with 'madvise' in the name
>> +
>> +$ ./runltp -f syscalls -s madvise
>> +
>> +Also see
>> +
>> +$ ./runltp --help
>> +
>> +Test suites (e.g. syscalls) are defined in the runtest directory. Each file
>> +contains a list of test cases in a simple format, see doc/ltp-run-files.txt.
>> +
>> +Each test case has its own executable or script, these can be executed
>> +directly
>> +
>> +$ testcases/bin/abort01
>> +
>> +Some have arguments
>> +
>> +$ testcases/bin/fork13 -i 37
>
> Quite a lot of the C tests and all shell tests needs at least
> /opt/ltp/testcases/bin in the $PATH in order to source scripts and/or
> execute helper binaries. Some tests needs LTPROOT (in order to locate
> datafiles) as well.
>
> So safest example here is:
>
> LTPROOT=/opt/ltp/ PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/test_name
>
> Also 99% of the test has help that is printed when -h is passed in
> arguments.

As it happens though abort01 and fork13 don't require anything. So I
propose making it a bit longer by adding this:

"The vast majority of test cases accept the -h (help) switch

$ testcases/bin/ioctl01 -h

Many require certain environment variables to be set

$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh

Most commonly the path variable needs to be set and also LTPROOT, but there are a number
of other variables. runltp usually sets these for you.

Note that, in the example above, a shell script is given and indeed all
shell scripts need the PATH to be set. However this is not limited to shell
scripts, many C based tests need these variables as well."

--
Thank you,
Richard.
