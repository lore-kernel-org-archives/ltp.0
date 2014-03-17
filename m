Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WPYhi-00004z-Oq
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 14:39:50 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WPYhi-00037F-3o
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 14:39:50 +0000
Message-ID: <53270928.2020603@oracle.com>
Date: Mon, 17 Mar 2014 18:39:36 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1394714306-9678-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<2396644.2WVkagNouJ@vapier>
In-Reply-To: <2396644.2WVkagNouJ@vapier>
Subject: Re: [LTP] [PATCH 1/3] isofs.sh: use $TMPDIR for temporary directory
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



On 14.03.2014 00:55, Mike Frysinger wrote:
> On Thu 13 Mar 2014 16:38:24 Stanislav Kholmanskikh wrote:
>>   #Initialize directory variables
>> -    MNT_POINT="/tmp/isofs_$$"
>> +    TMPDIR=${TMPDIR:-/tmp}
>> +    MNT_POINT="$TMPDIR/isofs_$$"
>
> why not just use `mktemp -d` ?

ok.

> -mike
>

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
