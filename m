Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1O6yG1-0001uY-Rs
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 03:48:17 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O6yG0-0004ae-KF
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 03:48:17 +0000
Date: Tue, 27 Apr 2010 23:48:09 -0400 (EDT)
From: Caspar ZHANG <czhang@redhat.com>
Message-ID: <1121510575.1119571272426489438.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <180770185.1119551272426467031.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_40471_630243997.1272426489437"
Subject: Re: [LTP] UTIMENSAT test fails hugely
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

------=_Part_40471_630243997.1272426489437
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:

> On Apr 27, 2010, at 4:03 AM, Caspar ZHANG wrote:
> 
> > 
> > ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
> > 
> >> On Apr 27, 2010, at 2:23 AM, Caspar ZHANG wrote:
> >> 
> >>> <syscalls-utimensat01-run-sudo-without-tty.patch>
> >> 
> >> 	What good would this do if the value's deleted and not restored?
> It's
> >> better to document this IMO because then it at least brings the
> issue
> >> to light as there may be other areas of the tree that require this
> >> kind of intervention.
> > 
> > I didn't realize this matter, thanks for pointing it out. So what if
> adding 
> > the `Defaults requiretty' value back after this test finished? 
> 
> 	If it's commented out (which is better than it being deleted), sure.
> Just be sure to do the inverse operation via trap ... EXIT ;), like:
> 
> setup
> trap 'trap "" EXIT; teardown' EXIT

Thanks Garrett, the modified patch attached.

Cheers,
Caspar

> 
> 	You may want to execute the handler before the setup call is invoked
> to ensure that everything done is properly undone in the event of a
> failure during setup.
> 	Also, watch out for cases where a user may have done:
> 
> # requiretty
> 
> instead of:
> 
> requiretty
> 
> 	It probably would be wise to preserve all leading and trailing
> characters for teardown to avoid inadvertently enabling requiretty in
> sudo.
> 	The EXIT trap handler isn't 100% foolproof, but it protects against
> all but SIGKILL or SIGSTOP from being executed as they're NMIs.
> Cheers,
> -Garrett

-- 
Kernel Associate Quality Engineer
Red Hat Inc. (Beijing R&D Branch)

Red Hat China R&D Branch Unit 907, North Tower C, 
  Raycom Infotech Park, No.2 Kexueyuan Nanlu, 
  Haidian District, Beijing 100190

TEL: +86-10-62608150
Web: http://www.redhat.com/

------=_Part_40471_630243997.1272426489437
Content-Type: text/x-patch;
	name=syscalls-utimensat01-run-sudo-without-tty.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=syscalls-utimensat01-run-sudo-without-tty.patch

Hi,
	Most automated testing systems have no tty when running tests,
	so the utimensat01 test may fail with the following error msg:

	sudo: sorry, you must have a tty to run sudo

	to avoid this, commenting `Defaults    requiretty' line in
	/etc/sudoers can make this testcase work. After test finished,
	restore this line.

	Signed-off-by: Caspar ZHANG <czhang@redhat.com>
---
diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh	2010-04-01 14:23:11.000000000 +0800
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh	2010-04-28 10:56:24.006421192 +0800
@@ -43,6 +43,21 @@
      exit 1;
 fi
 
+# Since some automated testing systems have no tty while testing,
+# delete this line in /etc/sudoers to avoid the error message:
+# `sudo: sorry, you must have a tty to run sudo'
+if grep -q "^Defaults.*requiretty" /etc/sudoers; then
+	echo "${TEST_PROG} 0 INFO : Comment requiretty in /etc/sudoers for automated testing systems"
+	sed -i "s/^Defaults.*requiretty/# Defaults    requiretty/" /etc/sudoers
+	trap 'trap EXIT; teardown' EXIT
+fi
+
+teardown()
+{
+	echo "${TEST_PROG} 0 INFO : Restore requiretty in /etc/sudoers"
+	sed -i "s/^# Defaults    requiretty/Defaults    requiretty/" /etc/sudoers
+}
+
 # Summary counters of all test results
 
 test_num=0

------=_Part_40471_630243997.1272426489437
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

------=_Part_40471_630243997.1272426489437
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_40471_630243997.1272426489437--

