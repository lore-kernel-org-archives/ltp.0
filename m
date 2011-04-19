Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QC8w0-0007Tn-TB
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 11:17:32 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QC8vz-0007oJ-Qm
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 11:17:32 +0000
Date: Tue, 19 Apr 2011 07:17:25 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <132246322.26988.1303211845214.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <BANLkTikVQHoeKGR8RsUE4wbU=+BPDAQqsw@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] kill05: fix sporadic failures
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
Cc: ltp-list@lists.sourceforge.net

> I'm puzzled by the first wait_for_flag invocation. Wouldn't that
> continue to loop in the infinite loop with the parent pid?
> Furthermore, it doesn't make sense for wait_for_flag to be used at all
> (or the equivalent in the existing test) in the test as the memory
> isn't shared between processes after the fork is done, apart from
> dealing with vfork -- which is only with UCLINUX (fork does COW, vfork
> doesn't), and the subsequent exec does the COW for us.
> This really should use pipes or something equivalent to message
> the child process(es) to continue.

flag is pointer to shared memory, and according to shmget(2)/shmat(2):
"After a fork() the child inherits the attached shared memory segments."

It does complete, gdb and valgrind seem to be fine with it, but to
be completely honest, I haven't tried it with UCLINUX.

I made one copy paste error in wait_for_flag, so I'll post a v3.

> Thanks,
> -Garrett

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
