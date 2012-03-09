Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S63o2-0007LA-MI
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 17:40:42 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S63nx-0004n6-7K
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 17:40:42 +0000
Received: by dado14 with SMTP id o14so1740401dad.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 09 Mar 2012 09:40:31 -0800 (PST)
Message-ID: <4F5A404B.2000100@casparzhang.com>
Date: Sat, 10 Mar 2012 01:39:23 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1330346483-12279-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1330346483-12279-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] mm/oom: add oom control check for memcg
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
To: LTP List <ltp-list@lists.sourceforge.net>

On 02/27/2012 08:41 PM, Caspar Zhang wrote:
> 
> upstream commit: 9490ff2 implements OOM notifier using cgroup
> notification API, which allows applications to be notified when OOM
> happens in memory cgroups. This patch adds oom control checking when
> executing oom tests.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  configure.ac                       |    1 +
>  testcases/kernel/mem/include/mem.h |    4 +++
>  testcases/kernel/mem/lib/mem.c     |   40 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 44 insertions(+), 1 deletions(-)
> 

FYI. This one has been committed since no objection seen so far.

Thanks,
Caspar

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
