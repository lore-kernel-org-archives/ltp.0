Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UrSea-0003ax-T1
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 12:47:25 +0000
Date: Tue, 25 Jun 2013 14:48:54 +0200
From: chrubis@suse.cz
Message-ID: <20130625124854.GD31268@rei>
References: <1372066195-18166-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130624162328.GC3492@rei> <51C932ED.6060309@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51C932ED.6060309@oracle.com>
Subject: Re: [LTP] [PATCH] syscalls/swapon: fix for variable page size
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > This part of the code seems to be repeated several times. What about
> > making it into library code in lib/tst_fill_file.c instead?
> >
> > Something like:
> >
> > tst_fill_file(const char *path, char pattern, size_t bs, size_t count);
> >
> > And I would open the and write the file directly rather than doing
> > system("dd ...");
> >
> 
> Agreed. But my intent was to make a little "fix" not introducing any 
> extra logic to these test.
> 
> Ok, I'll rewrite this.

Thanks.

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
