Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangli5665@gmail.com>) id 1WFhMZ-0002qx-Td
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 09:53:15 +0000
Received: from mail-ob0-f193.google.com ([209.85.214.193])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WFhMY-0005iH-04
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 09:53:15 +0000
Received: by mail-ob0-f193.google.com with SMTP id wn1so5749850obc.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Feb 2014 01:53:08 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 18 Feb 2014 17:53:08 +0800
Message-ID: <CAE1O6mgK+w6s5gnRhe7NaadGngw0k3bmNfc_LAzDvfbeEiQR_A@mail.gmail.com>
From: Levi Wang <wangli5665@gmail.com>
Subject: [LTP] LTP cron test fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8250061338090454921=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8250061338090454921==
Content-Type: multipart/alternative; boundary=089e0149cd5e4d124d04f2ab3d62

--089e0149cd5e4d124d04f2ab3d62
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Hi all,

I met the cron fails problem when running LTP test on RHEL-7.0

------------+------------------+------------------+-----------------------

<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D3 cstime=3D9
<<<test_end>>>
<<<test_start>>>
tag=3Dcron stime=3D1392701532
cmdline=3D"export TCdat=3D$LTPROOT/testcases/bin; cron_tests.sh"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cron01      0  TINFO  :  Test #1: crontab <filename> installs the crontab f=
ile
cron01      0  TINFO  :  Test #1: cron schedules the job listed in crontab =
file.
cron01      0  TINFO  :  Test #1: Installing cron job ...
cron01      0  TINFO  :  Test #1: Cronjob installed successfully
cron01      0  TINFO  :  Test #1: /var/log/cron: Trying altenate log...
cron01      1  TFAIL  :  Test #1: crontab activity not recorded in
/var/log/messages.
cron01      0  TINFO  :  Test #1: Values are good:
    Expected 35;     Received 35
cron01      0  TINFO  :  Test #1: Values are good:
    Expected 36;     Received 36
cron01      0  TINFO  :  Test #1: Values are good:
    Expected 37;     Received 37
cron01      0  TINFO  :  Test #1: Values are good:
    Expected 38;     Received 38
cron01      0  TINFO  :  Test #1: Values are good:
    Expected 39;     Received 39
cron01      0  TINFO  :  Test #1: /var/log/cron: alternate...
cron01      1  TPASS  :  Test #1: installed cronjob, and cron executed
the cronjob.
cron02      0  TINFO  :  Test #2: crontab -r removes the crontab file.
cron02      0  TINFO  :  Test #2: installing crontab file.
cron02      0  TINFO  :  Test #1: /var/log/cron: alternate...
cron02      2  TFAIL  :  Test #2: crontab activity not recorded in
var/log/messages.
cron02      0  TINFO  :  Test #2: uninstalling crontab file.
cron02      0  TINFO  :  Test #1: /var/log/cron: alternate...
cron02      2  TFAIL  :  Test #2: crontab activity not recorded in
var/log/messages.
cron03      0  TINFO  :  Test #3: crontab -l lists the cronjobs installed
cron03      0  TINFO  :  Test #3: installing crontab file ...
cron03      0  TINFO  :  Test #3: Cron job installed.
cron03      0  TINFO  :  Test #3: crontab -l listed cronjob tst2_cronprg.sh
cron03      0  TINFO  :  Test #3: uninstalling crontab file.
cron03      0  TINFO  :  crontab uninstalled all jobs for user
cron03      3  TPASS  :  crontab did not list any cronjobs

-------------------------+----------------------+-----------------+--------=
----

Hope to know that the issue is belong to LTP case or RHEL7.0.


--------------------+--------------------+------------------+-------------

commands Failed:
Test Start Time: Tue Feb 18 00:32:01 2014
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
ar                             PASS       0
ld                             PASS       0
ldd                            PASS       0
nm                             PASS       0
objdump                        PASS       0
file                           PASS       0
tar                            PASS       0
cron                           FAIL       3
logrotate                      PASS       0
mail                           PASS       0
cpio                           PASS       0
unzip01                        PASS       0
gzip01                         PASS       0
cp_tests01                     PASS       0
ln_tests01                     PASS       0
mkdir_tests01                  PASS       0
mv_tests01                     PASS       0
size01                         PASS       0
sssd01                         PASS       0
sssd02                         PASS       0
sssd03                         PASS       0

-----------------------------------------------
Total Tests: 21
Total Failures: 1



--=20
=CE=D2=D7=DC=CA=C7=B7=C5=B2=BB=CF=C2=C4=C7=B2=CA=BA=E7=B1=DF=C9=CF=B5=C4=C6=
=D9=B2=BC=A3=AC=CF=F1=BC=AB=C1=CB=C4=EA=C9=D9=B7=C9=D7=DF=B5=C4=CA=B1=B9=E2=
...

