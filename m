From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 10 Jun 2021 12:02:05 +0800
Subject: [LTP] [PATCH] lib/tst_virt.c: Add fallback when not using Microsoft
 Hyper-V hypervisor
Message-ID: <1623297725-3296-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we don't use Microsoft Hyper-V hypervisorm, getrusage04 will report the
following error:
getrusage04    1  TBROK  :  tst_virt.c:175: invalid virt_type flag: 6
getrusage04    2  TBROK  :  tst_virt.c:175: Remaining cases broken

We should add is_hyperv() function when try_systemd_detect_virt returns -1.
But it is a bit complexd according to systemd-detect-virt implementation[1].
Microsoft Hyper-V hypervisor detection has been introduced since long time ago,
most system should support it.

[1]https://github.com/systemd/systemd/blob/main/src/basic/virt.c

Reported-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 lib/tst_virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index 14c4d526c..d23d7f564 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -166,6 +166,7 @@ int tst_is_virt(int virt_type)
 	case VIRT_IBMZ_LPAR:
 	case VIRT_IBMZ_ZVM:
 		return is_ibmz(virt_type);
+	case VIRT_HYPERV:
 	case VIRT_OTHER:
 		return 0;
 	}
-- 
2.23.0

