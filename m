Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vinson@twitter.com>) id 1Ruvo0-00042e-9L
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 00:54:40 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ruvnz-0005Co-Km
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 00:54:40 +0000
Received: by wgbdr12 with SMTP id dr12so20549wgb.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Feb 2012 16:54:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKixpbivQ0wDWw4MXJjkcZwhfiT5UG44gqBQk7EBJNbw25Q=GQ@mail.gmail.com>
References: <CAKixpbg+XNuaaojb91dnOCXjCeSObRY33obhKSQd94qsp0eE-A@mail.gmail.com>
	<CAKixpbivQ0wDWw4MXJjkcZwhfiT5UG44gqBQk7EBJNbw25Q=GQ@mail.gmail.com>
Date: Tue, 7 Feb 2012 16:27:08 -0800
Message-ID: <CAKixpbgaRepTEBE-9jZ4cEjt0EC7GP3EzLKb3n7Lo_q3KKAaGQ@mail.gmail.com>
From: Vinson Lee <vlee@twitter.com>
Subject: [LTP] Proper way to build from LTP tarball
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
Cc: David Mackey <tdmackey@twitter.com>

Hello.

I am using LTP through the Autotest framework. Autotest unpackages a
LTP tarball, calls 'make autotools', 'configure', and then 'make'. On
newer distros with more recent versions of autoconf, the 'make
autotools' step fails. However, the build works if I completely skip
the 'make autotools' step.

What is the expected way to build a released LTP tarball? Is a user
expected to call 'make autotools' before 'configure' or is just
running 'configure' enough?

Cheers,
Vinson

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
