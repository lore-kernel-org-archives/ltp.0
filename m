Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1Wcah4-0002Ry-Ej
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 13:25:02 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1Wcah0-0002VI-C9
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 13:25:01 +0000
Date: Tue, 22 Apr 2014 15:24:40 +0200
From: Mats Liljegren <mats.liljegren@enea.com>
Message-ID: <20140422152440.0dce3888@mats-desktop>
In-Reply-To: <1397669278-848-1-git-send-email-mats.liljegren@enea.com>
References: <20140416091527.40612b3c@mats-desktop>
	<1397669278-848-1-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Make SAFE_* calls more informative when failing
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

On Wed, 16 Apr 2014 19:27:57 +0200
Mats Liljegren <mats.liljegren@enea.com> wrote:

> 
> When debugging failing test cases I often missed what parameters were
> used in those SAFE_* calls. This patch is meant to fix this.
> 
> The output has been "standardized" into the following format:
> <file>:<line>: <func>(<params>) <error message>
> 
> E.g.:
> test.c:130: chdir(mydir) failed
> 
> This will then be followed by the usual errno stuff if applicable.
> 
> The code compiles, but I haven't figured out a good way of testing
> it. The changes are pretty simple however.
> 
> Regards
> Mats Liljegren

I guess the lack of response on this patch was due to stabilization, but
now that we have a release I'd like to remind about this one...

Regards
Mats Liljegren

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
