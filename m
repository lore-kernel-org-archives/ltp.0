Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UpFzU-0000Y2-VZ
	for ltp-list@lists.sourceforge.net; Wed, 19 Jun 2013 10:51:53 +0000
Date: Wed, 19 Jun 2013 12:53:22 +0200
From: chrubis@suse.cz
Message-ID: <20130619105321.GA23968@rei>
References: <1371130083-5923-1-git-send-email-alexey.kodanev@oracle.com>
	<20130617171122.GA3387@rei> <51C01086.1020207@oracle.com>
	<51C177A3.4020301@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51C177A3.4020301@oracle.com>
Subject: Re: [LTP] [PATCH v2] configure: add configure checks to compile
 kernel modules
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> >>> +if [[ -n "$LINUX_VERSION_MAJOR" -a -n "$LINUX_PATCHLEVEL" ]]; then
> >>> +    WITH_MODULES="yes"
> >> If there is Makefile and it contains reasonable content, proceed
> >> with module build, ok.
> >>
> >>> +else
> >>> +    WITH_MODULES="no"
> >>> +    if test -n "$LINUX_VERSION"; then
> >>> +        LINUX_VERSION_MAJOR=`echo "$LINUX_VERSION" | \
> >>> +sed -n 's/\([[0-9]]\).*$/\1/p'`
> >>> +        LINUX_PATCHLEVEL=`echo "$LINUX_VERSION" | \
> >>> +sed -n 's/^[[0-9]]*.\([[0-9]]\).*$/\1/p'`
> >>> +    fi
> >> Here we set the MAJOR and PATCHLEVEL even if WITH_MODULES is set to no.
> >> Is this useful? (Maybe I overlooked something but when WITH_MODULES is
> >> set to no, the kernel version is not needed. Or is this here just in
> >> case we will need that someday?)
> >>
> > Yes, it is true, those variables won't be used if WITH_MODULES is set 
> > to "no".
> > My thought was that they might be of use in the future, so far as we 
> > have something
> > in LINUX_VERSION, why not to get MAJOR & PATCHLEVEL from it. But for 
> > now they're
> > useless.
> Should I remove it?

Well I personally don't tend to add anything that is not used or is not
planned to be used in the near future.

> One more thing, would it be better to use LINUX_VERSION_MAJOR & 
> LINUX_VERSION_PATCH?

Either one is fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
