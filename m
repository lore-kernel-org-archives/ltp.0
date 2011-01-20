Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <green.hu@gmail.com>) id 1Pfr1J-0003Y2-Az
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 09:41:33 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1Pfr1I-0001Wf-1L
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 09:41:33 +0000
Received: by fxm17 with SMTP id 17so389884fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Jan 2011 01:41:25 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 20 Jan 2011 17:41:25 +0800
Message-ID: <AANLkTikm9cgL0w6WF+D_=GRLb1Wd8wdW_90f0T7SkSAW@mail.gmail.com>
From: GreenTime <green.hu@gmail.com>
Subject: [LTP]  [PATCH] mmap03 to support NDS32 cpu
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5987621519973487556=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5987621519973487556==
Content-Type: multipart/alternative; boundary=20cf3054a457e524f2049a43efb4

--20cf3054a457e524f2049a43efb4
Content-Type: text/plain; charset=ISO-8859-1

Hi Garrett,

I add a new cpu macro __NDS32__ in mmap03 for it to pass.

    Signed-off-by: Greentime <green.hu@gmail.com>
---
 testcases/kernel/syscalls/mmap/mmap03.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap03.c
b/testcases/kernel/syscalls/mmap/mmap03.c
index 98e3c69..433f563 100644
--- a/testcases/kernel/syscalls/mmap/mmap03.c
+++ b/testcases/kernel/syscalls/mmap/mmap03.c
@@ -168,7 +168,7 @@ int main(int ac, char **av)
                                                 "correct");
                                }
                        }
-#if defined(__ia64__) || defined(__hppa__)
+#if defined(__ia64__) || defined(__hppa__) || defined(__NDS32__)
                        if (pass) {
                                tst_resm(TPASS, "Got SIGSEGV as expected");
                        } else {

--20cf3054a457e524f2049a43efb4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<pre>Hi Garrett,<br><br>I add a new cpu macro __NDS32__ in mmap03 for it to=
 pass.<br><br>    Signed-off-by: Greentime &lt;<a href=3D"http://green.hu">=
green.hu</a>@<a href=3D"http://gmail.com">gmail.com</a>&gt;<br>---<br> test=
cases/kernel/syscalls/mmap/mmap03.c |    2 +-<br>
 1 files changed, 1 insertions(+), 1 deletions(-)<br><br>diff --git a/testc=
ases/kernel/syscalls/mmap/mmap03.c b/testcases/kernel/syscalls/mmap/mmap03.=
c<br>index 98e3c69..433f563 100644<br>--- a/testcases/kernel/syscalls/mmap/=
mmap03.c<br>
+++ b/testcases/kernel/syscalls/mmap/mmap03.c<br>@@ -168,7 +168,7 @@ int ma=
in(int ac, char **av)<br>                                                 &=
quot;correct&quot;);<br>                                }<br>              =
          }<br>
-#if defined(__ia64__) || defined(__hppa__)<br>+#if defined(__ia64__) || de=
fined(__hppa__) || defined(__NDS32__)<br>                        if (pass) =
{<br>                                tst_resm(TPASS, &quot;Got SIGSEGV as e=
xpected&quot;);<br>
                        } else {<br><br></pre>

--20cf3054a457e524f2049a43efb4--


--===============5987621519973487556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
--===============5987621519973487556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5987621519973487556==--