--089e0149cd5e4d124d04f2ab3d62
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I met the cron fails problem wh=
en running LTP test on RHEL-7.0&nbsp;</div><div><br></div><div>------------=
+------------------+------------------+-----------------------</div><div><p=
re>&lt;&lt;&lt;execution_status&gt;&gt;&gt;
initiation_status=3D&quot;ok&quot;
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D3 cstime=3D9
&lt;&lt;&lt;test_end&gt;&gt;&gt;
&lt;&lt;&lt;test_start&gt;&gt;&gt;
tag=3Dcron stime=3D1392701532
cmdline=3D&quot;export TCdat=3D$LTPROOT/testcases/bin; cron_tests.sh&quot;
contacts=3D&quot;&quot;
analysis=3Dexit
&lt;&lt;&lt;test_output&gt;&gt;&gt;
cron01      0  TINFO  :  Test #1: crontab &lt;filename&gt; installs the cro=
ntab file
cron01      0  TINFO  :  Test #1: cron schedules the job listed in crontab =
file.
cron01      0  TINFO  :  Test #1: Installing cron job ...=20
cron01      0  TINFO  :  Test #1: Cronjob installed successfully
cron01      0  TINFO  :  Test #1: /var/log/cron: Trying altenate log...
cron01      1  TFAIL  :  Test #1: crontab activity not recorded in /var/log=
/messages.
cron01      0  TINFO  :  Test #1: Values are good:=20
    Expected 35;     Received 35
cron01      0  TINFO  :  Test #1: Values are good:=20
    Expected 36;     Received 36
cron01      0  TINFO  :  Test #1: Values are good:=20
    Expected 37;     Received 37
cron01      0  TINFO  :  Test #1: Values are good:=20
    Expected 38;     Received 38
cron01      0  TINFO  :  Test #1: Values are good:=20
    Expected 39;     Received 39
cron01      0  TINFO  :  Test #1: /var/log/cron: alternate...
cron01      1  TPASS  :  Test #1: installed cronjob, and cron executed the =
cronjob.
cron02      0  TINFO  :  Test #2: crontab -r removes the crontab file.
cron02      0  TINFO  :  Test #2: installing crontab file.
cron02      0  TINFO  :  Test #1: /var/log/cron: alternate...
cron02      2  TFAIL  :  Test #2: crontab activity not recorded in var/log/=
messages.
cron02      0  TINFO  :  Test #2: uninstalling crontab file.
cron02      0  TINFO  :  Test #1: /var/log/cron: alternate...
cron02      2  TFAIL  :  Test #2: crontab activity not recorded in var/log/=
messages.
cron03      0  TINFO  :  Test #3: crontab -l lists the cronjobs installed
cron03      0  TINFO  :  Test #3: installing crontab file ...
cron03      0  TINFO  :  Test #3: Cron job installed.
cron03      0  TINFO  :  Test #3: crontab -l listed cronjob tst2_cronprg.sh
cron03      0  TINFO  :  Test #3: uninstalling crontab file.
cron03      0  TINFO  :  crontab uninstalled all jobs for user
cron03      3  TPASS  :  crontab did not list any cronjobs</pre><pre>------=
-------------------+----------------------+-----------------+------------</=
pre><pre>Hope to know that the issue is belong to LTP case or RHEL7.0.</pre=
>
<pre><br></pre><pre>--------------------+--------------------+-------------=
-----+-------------</pre><pre>commands Failed:=20
Test Start Time: Tue Feb 18 00:32:01 2014
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
ar                             PASS       0   =20
ld                             PASS       0   =20
ldd                            PASS       0   =20
nm                             PASS       0   =20
objdump                        PASS       0   =20
file                           PASS       0   =20
tar                            PASS       0   =20
cron                           FAIL       3   =20
logrotate                      PASS       0   =20
mail                           PASS       0   =20
cpio                           PASS       0   =20
unzip01                        PASS       0   =20
gzip01                         PASS       0   =20
cp_tests01                     PASS       0   =20
ln_tests01                     PASS       0   =20
mkdir_tests01                  PASS       0   =20
mv_tests01                     PASS       0   =20
size01                         PASS       0   =20
sssd01                         PASS       0   =20
sssd02                         PASS       0   =20
sssd03                         PASS       0   =20

-----------------------------------------------
Total Tests: 21
Total Failures: 1</pre><pre><br></pre><div><br></div>-- <br>=CE=D2=D7=DC=CA=
=C7=B7=C5=B2=BB=CF=C2=C4=C7=B2=CA=BA=E7=B1=DF=C9=CF=B5=C4=C6=D9=B2=BC=A3=AC=
=CF=F1=BC=AB=C1=CB=C4=EA=C9=D9=B7=C9=D7=DF=B5=C4=CA=B1=B9=E2...
</div></div>

--089e0149cd5e4d124d04f2ab3d62--


--===============8250061338090454921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
--===============8250061338090454921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8250061338090454921==--

