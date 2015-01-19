Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YDDKM-0000o1-DR
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 14:29:14 +0000
Date: Mon, 19 Jan 2015 15:28:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150119142817.GA28964@rei>
References: <1420810343-64049-1-git-send-email-maxin.john@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1420810343-64049-1-git-send-email-maxin.john@gmail.com>
Subject: Re: [LTP] [PATCH v2] run-posix-option-group-test: remove set -x
	debug
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
To: maxin.john@gmail.com
Cc: ltp-list@lists.sourceforge.net, "Maxin B. John" <maxin.john@enea.com>

Hi!
> --- a/testcases/open_posix_testsuite/bin/run-tests.sh
> +++ b/testcases/open_posix_testsuite/bin/run-tests.sh
> @@ -29,7 +29,7 @@ run_test_loop() {
>  
>  	cat <<EOF
>  *******************
> -SUMMARY
> +Testing $*

I've changed the $* to $(basename $CWD), which provides less detailed
info and pushed. Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
