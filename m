Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vijaykumar@bravegnu.org>) id 1MFt5l-0001JN-1q
	for ltp-list@lists.sourceforge.net; Sun, 14 Jun 2009 17:02:01 +0000
Received: from li2-213.members.linode.com ([69.56.173.213]
	helo=mail.zilogic.com) by 3b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MFt5i-00081n-3S
	for ltp-list@lists.sourceforge.net; Sun, 14 Jun 2009 17:02:01 +0000
Received: from [192.168.1.5] (unknown [59.92.87.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.zilogic.com (Postfix) with ESMTP id F1439105B1
	for <ltp-list@lists.sourceforge.net>;
	Sun, 14 Jun 2009 12:33:36 -0400 (EDT)
Message-ID: <4A35264D.10800@bravegnu.org>
Date: Sun, 14 Jun 2009 22:03:17 +0530
From: Vijay Kumar <vijaykumar@bravegnu.org>
MIME-Version: 1.0
Subject: [LTP] [RFC] Using checkpatch.pl
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
To: LTP List <ltp-list@lists.sourceforge.net>

Hi everyone,
Michal Simek patched most of the LTP code base to use the Linux kernel
coding style. But unfortunately new patches, that are flowing in, seem
to add coding style violations. It is better to prevent new style
violations than to fix them later on.

The kernel developers use a perl script called checkpatch.pl to
identify style violations in patches. We could use the same script to
check our patches, as well. The script uses files from the kernel to
do kernel specific checks. This can be disabled by using the --no-tree
option. So to check an LTP patch

$ checkpatch.pl --no-tree ltp-patch

If everybody is OK with it we can add the script to the LTP source
tree, so that everyone checks their patches against the same
script. And Subrata can easily check for style violations before
merging the patch.

In the future, we could also customize the script to do userspace/LTP
specific checks, like missing mode argument when open() is invoked
with O_CREAT flag.

Please do send in your suggestions.

Regards,
Vijay

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
