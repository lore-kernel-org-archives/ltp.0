Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1XcDVi-0004kY-AJ
	for ltp-list@lists.sourceforge.net; Thu, 09 Oct 2014 13:12:02 +0000
Received: from mail-ig0-f172.google.com ([209.85.213.172])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XcDVh-0000Wy-Hz
	for ltp-list@lists.sourceforge.net; Thu, 09 Oct 2014 13:12:02 +0000
Received: by mail-ig0-f172.google.com with SMTP id r2so12651279igi.5
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Oct 2014 06:11:55 -0700 (PDT)
Date: Thu, 9 Oct 2014 21:11:44 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20141009131144.GH24933@Leo.nay.redhat.com>
References: <1412837187-5523-1-git-send-email-liuhangbin@gmail.com>
	<54365ED3.9020805@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54365ED3.9020805@oracle.com>
Subject: Re: [LTP] [PATCH] network/test_net: delete obsolete net_cmdlib.sh
 and move read_opts() to test_net
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Thu, Oct 09, 2014 at 02:09:23PM +0400, Alexey Kodanev wrote:
> Hi!
> 
> Please find almost the same patch that I've re-sent to ML yesterday.
> 
> Moreover, net_cmdlib.sh source cmdlib.sh, so the patch should replace all
> other outdated functions. And it's better to do it in the separate patches.
> Also note that I've already sent patches that fix ping, sendfile and tcpdump
> tests (pending review).
> 
Sorry, only saw your reply for my last mail. Since you have send the same
path, please ignore this one. I will find and review you patch then.

Thanks for the remaind.

Best regards,
Hangbin Liu

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
