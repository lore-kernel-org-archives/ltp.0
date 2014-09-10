Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XRksp-0008Iy-Sx
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 16:36:39 +0000
Date: Wed, 10 Sep 2014 18:36:23 +0200
From: chrubis@suse.cz
Message-ID: <20140910163623.GD16633@rei>
References: <1407309452.2223.13.camel@G08JYZSD130126>
	<20140909144034.GA6108@rei>
	<1410317916.31685.34.camel@G08JYZSD130126>
	<1095333434.20418604.1410337882836.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1095333434.20418604.1410337882836.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] securebits/check_keepcaps.c: Add comments about
 cap_get_flag may return -1
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > I think libcap was compiled with wrong kernel headers and it is a bug in
> > distribution. I had installed these packages all from the default
> > distribution. The value of CAP_LAST_CAP is different.
> 
> Someone else reported it already:
>   Bug 1046008 - Some capabilities aren't be defined
>   https://bugzilla.redhat.com/show_bug.cgi?id=1046008
> 
> Patch looks good to me, it makes the bug more visible.

Ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
