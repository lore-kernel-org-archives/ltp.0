Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XX834-0004QV-GT
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 12:21:26 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XX833-0000dp-0e
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 12:21:26 +0000
Date: Thu, 25 Sep 2014 08:21:16 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1045496206.30292178.1411647676766.JavaMail.zimbra@redhat.com>
In-Reply-To: <20140925065838.7faf7cef@as>
References: <20140925065838.7faf7cef@as>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V2] recvfrom01: Fix invalid flags in testcase 4
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
To: Chuck Ebbert <cebbert.lkml@gmail.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Chuck Ebbert" <cebbert.lkml@gmail.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Thursday, 25 September, 2014 1:58:38 PM
> Subject: [PATCH V2] recvfrom01: Fix invalid flags in testcase 4
> 
> The recv testcases had reported failures on 3.17-rc. [1]
> 
> Three of those failures were invalid assumptions about kernel behavior
> with every possible flag set. [2]
> 
> The fourth failure is because recfrom01 testcase 4 has invalid message
> flags in addition to its invalid address length, making it equivalent
> to test 6 (because the flags get checked  first).
> 
> Remove the invalid flags, and change the text so it's more clear what
> is being tested.
> 
> Also fix indentation that made it harder to spot this bug.
> 
> Version 2: Add better text and remove an erroneous change to the
> buffer length spotted by Jan Stancek.
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1145325
> [2] http://marc.info/?t=141148149900006&r=1&w=2
> 
> Signed-off-by: Chuck Ebbert <cebbert.lkml@gmail.com>

I tested and pushed this.

Regards,
Jan

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
