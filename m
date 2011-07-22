Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QkG4i-00009v-W6
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 13:47:32 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 97C818A908
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 Jul 2011 15:47:25 +0200 (CEST)
Date: Fri, 22 Jul 2011 15:49:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110722134949.GA5869@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] ltp-aiodio.part2 "kills" slower machines
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
To: ltp-list@lists.sourceforge.net

Hi!
When running the LTP on slower machines some ltp-aiodio.part2 testcases
"kills" the machine as it spawns 512 or 1000 childrens that do I/O.
Anybody else run in this problem?

I would like to either remove these testcases entirely, change them not
to spawn that much of childrens or splitting the runtest file into two,
one containing "light" testcases and the other one for the "stress"
ones. Any thoughts on this?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
10 Tips for Better Web Security
Learn 10 ways to better secure your business today. Topics covered include:
Web security, SSL, hacker attacks & Denial of Service (DoS), private keys,
security Microsoft Exchange, secure Instant Messaging, and much more.
http://www.accelacomm.com/jaw/sfnl/114/51426210/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
