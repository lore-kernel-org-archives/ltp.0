Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1ROutI-0006we-DL
	for ltp-list@lists.sourceforge.net; Fri, 11 Nov 2011 17:27:48 +0000
Date: Fri, 11 Nov 2011 18:34:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111111173400.GA16674@saboteur.suse.cz>
References: <CANoG8sWFVaVLUkQFnT2bmbTD1HvTemWJkUmhB23K4Pb9kcrfGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANoG8sWFVaVLUkQFnT2bmbTD1HvTemWJkUmhB23K4Pb9kcrfGQ@mail.gmail.com>
Subject: Re: [LTP] Strange behavior of inotify02
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
To: Romu <huruomu@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> On my system a kernel-header package of say 2.6.32-ver1 is installed,
> two versions of kernel package are installed, say:
> 
> 2.6.32-ver2 (different from the version of kernel-header)
> 2.6.39
> 
> If I configure and build ltp when system is running 2.6.32-ver2
> kernel, reboot to 2.6.39 kernel and run inotify02, it passes on nfs
> (both v3 and v4) file system.
> 
> If I configure and build ltp when system is running 2.6.39 kernel, and
> run inotify02 on 2.6.39 kernel, it fails on nfs (both v3 and v4) file
> system.
> 
> Any idea?

I would start with diffing kernel headers for both of the kernels just
to be sure nothing has changed there.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
