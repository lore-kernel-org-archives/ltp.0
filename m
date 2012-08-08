Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sz2Y6-0001zq-1K
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:27:30 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sz2Y0-0008AC-Nm
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:27:30 +0000
Received: by pbcwy7 with SMTP id wy7so1085529pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 02:27:18 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Wed,  8 Aug 2012 17:26:57 +0800
Message-Id: <d894c0a00563bc5666b1665040e6bc7fca4e8eda.1344418001.git.caspar@casparzhang.com>
In-Reply-To: <9fe539868cd8580388b98397a87e25ff1cac34bc.1344418001.git.caspar@casparzhang.com>
References: <9fe539868cd8580388b98397a87e25ff1cac34bc.1344418001.git.caspar@casparzhang.com>
In-Reply-To: <9fe539868cd8580388b98397a87e25ff1cac34bc.1344418001.git.caspar@casparzhang.com>
References: <9fe539868cd8580388b98397a87e25ff1cac34bc.1344418001.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH 4/4] runtest/syscalls: add cma testcases
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


adding the following testcases into runtest/syscalls:

    process_vm_readv02
    process_vm_readv03
    process_vm_writev02

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 runtest/syscalls |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


--------------1.7.8.6
Content-Type: text/x-patch;
	name="0004-runtest-syscalls-add-cma-testcases.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0004-runtest-syscalls-add-cma-testcases.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index 7c4c9ca..edf6c1e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -734,7 +734,10 @@ pread03_64 pread03_64
 profil01 profil01
 
 process_vm_readv01 process_vm01 -r
+process_vm_readv02 process_vm_readv02
+process_vm_readv03 process_vm_readv03
 process_vm_writev01 process_vm01 -w
+process_vm_writev02 process_vm_writev02
 
 pselect01 pselect01
 pselect01_64 pselect01_64

--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



