Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <luobingjiun@gmail.com>) id 1SjovO-0002oc-TB
	for ltp-list@lists.sourceforge.net; Wed, 27 Jun 2012 09:52:38 +0000
Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SjovJ-0002jp-1Z
	for ltp-list@lists.sourceforge.net; Wed, 27 Jun 2012 09:52:38 +0000
Received: by lbol5 with SMTP id l5so1522379lbo.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jun 2012 02:52:26 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Jun 2012 17:52:26 +0800
Message-ID: <CANysfL_ya=ZMyZyyE__=3T-QTqFniRrj+nHMrNzeaVHMrnmA5A@mail.gmail.com>
From: =?UTF-8?B?576F56eJ6Yie?= <luobingjiun@gmail.com>
Subject: [LTP] crashme:fork12 test may kill other process that is not forked
	child
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
To: ltp-list@lists.sourceforge.net

Dear All,

fork12 test forks as many child process as possible until
the system out of memory. And kernel OOM killer is
triggered to select candidate process to be killed.

fork12 expected one of its forked child process to be chosen,
but what if any other process is chosen. Even the worst,
shell script("/bin/sh") or parent process was chosen to be killed.
No way return and the system really crashed. But this is not
what fork12 wants.

I proposed the solution for this is disable the OOM killer of=A0parent
process and adjust child process's oom_score_adj to 500(or any
other number larger than 0), this purpose just to make child process
can be easily chosen.

Do you have better idea? Thank you.

---------------------------------------------------------------------------=
-----------------

From: Luo,BingJiun <bjluo@faraday-tech.com>
---
 .../testcases/kernel/syscalls/fork/fork12.c        |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/ltp-full-20120401/testcases/kernel/syscalls/fork/fork12.c
b/ltp-full-20120401/testcases/kernel/syscalls/fork/fork12.c
index d052fba..c3d7cb5 100644
--- a/ltp-full-20120401/testcases/kernel/syscalls/fork/fork12.c
+++ b/ltp-full-20120401/testcases/kernel/syscalls/fork/fork12.c
@@ -63,6 +63,7 @@ int main(int ac, char **av)
        int ret, status;
        int lc;                 /* loop counter */
        char *msg;              /* message returned from parse_opts */
+       char cmd[40];

        /*
         * parse standard options
@@ -76,6 +77,11 @@ int main(int ac, char **av)
         */
        setup();

+       /* adjust parent process so not be killed when out of memory */
+       sprintf(cmd,"echo -1000 > /proc/%d/oom_score_adj", getppid());
+       printf("%s\n", cmd);
+       system(cmd);
+
        /*
         * check looping state if -i option is given
         */
@@ -92,6 +98,9 @@ int main(int ac, char **av)
                                pause();
                                exit(0);
                        }
+                       /* adjust child process so it is killed first
when out of memory */
+                       sprintf(cmd,"echo 500 > /proc/%d/oom_score_adj", pi=
d1);
+                       system(cmd);
                        forks++;
                        ret =3D waitpid(-1, &status, WNOHANG);
                        if (ret < 0)
-- =

1.7.0.4



Best Regards,
Bing-Jiun

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
