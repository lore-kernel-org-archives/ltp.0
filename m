Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VlNNZ-00012U-Tk
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 18:28:57 +0000
Date: Tue, 26 Nov 2013 19:28:27 +0100
From: chrubis@suse.cz
Message-ID: <20131126182827.GA15092@rei.suse.cz>
References: <1385362041-17578-1-git-send-email-jshao@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385362041-17578-1-git-send-email-jshao@redhat.com>
Subject: Re: [LTP] [PATCH] netns: remove accumulated errmesg assignment
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
To: Monson Shao <jshao@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Valuable $errmesg wasn't initialized at beginning, when bash option
> "nounset" is set, statement like errmesg="$errmesg XXXXXX" will cause
> bash unbound variable error.
> 
> Furthermore, $errmesg will be echoed every time it is assigned, so
> there is no need for accumulated assignment.
> 
> Signed-off-by: Monson Shao <jshao@redhat.com>
> ---
>  testcases/kernel/containers/netns/runnetnstest.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/containers/netns/runnetnstest.sh b/testcases/kernel/containers/netns/runnetnstest.sh
> index fb494a2..f7bf80f 100755
> --- a/testcases/kernel/containers/netns/runnetnstest.sh
> +++ b/testcases/kernel/containers/netns/runnetnstest.sh
> @@ -60,7 +60,7 @@ two_children_ns
>  rc=$?
>  if [ $rc -ne 0 ]; then
>      exit_code=$rc
> -    errmesg="$errmesg two_children_ns: return code is $exit_code ; "
> +    errmesg="two_children_ns: return code is $exit_code ; "
>      echo $errmesg
>  else
>     echo "two_children_ns: PASS"
> @@ -71,7 +71,7 @@ crtchild_delchild
>  rc=$?
>  if [ $rc -ne 0 ]; then
>      exit_code=$rc
> -    errmesg="$errmesg crtchild_delchild: return code is $exit_code ; "
> +    errmesg="crtchild_delchild: return code is $exit_code ; "
>      echo $errmesg
>  else
>     echo "crtchild_delchild: PASS"
> @@ -83,7 +83,7 @@ par_chld_ipv6
>  rc=$?
>  if [ $rc -ne 0 ]; then
>      exit_code=$rc
> -    errmesg="$errmesg par_chld_ipv6: return code is $exit_code ; "
> +    errmesg="par_chld_ipv6: return code is $exit_code ; "
>      echo $errmesg
>  else
>     echo "par_chld_ipv6: PASS"
> @@ -99,7 +99,7 @@ echo
>  #rc=$?
>  #if [ $rc -ne 0 ]; then
>  #    exit_code=$rc
> -#    errmesg="$errmesg sysfsview: return code is $exit_code ; "
> +#    errmesg="sysfsview: return code is $exit_code ; "
>  #    echo $errmesg
>  #else
>  #   echo "sysfsview: PASS"
> @@ -119,7 +119,7 @@ par_chld_ftp
>  rc=$?
>  if [ $rc -ne 0 ]; then
>      exit_code=$rc
> -    errmesg="$errmesg par_chld_ftp: FAIL $exit_code ; "
> +    errmesg="par_chld_ftp: FAIL $exit_code ; "
>      echo $errmesg
>  else
>     echo "par_chld_ftp: PASS"

I wonder why there is errmesg variable at all and not just echo, it
doesn't seems to be used anywhere else.

Moreover the way the testcases are executed is not well designed, the
runtest file 'containers' executes script container_test.sh which
executes several scripts and the scripts finally executes the tescases.
This is really nightmare if you are trying to find what fails and why...

It would be much better to execute the testcases directly one by one
from the runtest file, and in most of the cases that would just need to
move code the checks if there is support for particual container to the
testcases.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
