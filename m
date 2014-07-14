Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X6ga7-0000Nh-1B
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 13:46:15 +0000
Date: Mon, 14 Jul 2014 15:45:46 +0200
From: chrubis@suse.cz
Message-ID: <20140714134546.GC25946@rei.suse.cz>
References: <20140710161355.GA14288@ls3530.dhcp.wdf.sap.corp>
	<1886124008.9567128.1405336855355.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1886124008.9567128.1405336855355.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] fix fanotify syscall (again)
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
> just trying to understand why it's not working now. Shouldn't __LONG_LONG_PAIR
> take care of endian issues?

I've talked about this on linux-api mailing list and been told that
it's not only about endianity but also about packing of the arguments[0].

I've also been hinted that there are scripts that can generate correct
code to call syscalls with 64 bit arguments from syscall descriptions in
klibc[1] and that it's resonably easy to reuse these but haven't yet had
time to look into that.

[0] http://marc.info/?l=linux-api&m=140016971909948&w=2
[1] http://git.kernel.org/cgit/libs/klibc/klibc.git/

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck&#174;
Code Sight&#153; - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
