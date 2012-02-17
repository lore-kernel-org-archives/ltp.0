Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1RyQwW-0007mG-DK
	for ltp-list@lists.sourceforge.net; Fri, 17 Feb 2012 16:45:56 +0000
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RyQwS-0008JG-Fr
	for ltp-list@lists.sourceforge.net; Fri, 17 Feb 2012 16:45:56 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D0F2236
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Feb 2012 16:45:44 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D40D929AB
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Feb 2012 16:45:44 +0000 (GMT)
Message-ID: <4F3E8435.8020401@st.com>
Date: Fri, 17 Feb 2012 17:45:41 +0100
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
MIME-Version: 1.0
References: <cbed67486755eab955f21fcaf82f5351f14e6ead.1329458810.git.zliu@redhat.com>
	<4F3E81EA.8040404@imgtec.com>
In-Reply-To: <4F3E81EA.8040404@imgtec.com>
Subject: Re: [LTP] [PATCH] lib/mem.c: add HAVE_NUMA_H to avoid compiling
	error
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
To: ltp-list@lists.sourceforge.net

On 17/02/2012 17.35, Markos Chandras wrote:
> On 02/17/2012 06:09 AM, Zhouping Liu wrote:
> 
>> In the patch<9b70f0970>, I used numa_max_node(), which's included in <numa.h>,
>> but I forgot to add precompiled header: HAVE_NUMA_H, the patch fixed it.
>>
>> Signed-off-by: Zhouping Liu <zliu@redhat.com>
>> ---
>>  testcases/kernel/mem/lib/mem.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
>> index 25cdfd4..3843785 100644
>> --- a/testcases/kernel/mem/lib/mem.c
>> +++ b/testcases/kernel/mem/lib/mem.c
>> @@ -148,6 +148,7 @@ void testoom(int mempolicy, int lite, int numa)
>>  	oom(KSM, mempolicy, lite);
>>  }
>>  
>> +#ifdef HAVE_NUMA_H
>>  long count_numa(void)
>>  {
>>  	int nnodes = 0;
>> @@ -161,6 +162,7 @@ long count_numa(void)
>>  
>>  	return nnodes;
>>  }
>> +#endif
>>  
>>  int path_exist(const char *path, ...)
>>  {
> 
> 
> Yes, that works for me
> 
> Tested-by: Markos Chandras <markos.chandras@imgtec.com>
> 

confirmed, works for me too

carmelo

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
