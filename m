Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z1xZ4-0000Cb-7e
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2015 13:58:10 +0000
Date: Mon, 8 Jun 2015 15:57:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150608135705.GA15332@rei.suse.de>
References: <20150528104140.GB3192@rei.suse.de>
	<1433151743-30219-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1433151743-30219-2-git-send-email-zenglg.jy@cn.fujitsu.com>
	<20150603142728.GB5078@rei.suse.de>
	<1433754901.2651.50.camel@G08FNSTD140232.g08.fujitsu.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433754901.2651.50.camel@G08FNSTD140232.g08.fujitsu.local>
Subject: Re: [LTP] [PATCH v4 2/2] commands/df: Added new testcase to test
 df(1) command.
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
Cc: ltp-list@lists.sourceforge.net, jy_zhangjin@cn.fujitsu.com

Hi!
> > I don't get why we multiply the numbers, substract them and then divide
> > them again. Can't we just substract them?
> 
> This is for the conversion of measurement units.
> For example:
> We may get the output from 'df', 172k as subtrahend and 11M as minuend.
> If we want to do subtract. We should convert them to the same unit
> first.

Does that actually happen?

Looking at the code the sub() is called from df_verify() that calls df
always with exactly same parameters twice so we always end up with
matching units or am I mistaken?

> > Also does this work for other filesystems than ext2? It may be a good
> > idea to run the test for a few more filesystems as well. We may add a
> > parameter which fs to use and add entries as:
> > 
> 
> Hmm, this is a good idea.
> Nowadays, I am thinking about ext3 and ext4, but I know very few about
> other filesystems. Are you OK that I send you the new patches about
> them(ext2, ext3 and ext4)?

Sounds as a good start. If you add an parameter to specify fs to test we
can easily extend it for any other fs as well later on.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
