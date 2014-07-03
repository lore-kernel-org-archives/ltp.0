Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X2eso-0003Dt-CI
	for ltp-list@lists.sourceforge.net; Thu, 03 Jul 2014 11:08:54 +0000
Date: Thu, 3 Jul 2014 13:08:32 +0200
From: chrubis@suse.cz
Message-ID: <20140703110832.GA2534@rei.scz.novell.com>
References: <53B4D46A.6010201@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53B4D46A.6010201@cn.fujitsu.com>
Subject: Re: [LTP] [RFC] remove TRETR flag
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi!
> Flag TRETR is introduced to indicate test case is no longer valid and has been "retired".
> I grep "TRETR" in LTP and do not find any test cases use this flag. According to my understanding,
> if the test case is no longer valid, we can just remove it form LTP. So I'd like to remove this flag.

Agreed. Just send a patch that removes all TRETR instaces from LTP.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
