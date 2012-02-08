Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Ruwph-0007hn-40
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 02:00:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ruwpf-0006sz-EU
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 02:00:29 +0000
Message-ID: <4F31D02F.8060200@cn.fujitsu.com>
Date: Wed, 08 Feb 2012 09:30:23 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <CAKixpbg+XNuaaojb91dnOCXjCeSObRY33obhKSQd94qsp0eE-A@mail.gmail.com>
	<CAKixpbivQ0wDWw4MXJjkcZwhfiT5UG44gqBQk7EBJNbw25Q=GQ@mail.gmail.com>
	<CAKixpbgaRepTEBE-9jZ4cEjt0EC7GP3EzLKb3n7Lo_q3KKAaGQ@mail.gmail.com>
In-Reply-To: <CAKixpbgaRepTEBE-9jZ4cEjt0EC7GP3EzLKb3n7Lo_q3KKAaGQ@mail.gmail.com>
Subject: Re: [LTP] Proper way to build from LTP tarball
Reply-To: gaowanlong@cn.fujitsu.com
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
Cc: ltp-list@lists.sourceforge.net, David Mackey <tdmackey@twitter.com>

On 02/08/2012 08:27 AM, Vinson Lee wrote:

> Hello.
> 
> I am using LTP through the Autotest framework. Autotest unpackages a
> LTP tarball, calls 'make autotools', 'configure', and then 'make'. On
> newer distros with more recent versions of autoconf, the 'make
> autotools' step fails. However, the build works if I completely skip
> the 'make autotools' step.
> 
> What is the expected way to build a released LTP tarball? Is a user
> expected to call 'make autotools' before 'configure' or is just
> running 'configure' enough?


The "INSTALL" file says that :
Quick Start
-----------

1> tar xzf ltp-XXXXXXXX.tar.gz
2> cd ltp 
3> ./configure
4> make all 
5> make install
6> /opt/ltp/runltp

when quick start, you can just use the configure,
if you need more configuration, user autoconf ;)

Thanks
-Wanlong Ga

> 
> Cheers,
> Vinson
> 
> ------------------------------------------------------------------------------
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-d2d
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



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
