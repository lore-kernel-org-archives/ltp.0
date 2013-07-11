Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UxEa5-0001wc-5L
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 10:58:37 +0000
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 74A51A52C6
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Jul 2013 12:58:29 +0200 (CEST)
Date: Thu, 11 Jul 2013 13:00:15 +0200
From: chrubis@suse.cz
Message-ID: <20130711110014.GB6142@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] RFC add _FORTIFY_SOURCE to default LTP CFLAGS
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
To: LTP <ltp-list@lists.sourceforge.net>

Hi!
Recently just another open(.., O_CREAT) without mode_t flags slipped in
the git, which would have been easily catched early by glibc
_FORTIFY_SOURCE feature. If _FORTIFY_SOURCE is set additional checks for
unused return values, buffer overflows etc. are done. Some distros eable
it even by default...

Does anybody oposse against adding -D_FORTIFY_SOURCE=2 to the default
LTP CFLAGS?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
