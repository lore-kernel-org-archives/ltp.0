Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WQzjf-0002JN-7J
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 13:43:47 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WQzje-0003UB-Fw
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 13:43:47 +0000
Message-ID: <532C4201.3030605@oracle.com>
Date: Fri, 21 Mar 2014 17:43:29 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>	<1394714306-9678-3-git-send-email-stanislav.kholmanskikh@oracle.com>	<12581797.Xz9gpSyGDL@vapier>	<532706B4.4060500@oracle.com>
	<532C1813.9060609@oracle.com>
In-Reply-To: <532C1813.9060609@oracle.com>
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



On 03/21/2014 02:44 PM, Stanislav Kholmanskikh wrote:

>
> I think that according to the patch the described behaviour is
> absolutely expected. Therefore It would be better to leave "ls -lR" in
> the test or insert a 'sleep' instead. In this case we would use no more
> than 2 loop devices per iteration.
>

I suppose it would be a better solution (and without any waitings):

loop_dev=$(losetup --show -f isofs.iso)
# do mount and other stuff
# do umount
while /bin/true; do
     out=$(losetup -d "$loop_dev" 2>&1)

     if echo "$out" | grep -q -i "No such device"; then
          break
     fi
done

This way we doesn't depend on asynchrony in the loop-driver code.

> Guys, what do you think?
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
