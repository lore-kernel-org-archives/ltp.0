Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSocG-0000V8-CA
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 09:25:16 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSocF-0003nw-4X
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 09:25:16 +0000
Received: by pwj11 with SMTP id 11so12925490pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Jan 2010 01:25:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
References: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 7 Jan 2010 01:18:18 -0800
Message-ID: <364299f41001070118j2fcfec63h4edffc4e5afede0d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] regression: selinux testsuite broken since October
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list@lists.sourceforge.net, James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>

On Wed, Jan 6, 2010 at 7:25 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> It seems the Makefile rewrite last October broke the selinux testsuite.
> Is it unreasonable to expect that someone who rewrote the Makefile would
> actually try running the testsuite?

    Unfortunately I don't have access to older copies of RHEL, thus I
shoot in the dark sometimes hoping that things work on Fedora 11 (not
often), Gentoo (all the time now) and Ubuntu (periodically), which run
newer packages and have newer kernels... I shot myself in the foot by
not running this on Fedora because Redhat distros have all of the
SELinux junk built in by default, or available for inclusion.
    In general if you want support, there are three options:
    1. Give me a machine to develop on (even if it's a few cycles a
week, month, whatever), so I can avoid breakage. The more
architectures the better as many issues crop up with system calls,
architectural differences, and a gamut of other wonderful problems.
This is particularly true on Linux at the kernel level I've discovered
because
    2. Please become a guinea pig and help me test the changes and
report them as soon as possible.
    3. Isolate, test, develop, and submit a patch.
    I need this (1. / 2.) basic assistance otherwise I can't guarantee
that stuff WILL work because everyone and their brother who's designed
Linux distro X-Y-Z has been consistently inconsistent as far as where
and how things are defined.

> Please, revert the changes or fix them.

Moving forward is the only option unless the change is so ridiculously
illogical or unnecessary that it warrants reverting it. selinux will
be enabled via configurable / inclusive via configure sometime in the
future -- thus why _shouldn't_ the selinux Makefiles be migrated as
well?

> See testcases/kernel/security/selinux-testsuite/README for the
> instructions.

Ok. This is a start... time to fire up my Fedora VM...

Thanks,
-Garrett

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
