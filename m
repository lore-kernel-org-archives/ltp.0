Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WQwwS-0001wy-CT
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 10:44:48 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WQwwR-00086e-C9
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 10:44:48 +0000
Message-ID: <532C1813.9060609@oracle.com>
Date: Fri, 21 Mar 2014 14:44:35 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>	<1394714306-9678-3-git-send-email-stanislav.kholmanskikh@oracle.com>	<12581797.Xz9gpSyGDL@vapier>
	<532706B4.4060500@oracle.com>
In-Reply-To: <532706B4.4060500@oracle.com>
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



On 03/17/2014 06:29 PM, Stanislav Kholmanskikh wrote:
> Hi!
>
> On 14.03.2014 00:56, Mike Frysinger wrote:
>> On Thu 13 Mar 2014 16:38:25 Stanislav Kholmanskikh wrote:
>>>    		echo "Running ls -lR $MNT_POINT Command"
>>> -		ls -lR $MNT_POINT
>>> +		ls -lR $MNT_POINT > /dev/null
>>
>> the point of this command is to show the contents of the mount.  if you're not
>> doing that, then delete the call (and the echo above it).
>
> Ok. I'll delete this call.
>
>
>> -mike
>>

I think we were incorrect about it.

The implicit point of the above commands is to give the OS (kernel/udev) 
some time to complete all actions needed to handle a new loop device 
creation situation.

For example, consider this script:

#!/bin/sh

for mount_opt in \
         "loop" \
         "loop,norock" \
         "loop,nojoliet" \
         "loop,block=512,unhide" \
         "loop,block=2048,nocompress" \
         "loop,check=strict,map=off,gid=bin,uid=bin" \
         "loop,check=strict,map=acorn,gid=bin,uid=bin" \
         "loop,check=relaxed,map=normal" \
         "loop,block=512,unhide,session=2"
do
         echo "mount_opt = $mount_opt"
         losetup -a
         mount -t iso9660 -o $mount_opt /tmp/isofs.iso /tmp/mnt
#        ls -lR /tmp/mnt > /dev/null
         umount /tmp/mnt

done

sleep 2
echo "after sleep"
losetup -a

If we execute it, we may get:
mount_opt = loop
mount_opt = loop,norock
/dev/loop0: [fc00]:131091 (/tmp/isofs.iso)
mount_opt = loop,nojoliet
/dev/loop0: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop1: [fc00]:131091 (/tmp/isofs.iso)
mount_opt = loop,block=512,unhide
/dev/loop0: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop1: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop2: [fc00]:131091 (/tmp/isofs.iso)
mount_opt = loop,block=2048,nocompress
/dev/loop1: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop2: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop3: [fc00]:131091 (/tmp/isofs.iso)
mount_opt = loop,check=strict,map=off,gid=bin,uid=bin
/dev/loop0: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop2: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop3: [fc00]:131091 (/tmp/isofs.iso)
mount_opt = loop,check=strict,map=acorn,gid=bin,uid=bin
/dev/loop0: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop1: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop3: [fc00]:131091 (/tmp/isofs.iso)
mount_opt = loop,check=relaxed,map=normal
/dev/loop0: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop1: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop2: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop3: [fc00]:131091 (/tmp/isofs.iso)
mount_opt = loop,block=512,unhide,session=2
/dev/loop2: [fc00]:131091 (/tmp/isofs.iso)
/dev/loop4: [fc00]:131091 (/tmp/isofs.iso)
after sleep

And if we uncomment 'ls -lR > /dev/null', we will get a clean output:
mount_opt = loop
mount_opt = loop,norock
mount_opt = loop,nojoliet
mount_opt = loop,block=512,unhide
mount_opt = loop,block=2048,nocompress
mount_opt = loop,check=strict,map=off,gid=bin,uid=bin
mount_opt = loop,check=strict,map=acorn,gid=bin,uid=bin
mount_opt = loop,check=relaxed,map=normal
mount_opt = loop,block=512,unhide,session=2
after sleep

So the more test cases we have the higher the probability is that sooner 
or later the OS will have no available loop devices.

The above commands were executed on a kernel with 
a1ecac3b0656a68259927c234e505804d33a7b83 patch.

I think that according to the patch the described behaviour is 
absolutely expected. Therefore It would be better to leave "ls -lR" in 
the test or insert a 'sleep' instead. In this case we would use no more 
than 2 loop devices per iteration.

Guys, what do you think?

PS: On a kernel without this patch it's very likely that an umount 
operation will fail with:
loop: can't delete device /dev/loop0: Device or resource busy


>
> ------------------------------------------------------------------------------
> Learn Graph Databases - Download FREE O'Reilly Book
> "Graph Databases" is the definitive new guide to graph databases and their
> applications. Written by three acclaimed leaders in the field,
> this first edition is now available. Download your free book today!
> http://p.sf.net/sfu/13534_NeoTech
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
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
