Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <marmalodak@gmail.com>) id 1TVOgo-0001Wc-Ei
	for ltp-list@lists.sourceforge.net; Mon, 05 Nov 2012 15:34:14 +0000
Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TVOgj-0000WQ-6S
	for ltp-list@lists.sourceforge.net; Mon, 05 Nov 2012 15:34:14 +0000
Received: by mail-pa0-f47.google.com with SMTP id fa11so3874040pad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Nov 2012 07:34:03 -0800 (PST)
Date: Mon, 5 Nov 2012 07:33:58 -0800
From: John Schmitt <marmalodak@gmail.com>
Message-ID: <20121105153358.GI31939@mediapc.snapdragonfly.net>
References: <20121030003915.GU24652@mediapc.snapdragonfly.net>
	<508FB84D.5050308@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <508FB84D.5050308@linux.vnet.ibm.com>
Subject: Re: [LTP] coverage history
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
To: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Oct 30, 2012 at 12:21:49PM +0100, Peter Oberparleiter wrote:
> On 30.10.2012 01:39, John Schmitt wrote:
> >Is there a way to generate track the coverage of a project over time?  If I'm writing unit tests as my code base expands, can I see how my coverage of that code base goes up or down over time as reported by lcov?
> 
> There is no integrated way to track coverage changes over time with
> lcov, although this may be a good idea for a future improvement.
> 
> For now, you could manually extract the coverage results using the
> --summary or --list option of lcov and put that into a spreadsheet.

Thank you, Peter, this is the best advice I've received.

I see the --list option in lcov but I don't see a --summary.  Are you referring to --function-summaries which gcov takes?  

John

------------------------------------------------------------------------------
LogMeIn Central: Instant, anywhere, Remote PC access and management.
Stay in control, update software, and manage PCs from one command center
Diagnose problems and improve visibility into emerging IT issues
Automate, monitor and manage. Do more in less time with Central
http://p.sf.net/sfu/logmein12331_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
