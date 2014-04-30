Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WfTQ9-0007Cr-C8
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 12:15:29 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 24352AAF1
	for <ltp-list@lists.sourceforge.net>;
	Wed, 30 Apr 2014 12:15:21 +0000 (UTC)
Date: Wed, 30 Apr 2014 14:14:33 +0200
From: chrubis@suse.cz
Message-ID: <20140430121433.GA21327@rei>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] Unifying syscalls tests for EFAULT
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

Hi!
We have quite a lot of testcases that passes wrong pointer to syscalls
to check that they return EFAULT and several ad-hoc ways to do this.
I've looked at the code we have and at the kernel implementation in
order to fix this mess.

There are several ways that testcases use to generate bad addres:

* (void*)-1
* get_high_address()
* mmap(..., PROT_NONE, ...)


I've looked how is the checking implemented in kernel and it boils down
to various get_user/put_user variants of strncpy build on the top of the
__get_user and __put_user functions.

On x86 these functions do coarse check for overflow which should be
triggered by the (void*)-1 parameter, then if the pointer is smaller
than maximal possible userspace address and then proceeds with the
memory access. If memory access creates a page fault the page fault
handler executes fixup code which returns the EFAULT and if I understand
this correctly this is the case for both get_high_address() and
mmap(..., PROT_NONE, ...).

Then there are other architectures that does things a little bit
differently and I'm not even sure how because most of the functions are
written in assembler.

Now there are a few things I wonder about:

* Is there an machine that has userspace memory mapped on (void*)-1 ?

  because that would make quite a lot of our testcases to fail

* Is there a machine that has userspace address mapped on NULL ?

  I would consider this pretty evil thing to do, due to fact that
  most of the libraries returns NULL on failure and dereferencing
  these should really cause SegFault or EFAULT.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
