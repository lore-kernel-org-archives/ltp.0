Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WwW2O-0000K8-KV
	for ltp-list@lists.sourceforge.net; Mon, 16 Jun 2014 12:29:24 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WwW2M-0007cC-T6
	for ltp-list@lists.sourceforge.net; Mon, 16 Jun 2014 12:29:24 +0000
Message-ID: <539EE30D.3070003@oracle.com>
Date: Mon, 16 Jun 2014 16:29:01 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1395930175-3138-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1395930175-3138-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<3170652.sUSmuoD47v@vapier>
In-Reply-To: <3170652.sUSmuoD47v@vapier>
Subject: Re: [LTP] [PATCH V3 1/4] testscripts/isofs.sh: cleanup
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
To: Mike Frysinger <vapier@gentoo.org>, ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Hi!

On 06/16/2014 10:22 AM, Mike Frysinger wrote:
> On Thu 27 Mar 2014 18:22:52 Stanislav Kholmanskikh wrote:
>> +MNT_POINT="/tmp/isofs_$$"
>> +COPY_DIR="/etc/"
>> +TEMP_DIR="/tmp/for_isofs_test"
>> +MAKE_FILE_SYS_DIR=$TEMP_DIR$COPY_DIR
>
> not really a new issue, but scripts really should never hardcode paths in
> /tmp/ or to that dir at all.  this is what `mktemp -d` is for.
>
>> +if [ "$NO_CLEANUP" == "no" ]; then
>
> it is "=" in POSIX, not "=="
> -mike
>

Thank you for review.

But both issues are fixed in the next patch in the sequence - "[PATCH V3 
2/4] testscripts/isofs.sh: use the new shell interface".



------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
