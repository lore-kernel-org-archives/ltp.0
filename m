Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huruomu@gmail.com>) id 1ROXuC-0005AK-WA
	for ltp-list@lists.sourceforge.net; Thu, 10 Nov 2011 16:55:12 +0000
Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1ROXuC-0002pC-DI
	for ltp-list@lists.sourceforge.net; Thu, 10 Nov 2011 16:55:12 +0000
Received: by vwe42 with SMTP id 42so3436204vwe.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 10 Nov 2011 08:55:07 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 11 Nov 2011 00:55:06 +0800
Message-ID: <CANoG8sX-GKK2dbxiHAocviCue8Y7rU1O10=wzbNmZhrMZZQhbA@mail.gmail.com>
From: Romu <huruomu@gmail.com>
Subject: [LTP] Incorrect mode on nfsv3 filesystem
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

Hi,

The following tests fail on nfs (nfsvers=3) filesystem:

chmod03     1  TFAIL  :  testfile: Incorrect modes 0100777, Expected 0777
fchmod03    1  TFAIL  :  testfile: Incorrect modes 0100777, Expected 0777
chown02     1  TFAIL  :  testfile1: incorrect mode permissions
0106770, Expected 0100770

I have no idea whether they are kernel issue.  Any idea?

Thanks
Romu

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
