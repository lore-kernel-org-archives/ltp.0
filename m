Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NWm7W-0001DD-29
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 07:33:54 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NWm7V-00028A-11
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 07:33:54 +0000
Received: by pwj11 with SMTP id 11so1744091pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Sun, 17 Jan 2010 23:33:46 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 17 Jan 2010 23:33:46 -0800
Message-ID: <364299f41001172333q76264309tc613fca2329f8bbd@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Ran into a brick wall with make 3.80
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
To: LTP list <ltp-list@lists.sourceforge.net>

    So... it appears that I've run into a serious brick wall with make
3.80 with eval blocks, which looks like:

make[4]: Leaving directory
`/scratch/ltp/testcases/kernel/controllers/libcontrollers'
make[4]: Entering directory
`/scratch/ltp/testcases/kernel/controllers/libcontrollers'
/scratch/ltp/include/mk/env_post.mk:72: *** missing `endif'.  Stop.

    There are so many bugfixes that have gone into read.c and a few
other things in make that I don't know which one is causing the
problem, yet. I honestly don't know if getting past this would be
possible, or fruitful, but I'll keep on trying...
Thanks,
-Garrett

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
