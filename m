Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QC7kf-0006Mz-5V
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 10:01:45 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QC7ke-0001i3-DF
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 10:01:45 +0000
Received: by pwj9 with SMTP id 9so3760720pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Apr 2011 03:01:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1772868088.24910.1303201346610.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1772868088.24910.1303201346610.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 19 Apr 2011 03:01:38 -0700
Message-ID: <BANLkTikVQHoeKGR8RsUE4wbU=+BPDAQqsw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Apr 19, 2011 at 1:22 AM, Jan Stancek <jstancek@redhat.com> wrote:
>
> This test failed sporadically, because of:
>
> 1. misusage of getpwnam causes ltpuser1 and ltpuser2 to point
> to same passwd structure, from getpwnam(3):
> "The return value may point to a static area, and may be overwritten by
> subsequent calls to getpwent(3)."
> Fix this by copying the results from returned pointer.
>
> 2. race condition between parent and child
> The test actually worked when child didn't have time to set its euid.
> Fix this by waiting for child to set its euid.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> =A0testcases/kernel/syscalls/kill/kill05.c | =A0 47 +++++++++++++++++++++=
+--------
> =A01 files changed, 34 insertions(+), 13 deletions(-)

    I'm puzzled by the first wait_for_flag invocation. Wouldn't that
continue to loop in the infinite loop with the parent pid?
Furthermore, it doesn't make sense for wait_for_flag to be used at all
(or the equivalent in the existing test) in the test as the memory
isn't shared between processes after the fork is done, apart from
dealing with vfork -- which is only with UCLINUX (fork does COW, vfork
doesn't), and the subsequent exec does the COW for us.
    This really should use pipes or something equivalent to message
the child process(es) to continue.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Benefiting from Server Virtualization: Beyond Initial Workload =

Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve =

application availability and disaster protection. Learn more about boosting =

the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
