Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMxdE-0007Pv-Fo
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 12:17:16 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMxd9-0001Jf-3i
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 12:17:16 +0000
Date: Wed, 5 Aug 2015 14:16:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150805121649.GB31234@rei.suse.de>
References: <1436349144-9621-1-git-send-email-songxiumiao@inspur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436349144-9621-1-git-send-email-songxiumiao@inspur.com>
Subject: Re: [LTP] [PATCH] memcg_functinon: testcase_30 function
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
To: Xiumiao Song <songxiumiao@inspur.com>
Cc: Michal Hocko <mhocko@suse.cz>, ltp-list@lists.sourceforge.net, wunan@inspur.com

Hi!
> Testcase_30 function testing mem_cgroup_force_empty_write
> function return -EBUSY,when there is a task in cgroup.
> Namely when setting memory.force_empty,it will be failed.
> However,kernel 3.16 and above do nothing,
> whatever there is a task in cgroup or not.

This has been fixed in git by:

commit 5c3635d26929a00103f70a54365229449f71a217
Author: Michal Hocko <mhocko@suse.cz>
Date:   Thu May 14 16:24:38 2015 +0200

    controllers/memcg: fix force_empty

    testcase_29 and testcase_30 are no longer testing anything because
    the kernel allows to use force_empty even for memcgs with active
    tasks since f61c42a7d911 ("memcg: remove tasks/children test from
    mem_cgroup_force_empty()) kernel commit.

    If we really want to test this functionality then just expect the
    success for regular mmap and expect the failure when the charged
    memory is mlocked.

    Signed-off-by: Michal Hocko <mhocko@suse.cz>
    Signed-off-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
