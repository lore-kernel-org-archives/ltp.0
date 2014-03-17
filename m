Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WPYXh-0007Ah-Rc
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 14:29:29 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WPYXg-0006Ti-2G
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 14:29:29 +0000
Message-ID: <532706B4.4060500@oracle.com>
Date: Mon, 17 Mar 2014 18:29:08 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1394714306-9678-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<12581797.Xz9gpSyGDL@vapier>
In-Reply-To: <12581797.Xz9gpSyGDL@vapier>
Subject: Re: [LTP] [PATCH 2/3] isofs.sh: be more quiet
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

On 14.03.2014 00:56, Mike Frysinger wrote:
> On Thu 13 Mar 2014 16:38:25 Stanislav Kholmanskikh wrote:
>>   		echo "Running ls -lR $MNT_POINT Command"
>> -		ls -lR $MNT_POINT
>> +		ls -lR $MNT_POINT > /dev/null
>
> the point of this command is to show the contents of the mount.  if you're not
> doing that, then delete the call (and the echo above it).

Ok. I'll delete this call.


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
