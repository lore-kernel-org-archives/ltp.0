Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1T4m0R-0002ei-Vj
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 05:00:27 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T4m0P-0005Og-Qa
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 05:00:27 +0000
Received: by pbcwy7 with SMTP id wy7so2440427pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 23 Aug 2012 22:00:19 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Fri, 24 Aug 2012 12:53:35 +0800
Message-Id: <fd08e9dab691729bc37331861c93d95993c873cd.1345783919.git.caspar@casparzhang.com>
In-Reply-To: <cover.1345783919.git.caspar@casparzhang.com>
References: <cover.1345783919.git.caspar@casparzhang.com>
In-Reply-To: <cover.1345783919.git.caspar@casparzhang.com>
References: <cover.1345783919.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.12"
Subject: [LTP] [PATCH v2 4/4] runtest/syscalls: add cma testcases
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
--------------1.7.12
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


adding the following testcases into runtest/syscalls:

    process_vm_readv02
    process_vm_readv03
    process_vm_writev02

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 runtest/syscalls | 3 +++
 1 file changed, 3 insertions(+)


--------------1.7.12
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

--------------1.7.12
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
--------------1.7.12
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.12--



