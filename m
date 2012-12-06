Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TgcCx-0001e8-1g
	for ltp-list@lists.sourceforge.net; Thu, 06 Dec 2012 14:13:47 +0000
Date: Thu, 6 Dec 2012 15:13:36 +0100
From: chrubis@suse.cz
Message-ID: <20121206141336.GA2317@rei.nue.novell.com>
References: <50C08A4C.1090402@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50C08A4C.1090402@redhat.com>
Subject: Re: [LTP] open posix testsuite and names of testcases
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> this testsuite has many testcases, where binary name is in format: [number]-[number].run-test
> This is not very helpful when trying to find out, which one actually
> crashed or which one is responsible for kernel oops/hung tasks.
> For example if I get in dmesg:
> [  702.018706] 1-5.run-test[10140]: segfault at 7f84e724bed8 ip 0000000000402208 sp 00007f84e724bed0 error 6 in 1-5.run-test[400000+4000]
> it's not clear, which testcase is responsible.

Here in suse we use CTCS2 to run the testcases and we have a perl script
that generates the the test names accordingly to the directory structure
which doesn't help when looking into the kernel log but the segfault
is logged into the test results anyway.

And mostly because of that the current test execution framework both for
LTP and Open Posix Testsuite is a little out of my radar, although I
would like to have them fixed too.

> Does anyone have some ideas?
> 
> I had these two:
> 1. rename all testcases - lot of work, they are also referenced in some .sh scripts
> 2. modify run-tests.sh to copy it under more verbose name and run that one

Well I don't think that the option one is that hard, at least I'm not
aware of much cases of hardcoded names in the Open Posix Testsuite. On
the other hand having better test driver that executes the tests and
presents the result in more convinient way would be more appealing. Or
we can do both of them.

I was thinking of creating a relatively simply test driver that runs the
tests, takes care of timeouts (and anything else) and logs information
in some reasonable format (I used JSON in similar case). And then about
some tools that could compare the results, print list of failed
testcases and so on. Does that sound reasonable?

And on more general note we surely need to decide how to do things
there. There are some howtos in the Documentation directory none of them
are up to date.

> diff --git a/testcases/open_posix_testsuite/bin/run-tests.sh b/testcases/open_posix_testsuite/bin/run-tests.sh
> index bd8ca14..ddb6e0b 100755
> --- a/testcases/open_posix_testsuite/bin/run-tests.sh
> +++ b/testcases/open_posix_testsuite/bin/run-tests.sh
> @@ -46,8 +46,11 @@ run_test() {
>  
>  	complog=$(basename $testname).log.$$
>  
> -	sh -c "$SCRIPT_DIR/t0 $TIMEOUT_VAL ./$1 $(cat ./$(echo "$1" | sed 's,\.[^\.]*,,').args 2>/dev/null)" > $complog 2>&1
> +	# create a copy with more verbose name
> +	new_testname=$(basename $TEST_PATH)-$1
> +	cp -f ./$1 $new_testname
>  
> +	sh -c "$SCRIPT_DIR/t0 $TIMEOUT_VAL ./$new_testname $(cat ./$(echo "$1" | sed 's,\.[^\.]*,,').args 2>/dev/null)" > $complog 2>&1
>  	ret_code=$?
>  
>  	if [ "$ret_code" = "0" ]; then
> 
> Which makes logs a bit more helpful:
> [179468.329814] User process fault: interruption code 0x60011 in pthread_create-1-5.run-test[80000000+5000]

It's rather crude hack, but I guess that it's better than nothing. And
you should probably remove the file after the test has finished.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
