Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YlEMJ-0005oZ-FL
	for ltp-list@lists.sourceforge.net; Thu, 23 Apr 2015 10:27:51 +0000
Date: Thu, 23 Apr 2015 12:27:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150423102725.GA18237@rei.suse.de>
References: <1427970931.19106.8.camel@G08JYZSD130126.localdomain>
	<20150402115922.GA30680@rei>
	<1429010688.7190.24.camel@G08JYZSD130126.localdomain>
	<20150422124738.GA32110@rei>
	<1429755598.2416.14.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1429755598.2416.14.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [RFC PATCH v2 1/2] testcases/lib/test.sh: added
	SAFE_CALL*()
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > Looks good but the names are a bit confusing. The SAFE_CALL does
> > redirect the output while SAFWE_CALL_REDIRECT does not.
> > 
> 
> If *users* want to redirect the output they need use SAFE_REDIRECT. :-/

I know how the name was choosen, but that does not change the fact that
it was unintuitive :).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
