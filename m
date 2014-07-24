Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XAHye-0002MF-UF
	for ltp-list@lists.sourceforge.net; Thu, 24 Jul 2014 12:18:28 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XAHyc-0003n1-JY
	for ltp-list@lists.sourceforge.net; Thu, 24 Jul 2014 12:18:28 +0000
Date: Thu, 24 Jul 2014 08:18:20 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <239904743.14759248.1406204300232.JavaMail.zimbra@redhat.com>
In-Reply-To: <441933928.14756198.1406203882374.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] cpuset01 -I 3600
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
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: CAI Qian <caiqian@redhat.com>

Hi,

is it necessary for this reproducer to run for an hour?

Would anyone object if it's moved to some stress runtest?
Or we can keep it also in mm, but with some smaller runtime, say 5 minutes.

Any thoughts?

Regards,
Jan

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
