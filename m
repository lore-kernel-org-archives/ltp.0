Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WwoD7-0001Q1-42
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 07:53:41 +0000
Date: Tue, 17 Jun 2014 09:53:27 +0200
From: chrubis@suse.cz
Message-ID: <20140617075327.GA28518@rei.Home>
References: <1402299431-2045-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140612173253.GA5669@rei> <539A8784.7010709@cn.fujitsu.com>
	<20140616140556.GA18761@rei.suse.cz>
	<539F9939.5000505@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <539F9939.5000505@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/2] lib: add tst_fs_link_count.c
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Ok, I will push (slightly modified version).
> > 
> > I did a few small changes:
> > 
> > * it creates the directory automatically if it does not exist
> > 
> > * uses tst_resm() instead of printf()
> > 
> > * changed the file/directory numbering to start from 0
> >   which simplifies the code a bit
> > 
> > * added two simple tests under lib/tests/
> 
> Thanks very much for your modification.
> It really looks better than my v2 version, especially for the new comments
> in include/test.h, it is more neater, thanks.

We should also add documentation into the Test Writing Guidelines. Will
you send a patch or should I do it?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
