Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QAMfn-0004F2-QI
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 13:33:27 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QAMfj-0000SH-Uj
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 13:33:27 +0000
Date: Thu, 14 Apr 2011 09:33:17 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <511817558.75058.1302787997174.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <BANLkTin8di7Q=rZVD9=LFnQVDY4ZrSb7OQ@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] memcg_process.c: signals initialization
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

Garrett,

now they are both wrong.

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_proce
index 4ba212f..4f8c257 100644
--- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
+++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
@@ -299,11 +299,11 @@ int main(int argc, char *argv[])
        memset(&sigusr_action, 0, sizeof(sigusr_action));
 
        /* TODO: add error handling below. */
-       sigemptyset(&sigusr_action.sa_mask);
+       sigemptyset(&sigint_action.sa_mask);
        sigint_action.sa_handler = &sigint_handler;
        sigaction(SIGINT, &sigint_action, NULL);
 
-       sigemptyset(&sigint_action.sa_mask);
+       sigemptyset(&sigusr_action.sa_mask);
        sigusr_action.sa_handler = &sigusr_handler;
        sigaction(SIGUSR1, &sigusr_action, NULL);

Regards,
Jan

----- Original Message -----
From: "Garrett Cooper" <yanegomi@gmail.com>
To: "Jan Stancek" <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, "Jeffrey Burke" <jburke@redhat.com>
Sent: Thursday, April 14, 2011 3:15:27 PM
Subject: Re: [LTP] [PATCH] memcg_process.c: signals initialization

On Thu, Apr 14, 2011 at 4:44 AM, Jan Stancek <jstancek@redhat.com> wrote:
> 1. There seems to be copy paste error, instead of clearing
> sigusr_action.sa_mask it clears sigint_action.sa_mask.
> Change comes from 6c4d1c6d4b3c116ff88f9209b4860940fb8659a8
>
> 2. Other fields of these structures are left to be uninitialized.
>
> Both 1) and 2) make the behaviour unexpected. Occasionally I saw,
> this program to end upon receiving SIGUSR1.

Committed -- thanks!
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
