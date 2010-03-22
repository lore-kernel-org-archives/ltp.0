Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NteNu-0006JA-Jm
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 09:57:22 +0000
Received: from mail-iw0-f195.google.com ([209.85.223.195])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NteNt-0005tE-Ra
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 09:57:22 +0000
Received: by iwn33 with SMTP id 33so4196200iwn.23
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Mar 2010 02:57:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100322090555.GA6154@chamarthy>
References: <20100322090555.GA6154@chamarthy>
Date: Mon, 22 Mar 2010 02:57:15 -0700
Message-ID: <364299f41003220257n35cc40cer8eacb6a011b173e3@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] memcg_function tests failing on s390
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
To: Srinivasa R Chamarthy <schamart@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Mar 22, 2010 at 2:05 AM, Srinivasa R Chamarthy
<schamart@linux.vnet.ibm.com> wrote:
> Hi LTP,
>
> The memcg_function tests were failing in s390 as the condition for checking
> support for memory controller is not getting satisfied. Eventhough the cgroup
> memory is enabled, the script comes out saying that the memory support is not
> available in the kernel.
>
> This patch changes the condition checking for memory cgroup support in kernel
> in the script memcg_function_test.sh.

    Already fixed on HEAD.
Thanks,
-Garrett

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
