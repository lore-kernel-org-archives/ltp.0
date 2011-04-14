Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QAMve-00052I-RL
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 13:49:50 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QAMve-0000vu-6Z
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 13:49:50 +0000
Received: by pvc30 with SMTP id 30so917085pvc.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Apr 2011 06:49:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <511817558.75058.1302787997174.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <BANLkTin8di7Q=rZVD9=LFnQVDY4ZrSb7OQ@mail.gmail.com>
	<511817558.75058.1302787997174.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Thu, 14 Apr 2011 06:49:44 -0700
Message-ID: <BANLkTikFd+we2YgO9HT-9=1ZtzPiJ6HJaA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On Thu, Apr 14, 2011 at 6:33 AM, Jan Stancek <jstancek@redhat.com> wrote:
> Garrett,
>
> now they are both wrong.

    Another reason why attaching a diff and including an inline diff
is a requirement per the style guide.
Thanks for noticing,
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
