Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1T4OCJ-0003AL-8Y
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 03:35:07 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T4OCE-00007K-BF
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 03:35:07 +0000
Received: by pbcwy7 with SMTP id wy7so488487pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 22 Aug 2012 20:34:56 -0700 (PDT)
Message-ID: <5035A4CF.6000200@casparzhang.com>
Date: Thu, 23 Aug 2012 11:34:39 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <c91b5e097298ae2ec6e68647ade56a32ecec6ff1.1343723571.git.jstancek@redhat.com>
In-Reply-To: <c91b5e097298ae2ec6e68647ade56a32ecec6ff1.1343723571.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] proc01: add option to limit max read bytes
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
To: ltp-list@lists.sourceforge.net

On 07/31/2012 04:33 PM, Jan Stancek wrote:
>
> Add option -m to set upper limit of read megabytes from
> single proc file. When this limit is reached testcase
> will continue with next file.
>
> Reason for this new option is to allow running this testcase
> as sanity test, that doesn't need go through full content of
> files such as "pagemap" (which can take hours).
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

> ---
>   testcases/kernel/fs/proc/proc01.c |   22 ++++++++++++++++++----
>   1 files changed, 18 insertions(+), 4 deletions(-)

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
