Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y1FJT-0001Ow-9J
	for ltp-list@lists.sourceforge.net; Wed, 17 Dec 2014 14:10:51 +0000
Date: Wed, 17 Dec 2014 15:10:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141217141028.GA17634@rei>
References: <1414681678-28439-1-git-send-email-mmarhefk@redhat.com>
	<1415206150-12848-1-git-send-email-mmarhefk@redhat.com>
	<20141202164235.GA22135@rei.suse.de>
	<1962544618.7994595.1417604885928.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1962544618.7994595.1417604885928.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v2] containers: added mountns/mountns05.c
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I used msg IPC because this test needs to synchronize 3 processes (parent
> and 2 children) and in this case at least 6 named pipes would be needed.
> So instead 6 named pipes I used only one message queue where each process
> has its own message type.

There are a few things I do not like about this solution:

* There is a static IPC key compiled in the source
  - we cannot run two instances of the test at once
  - it may interfere with the rest of the system

* There are no timeouts, if something fails the parent may end up
  waiting forever

* The code could be shorter, it takes more than three lines to just
  send the notification.

I guess that one of the problems is that the child processes need to
signal each other, which is something that the checkpoint code wasn't
written for. I think that it would be better to adapth the library so
that it fits the needs that has emerged. Or write better one that fits
all needs.

Looking at the checkpoint code, we would need a two more functions
that could be used synchronize between child processes. What about:

tst_checkpoint_signal_sibling(const char *file, const int lineno,
                              struct tst_checkpoint *checkpoint);

tst_checkopint_sibling_wait(const char *file, const int lineno,
                            struct tst_checkpoint *checkpoint);

Internally we can just reuse the tst_checkpoint_child_wait() and
tst_checkpoint_signal_parent() code (move it to separate static
functions and add a parameter with the character to be send/received).

Would that solve the problem here or are there any other obstacles?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
