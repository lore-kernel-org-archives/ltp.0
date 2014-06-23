Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wz6xJ-0000aX-Rh
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 16:18:53 +0000
Date: Mon, 23 Jun 2014 18:18:36 +0200
From: chrubis@suse.cz
Message-ID: <20140623161836.GA1381@rei.suse.cz>
References: <1402551754-19942-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140617130327.GB29117@rei> <53A0F944.40009@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53A0F944.40009@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] fs/ext4-new-features: fix wrong test point when
 running ext4-persist-prealloc
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
> >>  	ret=1
> >>  
> >> +	temp_tmpdir=$TMPDIR
> >> +	export TMPDIR=mnt_point
> >>  	for ((i = 1; i <= 3; i++))
> >>  	{
> >>  		if ! command -v fallocate0${i} > /dev/null 2>&1; then
> >> @@ -63,6 +65,7 @@ ext4_test_persist_prealloc()
> >>  			return
> >>  		fi
> >>  	}
> >> +	TMPDIR=$temp_tmpdir
> > 
> > 
> > Can't we just do:
> > 
> > TMPDIR=mnt_point; fallocate0${i}
> > 
> > instead?
> 
> Yeah, we can do it, but this will make TMPDIR still be "mnt_point" after the fallocate tests.

That is the point of it. As it is you are saving and restoring the
TMPDIR before and after the loop so redefining it only for the part that
matters looks cleaner to me or did I overlooked something?

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
