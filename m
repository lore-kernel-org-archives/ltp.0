Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q3qaS-0007Ri-6g
	for ltp-list@lists.sourceforge.net; Sun, 27 Mar 2011 14:05:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q3qaR-0004oB-8O
	for ltp-list@lists.sourceforge.net; Sun, 27 Mar 2011 14:05:00 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2RE4rRn009970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Mar 2011 10:04:53 -0400
Message-ID: <4D8F43FE.7080305@redhat.com>
Date: Sun, 27 Mar 2011 22:04:46 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <1301233261-25499-1-git-send-email-czhang@redhat.com>
In-Reply-To: <1301233261-25499-1-git-send-email-czhang@redhat.com>
Subject: Re: [LTP] [PATCH] [syscalls] io_submit: fix broken testcase
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
Cc: czhang@redhat.com, emcnabb@redhat.com

Sorry, there are some trailing whitespace in the patch, please ignore
this one, I'll workout a newer version.

On 03/27/2011 09:41 PM, czhang@redhat.com wrote:
> 
> io_submit01 contains 4 negative testing: EINVAL, EFAULT, EINVAL+EFAULT
> and EBADF. The first 3 testcases didn't initialize the content of 'ctx'
> so that they contained invalid argument in the cases. This may cause
> incorrect result on some architectures, like:
> 
> io_submit01    1  TPASS  :  expected failure - returned value = 22 :
> Invalid argument
> io_submit01    2  TFAIL  :  unexpected returned value - -22 - expected
> -14
> io_submit01    3  TPASS  :  expected failure - returned value = 22 :
> Invalid argument
> io_submit01    4  TPASS  :  expected failure - returned value = 9 : Bad
> file descriptor
> 
> I fixed this issue by moving the initialization of ctx before the cases,
> also added some additional negative + positive cases. Now tested on x86
> and s390x system, the results seem good:
> 
> io_submit01    1  TPASS  :  expected failure - returned value = 22 :
> Invalid argument
> io_submit01    2  TPASS  :  expected failure - returned value = 22 :
> Invalid argument
> io_submit01    3  TPASS  :  expected failure - returned value = 22 :
> Invalid argument
> io_submit01    4  TPASS  :  expected failure - returned value = 14 : Bad
> address
> io_submit01    5  TPASS  :  expected failure - returned value = 22 :
> Invalid argument
> io_submit01    6  TPASS  :  expected failure - returned value = 9 : Bad
> file descriptor
> io_submit01    7  TPASS  :  call succeeded expectedly
> io_submit01    8  TPASS  :  call succeeded expectedly
> 
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
>  testcases/kernel/syscalls/io_submit/io_submit01.c |  143 ++++++++++++++-------
>  1 files changed, 98 insertions(+), 45 deletions(-)
> 


-- 
/---------------------------------------\
| Name: Caspar Zhang                    |
| Team: Kernel-QE                       |
| Timezone: GMT+0800 (Asia/Shanghai)    |
| IRC: caspar @ #kernel-qe, #eng-china  |
| Phone: +86-10-6260-8150               |
| Cellphone: +86-138-1073-0090          |
\---------------------------------------/

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
