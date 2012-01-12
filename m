Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shanevolpe@gmail.com>) id 1RlOQu-0002QT-Kk
	for ltp-list@lists.sourceforge.net; Thu, 12 Jan 2012 17:27:24 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RlOQq-0003Zj-UV
	for ltp-list@lists.sourceforge.net; Thu, 12 Jan 2012 17:27:24 +0000
Received: by ggno1 with SMTP id o1so1385409ggn.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 12 Jan 2012 09:27:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANoG8sVidgJ-=eRjbk7L-NSajQzMqQr24wFAYSW3FU8ChzL4ow@mail.gmail.com>
References: <CANoG8sVidgJ-=eRjbk7L-NSajQzMqQr24wFAYSW3FU8ChzL4ow@mail.gmail.com>
From: Shane Volpe <shanevolpe@gmail.com>
Date: Thu, 12 Jan 2012 12:26:54 -0500
Message-ID: <CAMgc3zMJMshA4Ahub0UyDoeOu+0PWDnEZkekgbk+Dmr6ryPR+w@mail.gmail.com>
Subject: Re: [LTP] Strange output of fork13 testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Romu <huruomu@gmail.com>
Cc: ltp-list@lists.sourceforge.net

>fork13 =A0 =A0 =A01 =A0TBROK =A0: =A0unexpected signal 15 received (pid =
=3D 2046).
>fork13 =A0 =A0 =A02 =A0TBROK =A0: =A0Remaining cases broken
>INFO: ltp-pan reported all tests PASS
>LTP Version: LTP-20110915

I'm also seeing the same thing when running fork13. It seems to be
something related to the default LTP sighandler as if you run the test
outside of LTP it just passes.
Regards,
Shane

---------------------------------------------------------------------------=
---
RSA(R) Conference 2012
Mar 27 - Feb 2
Save $400 by Jan. 27
Register now!
http://p.sf.net/sfu/rsa-sfdev2dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
