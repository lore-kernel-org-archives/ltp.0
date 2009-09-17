Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MoHa0-0004K5-Ps
	for ltp-list@lists.sourceforge.net; Thu, 17 Sep 2009 14:03:24 +0000
Date: Thu, 17 Sep 2009 15:48:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090917134805.GA5337@schrodinger.suse.cz>
References: <f5a7b3810908310549t6ced24qd9e0faf634d2319f@mail.gmail.com>
	<1252323746.4922.34.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1252323746.4922.34.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH 16/21] Add sigreturn01 test for sigreturn syscall
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, naresh kamboju <naresh.kernel@gmail.com>, Manas Kumar Nayak <maknayak@in.ibm.com>

Hi!
> Ok. Please send a signed-off patch to remove this from LTP.
>

Hmm, IMHO there is no way how to delete directory in standard patch.

I could create a patch that would remove all sigreturn files but not the
directory itself and that would lead just to another empty directory in cvs
tree.

Are there any other solutions?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
