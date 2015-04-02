Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YdaZZ-0003AX-3T
	for ltp-list@lists.sourceforge.net; Thu, 02 Apr 2015 08:33:57 +0000
Date: Thu, 2 Apr 2015 10:33:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150402083344.GA27984@rei>
References: <1427771764-22918-1-git-send-email-cuibixuan@huawei.com>
	<20150401143314.GA23093@rei> <551CB5CD.5030903@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <551CB5CD.5030903@huawei.com>
Subject: Re: [LTP] [PATCH v2] syscalls/utimensat01: "chattr" command error
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
To: cuibixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> @@ -24,6 +24,7 @@
>  export TCID=utimensat01
>  export TST_TOTAL=99
>  export TST_COUNT=0
> +. test.sh

If you start using test.sh in the testcase, you have to fix the rest of
the tst_resm() followed by exit as well (just change these to tst_brkm
and remove the exit). And also change the exit -1 at the end of the test
to tst_resm TFAIL and call tst_exit at the very end of the test.

Have a look at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell

And these fixes should ideally be done in a separate patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
