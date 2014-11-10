Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xnr38-0006ZY-0A
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 15:38:38 +0000
Date: Mon, 10 Nov 2014 16:38:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141110153801.GA23387@rei.suse.de>
References: <83f98a9de7c4e97c958bd7f9c33610898b998e29.1415630966.git.jstancek@redhat.com>
	<20141110151513.GA23095@rei.suse.de>
	<1738091447.658402.1415633370493.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1738091447.658402.1415633370493.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 v4] controllers/cpuset: update to use test.sh
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > The 'return 1' here is useless after the conversion and so with the
> > rest of the tst_brkm statements.
> 
> I see, I completely forgot how this works with ltpapicmd.

I would rather say 'how it does not work'... :)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
