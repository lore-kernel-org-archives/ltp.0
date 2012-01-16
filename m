Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1RmctQ-0007Cn-Gm
	for ltp-list@lists.sourceforge.net; Mon, 16 Jan 2012 03:05:56 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RmctP-0005os-Fq
	for ltp-list@lists.sourceforge.net; Mon, 16 Jan 2012 03:05:56 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q0G35nM8026656
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Sun, 15 Jan 2012 19:05:49 -0800 (PST)
Message-ID: <4F13940B.8050209@windriver.com>
Date: Mon, 16 Jan 2012 11:05:47 +0800
From: Jin Li <Jin.Li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] A question about mktemp in script runltp
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

Hi

In runltp script, mktemp is used to create a temp directory. see below :

mnt_pnt=`mktemp -d --tmpdir=${TMP} mnt_pnt.XXXXXX`

But I have a little confused about the argument "--tmpdir"

I prefer to use "-p ${TMP}" to replace "--tmpdir=${TMP}"

Maybe I missed something :)

Regards,

Jin

------------------------------------------------------------------------------
RSA(R) Conference 2012
Mar 27 - Feb 2
Save $400 by Jan. 27
Register now!
http://p.sf.net/sfu/rsa-sfdev2dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
