Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1YDUd0-000161-GP
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 08:57:38 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YDUcy-0001OM-SK
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 08:57:38 +0000
Date: Tue, 20 Jan 2015 03:57:29 -0500 (EST)
From: Li Wang <liwang@redhat.com>
Message-ID: <1679086070.9165707.1421744249957.JavaMail.zimbra@redhat.com>
In-Reply-To: <671699407.9161653.1421743558663.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] fanotify06 always failed on RHEL7
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
To: jack@suse.cz
Cc: ltp-list@lists.sourceforge.net

Hi Jack & all,

fanotify06 always failed on RHEL7-GA as below. When I make some change of the codes flow, Test Pass All. 
Could you take a look at my unsure patch?

<<<test_start>>>
tag=fanotify06 stime=1421726003
cmdline="fanotify06"
contacts=""
analysis=exit
<<<test_output>>>
fanotify06    1  TPASS  :  group 0 get event: mask 2 pid=14922 fd=15
fanotify06    2  TPASS  :  group 1 get event: mask 2 pid=14922 fd=15
fanotify06    3  TPASS  :  group 2 get event: mask 2 pid=14922 fd=15
fanotify06    4  TFAIL  :  fanotify06.c:217: group 3 got event
fanotify06    5  TFAIL  :  fanotify06.c:217: group 4 got event
fanotify06    6  TFAIL  :  fanotify06.c:217: group 5 got event
fanotify06    7  TPASS  :  group 6 got no event
fanotify06    8  TPASS  :  group 7 got no event
fanotify06    9  TPASS  :  group 8 got no event

---------
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanot
index 8dcd68a..63519f6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -93,7 +93,8 @@ static void create_fanotify_groups(void)
                                                 "fanotify_init failed");
                                }
                        }
-                       /* Add mount mark for each group */
+                       /* Add mount mark for group with lower priority */
+                       if (p == 0) {
                        ret = fanotify_mark(fd_notify[p][i],
                                            FAN_MARK_ADD | FAN_MARK_MOUNT,
                                            FAN_MODIFY,
@@ -104,9 +105,9 @@ static void create_fanotify_groups(void)
                                         "FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
                                         " '.') failed", fd_notify[p][i]);
                        }
+                       continue;
+                       }
                        /* Add ignore mark for groups with higher priority */
-                       if (p == 0)
-                               continue;
                        ret = fanotify_mark(fd_notify[p][i],
                                            FAN_MARK_ADD |
                                            FAN_MARK_IGNORED_MASK |


-- 
Regards, 
Li Wang 
Email: liwang@redhat.com 


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
