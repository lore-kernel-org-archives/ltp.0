Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WcbMp-0002ce-DE
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 14:08:11 +0000
Date: Tue, 22 Apr 2014 16:07:17 +0200
From: chrubis@suse.cz
Message-ID: <20140422140717.GF3951@rei>
References: <0247700D01F14443B9209F90AD938CC524366845@sestoex05.enea.se>
	<1397663294-60210-1-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397663294-60210-1-git-send-email-mats.liljegren@enea.com>
Subject: Re: [LTP] [RFC][PATCH] partrt_nohz_full: Introducing a new test case
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net, Kevin Hilman <khilman@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>

Hi!
> This patch introduces a new test case, partrt_nohz_full.
> 
> This is sent as an RFC since as far as I understand it ltp is under
> stabilization. But I still wanted to send what I've got currently to see if
> there are any major issues with it.
> 
> This test case requires a couple of tools which can be cloned from here:
> 
> https://github.com/OpenEneaLinux/rt-tools

This may be a problematic, LTP testcases should be as selfcontained as
possible and should depend only on standard libraries/tools.

> The tools are scripts so they are easily copied to somewhere PATH will find
> them.
> 
> The patch applies on ltp, which can be cloned from here:
> 
> https://github.com/linux-test-project/ltp.git
> 
> The patch applies to commit hash b24ce8f6bcf315078bdc48bbddf780b964ffa59a.
> 
> To run the test case, do the following:
> 
> partrt create <cpumask>

Again selfcontained, the testcase should be able to run just by runltp.
Any preparation and cleanup should be done in the testcase.

> runltp -f partrt_nohz_full
> 
> where <cpumask> should be a hexadecimal mask of nohz_full kernel boot parameter.
> If you're too lazy to translate it by hand, you can use list2mask tool from
> the rt-tools repository:
> 
> partrt create 0x$(list2mask --nohz)
> runltp -f partrt_nohz_full

-- 
Cyril Hrubis
chrubis@suse.cz

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
