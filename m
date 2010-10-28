Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PBIQ8-0008L9-6S
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 02:40:52 +0000
Received: from out15.sjc.mx.trendmicro.com ([216.99.131.72])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PBIQ4-0000UI-Ev
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 02:40:52 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <4CC8D7DE.9060700@cn.fujitsu.com>
In-Reply-To: <4CC8D7DE.9060700@cn.fujitsu.com>
Date: Thu, 28 Oct 2010 11:40:39 +0900
Message-ID: <000a01cb7649$81dee5f0$859cb1d0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] [PATCH] Fix all tests pass error
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
To: 'Gui Jianfeng' <guijianfeng@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Gui Jianfeng [mailto:guijianfeng@cn.fujitsu.com]
> Sent: Thursday, October 28, 2010 10:55 AM
> To: Garrett Cooper
> Cc: mitani@ryobi.co.jp; ltp-list@lists.sourceforge.net
> Subject: [PATCH] Fix all tests pass error
> 
> ret_code comes from "set +x" which always return 0, this makes all tests
> PASS.
> Actually, "set +x" isn't needed here, just get rid of it.
> 
> Signed-off-by: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
> ---
>  testcases/open_posix_testsuite/bin/run-tests.sh |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/bin/run-tests.sh
> b/testcases/open_posix_testsuite/bin/run-tests.sh
> index 6a03856..04a39dd 100755
> --- a/testcases/open_posix_testsuite/bin/run-tests.sh
> +++ b/testcases/open_posix_testsuite/bin/run-tests.sh
> @@ -48,8 +48,6 @@ run_test() {
> 
>  	sh -c "$SCRIPT_DIR/t0 $TIMEOUT_VAL ./$1 $(cat ./$(echo "$1"
> | sed 's,\.[^\.]*,,').args 2>/dev/null)" > $complog 2>&1
> 
> -	set +x
> -
>  	ret_code=$?
> 
>  	if [ "$ret_code" = "0" ]; then
> --
> 1.7.0.4


Great!

I was forestalled :)
I have the same opinion, too.


Thank you--

-Tomonori Mitani



------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
