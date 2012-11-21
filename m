Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TbBqU-0006CT-QD
	for ltp-list@lists.sourceforge.net; Wed, 21 Nov 2012 15:04:10 +0000
Date: Wed, 21 Nov 2012 16:01:22 +0100
From: chrubis@suse.cz
Message-ID: <20121121150122.GA5195@rei.suse.cz>
References: <1352859913-4789-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1352859913-4789-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] runltp: make -s option can run all of the test
	case
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> Currently, -s option only can run the test case in alltests by
> the PATTERN, but I think it's worth to be able to run all of
> the test cases under runtest/ by the PATTERN.
> For example, we can run test case like "cpuhotplug01" using
> 	./runltp -s cpuhotplug01
> with this patch.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  runltp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/runltp b/runltp
> index 04cc690..7d54f0d 100755
> --- a/runltp
> +++ b/runltp
> @@ -651,7 +651,7 @@ main()
>      if [ -n "$TAG_RESTRICT_STRING" ]
>      then
>          mv -f ${TMP}/alltests ${TMP}/alltests.orig
> -	    grep $TAG_RESTRICT_STRING ${TMP}/alltests.orig > ${TMP}/alltests #Not worth checking return codes for this case
> +	grep $TAG_RESTRICT_STRING ${LTPROOT}/runtest/* | awk -F':' '{print $2}' | sort -u > ${TMP}/alltests #Not worth checking return codes for this case
>      fi
>  
>      # Blacklist or skip tests if a SKIPFILE was specified with -S

The runltp script is one of the places I'm still not familiar with, but
I'm rather woried of the 'sort -u'. This would change the order and
count of LTP cases executed and that is something that should be
discussed first.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
