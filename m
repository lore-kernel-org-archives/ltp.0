Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TgcFC-0000dG-5R
	for ltp-list@lists.sourceforge.net; Thu, 06 Dec 2012 14:16:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TgcF9-0006pg-Ip
	for ltp-list@lists.sourceforge.net; Thu, 06 Dec 2012 14:16:06 +0000
Message-ID: <50C0A844.2020004@cn.fujitsu.com>
Date: Thu, 06 Dec 2012 22:14:28 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <50C08A4C.1090402@redhat.com>
In-Reply-To: <50C08A4C.1090402@redhat.com>
Subject: Re: [LTP] open posix testsuite and names of testcases
Reply-To: gaowanlong@cn.fujitsu.com
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

On 12/06/2012 08:06 PM, Jan Stancek wrote:
> Hi,
> 
> this testsuite has many testcases, where binary name is in format: [number]-[number].run-test
> This is not very helpful when trying to find out, which one actually
> crashed or which one is responsible for kernel oops/hung tasks.
> For example if I get in dmesg:
> [  702.018706] 1-5.run-test[10140]: segfault at 7f84e724bed8 ip 0000000000402208 sp 00007f84e724bed0 error 6 in 1-5.run-test[400000+4000]
> it's not clear, which testcase is responsible.

I met the same problem before because running the open_posix on recent RHEL6.4alpha and beta
will cause kernel panic...

Thanks,
Wanlong Gao

> 
> Does anyone have some ideas?
> 
> I had these two:
> 1. rename all testcases - lot of work, they are also referenced in some .sh scripts
> 2. modify run-tests.sh to copy it under more verbose name and run that one
> 
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
> 
> Regards,
> Jan
> 
> ------------------------------------------------------------------------------
> LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
> Remotely access PCs and mobile devices and provide instant support
> Improve your efficiency, and focus on delivering more value-add services
> Discover what IT Professionals Know. Rescue delivers
> http://p.sf.net/sfu/logmein_12329d2d
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


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
