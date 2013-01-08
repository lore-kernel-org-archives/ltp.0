Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TsSES-0002O7-8O
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 06:00:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TsSER-0004KG-CO
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 06:00:16 +0000
Message-ID: <50EBB555.5060906@cn.fujitsu.com>
Date: Tue, 08 Jan 2013 13:57:41 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1357277005.git.zliu@redhat.com>
	<2a7ebedf19609652dd8a5da772b4575927d6891d.1357277005.git.zliu@redhat.com>
In-Reply-To: <2a7ebedf19609652dd8a5da772b4575927d6891d.1357277005.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v2 1/2] mm/lib: rewrote create_same_memory()
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 01/04/2013 02:12 PM, Zhouping Liu wrote:
> create_same_memory() was too large and contained lots of duplicated codes,
> and it's a little hard-coding, so that it's not easy to read and
> extend it for new case.
> 
> I splited it for five sub-functions:
> 
>   ksm_child_memset();
>   create_ksm_child();
>   stop_ksm_children();
>   resume_ksm_children();
>   create_smae_memory();
> 
> Also I intruduced a data struct to control the mergeable data:
> 
>   struct ksm_merge_data {
>         char data;
>         int mergeable_size;
>   };
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>

I have no objection.

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Thanks,
Wanlong Gao



------------------------------------------------------------------------------
Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
and more. Get SQL Server skills now (including 2012) with LearnDevNow -
200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only - learn more at:
http://p.sf.net/sfu/learnmore_122512
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
