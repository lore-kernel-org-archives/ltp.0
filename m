Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OV75D-0004Aa-IN
	for ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 18:04:55 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OV75B-0003fs-Ao
	for ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 18:04:55 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <201007011301.59073.vapier@gentoo.org>
References: <20100701165206.23119.26070.sendpatchset@subratamodak.linux.ibm.com>
	<201007011301.59073.vapier@gentoo.org>
Date: Sat, 03 Jul 2010 23:20:55 +0530
Message-Id: <1278179456.7665.9.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v3] Remove files which does not have a dmesg entry
Reply-To: subrata@linux.vnet.ibm.com
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP List Members <ltp-list@lists.sf.net>

On Thu, 2010-07-01 at 13:01 -0400, Mike Frysinger wrote:
> On Thursday, July 01, 2010 12:52:07 Subrata Modak wrote:
> > +		if find "$DMESG_DIR" -size 0 -exec rm {} + ; then
> > +			echo "cd to $DMESG_DIR failed: $?"
> > +		fi
> 
> err, sorry, you probably want "! find"

True. Resending ;-)

Regards--
Subrata

> -mike


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
