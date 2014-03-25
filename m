Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WSSdd-0003P9-0B
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:47:37 +0000
Date: Tue, 25 Mar 2014 15:47:11 +0100
From: chrubis@suse.cz
Message-ID: <20140325144710.GA10096@rei>
References: <1394755221-5354-1-git-send-email-vlee@freedesktop.org>
	<20140317144318.GA1807@rei>
	<CACKvgLGan6cLbnkoQm4ueqxtTKTxhdW4tH34A46ph6BEyjOZkA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACKvgLGan6cLbnkoQm4ueqxtTKTxhdW4tH34A46ph6BEyjOZkA@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Use absolute path for losetup.
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
To: Vinson Lee <vlee@freedesktop.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> From: Vinson Lee <vlee@twitter.com>
> >>
> >> /sbin may not be in the default $PATH.
> >
> > You are supposed to start runltp as a root, if losetup is not in your
> > $PATH something went wrong on your end.
> >
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
> 
> This situation can arise, for example, on CentOS 5 running LTP with
> sudo instead of directly as root.

That is a "security" feature for sudo. See for example bug:

https://bugzilla.redhat.com/show_bug.cgi?id=80215

You can either add /sbin/ and /bin/ to your PATH manually
(PATH="$PATH:/sbin:/bin" sudo runltp) or add secure_path="/sbin:/bin:"
into /etc/sudoers.

Using absolute paths in LTP is out of question because that would bring
more harm than good. Note that distributions differ on placements for
some of the standard tools and adding a layer for resolving the paths
would add quite a bit complexity for a problem that could be solved by
adding a few paths to the PATH.

On the other hand we should fix the scripts to check if the tool they
use is available (see tst_check_cmds in testcases/lib/test.sh). And
maybe we can print a warning from runltp if /sbin or /bin are not in
$PATH.

-- 
Cyril Hrubis
chrubis@suse.cz

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
