Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1QUWje-0001MP-Cg
	for ltp-list@lists.sourceforge.net; Thu, 09 Jun 2011 04:20:46 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QUWjd-0003xb-FC
	for ltp-list@lists.sourceforge.net; Thu, 09 Jun 2011 04:20:46 +0000
Received: by pvc30 with SMTP id 30so753448pvc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jun 2011 21:20:39 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1084)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1307591784-1735-1-git-send-email-ratbert.chuang@gmail.com>
Date: Wed, 8 Jun 2011 21:20:40 -0700
Message-Id: <9507E9B4-F82A-4118-B4A4-D1D1DC466780@gmail.com>
References: <1307591784-1735-1-git-send-email-ratbert.chuang@gmail.com>
Subject: Re: [LTP] [PATCH] gzip_tests.sh: fix error message typo
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
To: Po-Yu Chuang <ratbert.chuang@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Po-Yu Chuang <ratbert@faraday-tech.com>

On Jun 8, 2011, at 8:56 PM, Po-Yu Chuang wrote:

> From: Po-Yu Chuang <ratbert@faraday-tech.com>
> 
> 
> Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
> ---
> testcases/commands/gzip/gzip_tests.sh |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/commands/gzip/gzip_tests.sh b/testcases/commands/gzip/gzip_tests.sh
> index 99cafa4..5dba859 100755
> --- a/testcases/commands/gzip/gzip_tests.sh
> +++ b/testcases/commands/gzip/gzip_tests.sh
> @@ -265,7 +265,7 @@ test02()
>     if [ $RC -ne 0 ]
> 	then
> 		tst_brk TBROK $LTPTMP/tst_gzip.err NULL \
> -		"Test #2: uncompressing directory $LTPTMP/tst_gzip.tmp failed.  Reason"
> +		"Test #2: compressing directory $LTPTMP/tst_gzip.tmp failed.  Reason"
> 		return $RC

Committed -- thanks :).
-Garrett


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
