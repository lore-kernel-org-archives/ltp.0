Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QCDUT-0005jV-MG
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 16:09:25 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QCDUT-0004JP-2q
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 16:09:25 +0000
Received: by pvc30 with SMTP id 30so3758486pvc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Apr 2011 09:09:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1510096795.29564.1303220561910.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1510096795.29564.1303220561910.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 19 Apr 2011 09:09:19 -0700
Message-ID: <BANLkTikCFPSFf7bZO0T9zqO8OT5ej+3ZWQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] cgroups/memcg_regression_test: fix random failures
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Apr 19, 2011 at 6:42 AM, Jan Stancek <jstancek@redhat.com> wrote:
>
> 1. dmesg can rotate and number of found bugs can actually go down
> clear the buffer before test to avoid this
>
> 2. clean any groups left behind, if test_4.sh gets killed by OOM
>
> 3. failed mount should be treated as error and return non-zero

Could you please update your workspace and resubmit the patch?
Thanks,
-Garrett

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
