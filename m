Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VqNoq-00051M-6g
	for ltp-list@lists.sourceforge.net; Tue, 10 Dec 2013 13:57:48 +0000
Date: Tue, 10 Dec 2013 14:57:10 +0100
From: chrubis@suse.cz
Message-ID: <20131210135709.GB25334@rei>
References: <1385534272-32414-1-git-send-email-vincent.hsu@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385534272-32414-1-git-send-email-vincent.hsu@linaro.org>
Subject: Re: [LTP] [LNG][PATCH V2 0/2] fixing over 80 chars
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
To: Vincent Hsu <vincent.hsu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, linaro-networking@linaro.org

Hi!
> I've fixed the over 80 characters lines that my patches adds,
> but there are other lines over 80 chars in the same file.
> eg.
>     checkpatch.pl -f testcases/network/iproute/ip_tests.sh
>     ....
>     WARNING: line over 80 characters
>     #575: FILE: network/iproute/ip_tests.sh:575:
>     +                       ip maddr show | grep "66:66:00:00:00:66" &>$LTPTMP/tst_ip.err \
>     total: 0 errors, 22 warnings, 611 lines checked
> 
> BTW, some test files combine spaces and tabs for indentation, and also have
> over 80 chars lines.
> eg.
>     testcases/network/multicast/*
>     testcases/network/nfs/*
> 
> Maybe you could clean up them when you have time :)

There is a lot of legacy and messed up code and we are fixing it as fast
as we can...

But in order to get somewhere newly added code should be clean,
otherwise we will never get to a clean codebase.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
