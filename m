Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PUxIq-00077m-AG
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 08:10:36 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUxIp-0007T5-FV
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 08:10:36 +0000
Received: by iyj18 with SMTP id 18so2963259iyj.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Dec 2010 00:10:30 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4D105B76.4030805@cn.fujitsu.com>
Date: Tue, 21 Dec 2010 00:10:26 -0800
Message-Id: <53132B58-CF0E-4EBB-90D8-9824A533571E@gmail.com>
References: <4D105B76.4030805@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH]Fix the bug of generate-makefiles.sh
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Dec 20, 2010, at 11:47 PM, Bian Naimeng wrote:

> At the latest open_posix_testsuites, buildonly targets will be tested
> when run "make test", so it will report many failure.
> 
> ---------------
> We just need install these targets which is a test.
> 
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
> 
> ---
> .../scripts/generate-makefiles.sh                  |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> index ed6406f..8bf70c1 100755
> --- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> +++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> @@ -121,7 +121,7 @@ EOF
> 	fi
> 
> 	cat >> "$makefile.2" <<EOF
> -INSTALL_TARGETS+=	${prereq_cache}
> +INSTALL_TARGETS+=	${tests}
> MAKE_TARGETS+=		${make_target_prereq_cache}

Committed.
Thanks!
-Garrett
------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
