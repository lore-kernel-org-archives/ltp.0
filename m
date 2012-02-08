Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rv6pg-000248-Lf
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 12:41:08 +0000
Date: Wed, 8 Feb 2012 13:54:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120208125457.GA23425@saboteur.suse.cz>
References: <CAKixpbg+XNuaaojb91dnOCXjCeSObRY33obhKSQd94qsp0eE-A@mail.gmail.com>
	<CAKixpbivQ0wDWw4MXJjkcZwhfiT5UG44gqBQk7EBJNbw25Q=GQ@mail.gmail.com>
	<CAKixpbgaRepTEBE-9jZ4cEjt0EC7GP3EzLKb3n7Lo_q3KKAaGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKixpbgaRepTEBE-9jZ4cEjt0EC7GP3EzLKb3n7Lo_q3KKAaGQ@mail.gmail.com>
Subject: Re: [LTP] Proper way to build from LTP tarball
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
To: Vinson Lee <vlee@twitter.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I am using LTP through the Autotest framework. Autotest unpackages a
> LTP tarball, calls 'make autotools', 'configure', and then 'make'. On
> newer distros with more recent versions of autoconf, the 'make
> autotools' step fails. However, the build works if I completely skip
> the 'make autotools' step.

On which distros/autconf version do the 'make autotools' fails?

> What is the expected way to build a released LTP tarball? Is a user
> expected to call 'make autotools' before 'configure' or is just
> running 'configure' enough?

Running configure from relased tarball should be enough, calling
autoconf to (re)generate configure script should be needed only when you
change some of the autoconf/automake m4 files. 

-- 
Cyril Hrubis
chrubis@suse.cz

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
