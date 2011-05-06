Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QIBzp-0003HZ-HZ
	for ltp-list@lists.sourceforge.net; Fri, 06 May 2011 03:46:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QIBzo-0006AB-LA
	for ltp-list@lists.sourceforge.net; Fri, 06 May 2011 03:46:29 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p463kM3L013381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 5 May 2011 23:46:22 -0400
Message-ID: <4DC36F05.6080704@redhat.com>
Date: Fri, 06 May 2011 11:46:13 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <201104292305.31174.vapier@gentoo.org>
	<5da8d206a0df7808faed5039ade03c433af02abc.1304148727.git.czhang@redhat.com>
In-Reply-To: <5da8d206a0df7808faed5039ade03c433af02abc.1304148727.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH v5] thp testcase come from CVE reproducer
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

On 04/30/2011 04:46 PM, Caspar Zhang wrote:
> 
> This is a reproducer of CVE-2011-0999, which fixed by mainline commit
> a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:
> 
> "Transparent hugepages can only be created if rmap is fully functional.
> So we must prevent hugepages to be created while
> is_vma_temporary_stack() is true."
> 
> When running in a loop, it can trigger panic like this, if kernel
> unpatched:
> 
> kernel BUG at mm/huge_memory.c:1260!
> invalid opcode: 0000 [#1] SMP
> last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cpu_map
> ....
> 
> So I recommend to run it as 'thp01 -I xxx'.
> 
> v5: not using hard depend on /bin/true, use execvp() and "true" instead.
> 
> Signed-off-by: Pingtian Han <phan@redhat.com>
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
>  runtest/mm                        |    2 +
>  testcases/kernel/mem/thp/Makefile |   23 +++++++
>  testcases/kernel/mem/thp/thp01.c  |  124 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/mem/thp/Makefile
>  create mode 100644 testcases/kernel/mem/thp/thp01.c
> 

Hi all, I've modified the patch as suggested and tested it. Any comments
on this new case?

Thanks,
Caspar

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
