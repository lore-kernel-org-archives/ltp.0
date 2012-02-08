Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rv8nS-0001tq-GX
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 14:46:58 +0000
Date: Wed, 8 Feb 2012 16:00:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120208150049.GF17568@saboteur.suse.cz>
References: <4F2BA78D.5090301@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F2BA78D.5090301@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] runfstests.sh: fix error exit code
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> The exit code of runfstests.sh should be not 0 when aio02 test fail.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  testcases/kernel/io/aio/aio02/runfstests.sh |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/io/aio/aio02/runfstests.sh b/testcases/kernel/io/aio/aio02/runfstests.sh
> index 07a40ad..005299a 100755
> --- a/testcases/kernel/io/aio/aio02/runfstests.sh
> +++ b/testcases/kernel/io/aio/aio02/runfstests.sh
> @@ -56,3 +56,5 @@ echo "Pass: $passes Fail: $fails"
>  echo "Test run complete at" `date`
>  
>  rm -rf testdir
> +
> +exit $fails

Good catch, however the only thing that the script does is creating
temporary directory, which could be easily done withing the test itself
by using tst_tmpdir(), then we could drop this script and run the
testcase directly...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
