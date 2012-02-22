Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S0Ga5-000584-NQ
	for ltp-list@lists.sourceforge.net; Wed, 22 Feb 2012 18:06:21 +0000
Date: Wed, 22 Feb 2012 19:06:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120222180646.GA4018@saboteur.suse.cz>
References: <4F20EB81.4030109@cn.fujitsu.com> <4F33277F.3050905@cn.fujitsu.com>
	<20120222150948.GA32698@saboteur.suse.cz>
	<4F45071E.20209@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F45071E.20209@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v4 1/8] A library used to test memcg
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> 
> Sure, agree. Please merge this. :)
> 

Hmm, somehow these patches fail to apply on latest git

...
Applying: A library used to test memcg
Applying: Modify memcg_function_test.sh to use lib
error: patch failed:
testcases/kernel/controllers/memcg/functional/memcg_function_test.sh:25
error:
testcases/kernel/controllers/memcg/functional/memcg_function_test.sh:
patch does not apply
Patch failed at 0002 Modify memcg_function_test.sh to use lib
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
