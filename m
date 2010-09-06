Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1OsZkj-0002vs-5C
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 11:20:45 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OsZke-0000DB-Ku
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 11:20:45 +0000
Date: Mon, 6 Sep 2010 06:12:53 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <391164506.177201283767973568.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <s2r700385ec1004272327n8b26491bt3609f8877b71a385@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8669_714914153.1283767973567"
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
To: Caspar Zhang <casparant@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

------=_Part_8669_714914153.1283767973567
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

This patch seemed not included in latest release?

Thanks,
Caspar

----- "Caspar Zhang" <casparant@gmail.com> wrote:

> On Wed, Apr 28, 2010 at 2:04 PM, Garrett Cooper <yanegomi@gmail.com>
> wrote:
> > The first item is different from the other two. The first one
> ignores the
> > signal (SIG_IGN), whereas the latter two cases reset the handler to
> the
> > default one (SIG_DFL). I prefer the former format, because otherwise
> the
> > signal handlers become reentrable on accident.
> 
> I see. Thank you.
> 
> The final patch ;-)
> 
> Cheers,
> -Caspar
> 
> -- 
> Tags: Ant, Beijing, BUPT, Caspar, Kernel QA, Linux, Open Source,
> Photography, Programmer, Red Hat Inc., Zhejianger, etc.
> 
> Current: Kernel Associate Quality Engineer @ Red Hat Inc.
> 
> Home Page: http://www.CasparZhang.com/

-- 
/---------------------------------------\
| Name: Caspar Zhang                    |
| Team: Kernel-QE                       |
| Timezone: GMT+0800 (Asia/Shanghai)    |
| IRC: caspar @ #kernel-qe, #eng-china  |
| Phone: +86-10-6260-8150               |
| Cellphone: +86-1381-073-0090          |
\---------------------------------------/

------=_Part_8669_714914153.1283767973567
Content-Type: text/x-patch; charset=US-ASCII;
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

	Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh	2010-04-01 14:23:11.000000000 +0800
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh	2010-04-28 14:23:42.505422152 +0800
@@ -43,6 +43,23 @@
      exit 1;
 fi
 
+# Since some automated testing systems have no tty while testing,
+# comment this line in /etc/sudoers to avoid the error message:
+# `sudo: sorry, you must have a tty to run sudo'
+# Use trap to restore this line after program terminates.
+pattern="[[:space:]]*Defaults[[:space:]]*requiretty.*"
+if grep -q "^${pattern}" /etc/sudoers; then
+	echo "${TEST_PROG} 0 INFO : Comment requiretty in /etc/sudoers for automated testing systems"
+	sed -E -i"" -e "s/^($pattern)/#\1/" /etc/sudoers
+	trap 'trap "" EXIT; teardown' EXIT
+fi
+
+teardown()
+{
+	echo "${TEST_PROG} 0 INFO : Restore requiretty in /etc/sudoers"
+	sed -E -i"" -e "s/^#($pattern)/\1/" /etc/sudoers
+}
+
 # Summary counters of all test results
 
 test_num=0

------=_Part_8669_714914153.1283767973567
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
------=_Part_8669_714914153.1283767973567
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_8669_714914153.1283767973567--

