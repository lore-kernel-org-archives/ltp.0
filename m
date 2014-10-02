Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XZeud-0000Zl-3V
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 11:51:11 +0000
Date: Thu, 2 Oct 2014 13:50:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141002115029.GA31637@rei.suse.cz>
References: <1411646861-19217-1-git-send-email-mmarhefk@redhat.com>
	<1412249553-19481-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412249553-19481-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH v2] lib/tst_checkpoint.c: added support for
 unlimited number of named pipes
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
> +#define FIFO_LEN 30

I've renamed the FIFO_LEN here to TST_FIFO_LEN because this is a public
header included from the tests and as such it may be collide with test
definitions one day (identifiers starting with tst_ or TST_ are reserved
for LTP library).

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
