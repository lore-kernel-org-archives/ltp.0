Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangli5665@gmail.com>) id 1WKfpg-0006OH-8i
	for ltp-list@lists.sourceforge.net; Tue, 04 Mar 2014 03:15:52 +0000
Received: from mail-ob0-f193.google.com ([209.85.214.193])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WKfpf-0007V3-FL
	for ltp-list@lists.sourceforge.net; Tue, 04 Mar 2014 03:15:52 +0000
Received: by mail-ob0-f193.google.com with SMTP id gq1so2698251obb.8
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Mar 2014 19:15:46 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 4 Mar 2014 11:15:46 +0800
Message-ID: <CAE1O6mijvWG84ntBC3eep6gStru_WXC_wMayOO0UcsNvsE4v8w@mail.gmail.com>
From: Levi Wang <wangli5665@gmail.com>
Subject: [LTP] LTP mm test fails, may be test case have some unclear problem
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1723287710916698196=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1723287710916698196==
Content-Type: multipart/alternative; boundary=047d7b4724a2f5a0dc04f3bf51f9

--047d7b4724a2f5a0dc04f3bf51f9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi guys,

LTP testing on RHEL-7.0 hit this issue. it's re-emerge not often.

Does anyone know this?


-----[cut here ]----

<<<test_start>>>
tag=3Doom01 stime=3D1392954542
cmdline=3D"oom01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
oom01       0  TINFO  :  set overcommit_memory to 2
oom01       0  TINFO  :  allocating 3221225472 bytes.
oom01       0  TINFO  :  allocating 3221225472 bytes.
oom01       0  TINFO  :  allocating 3221225472 bytes.
oom01       0  TINFO  :  allocating 3221225472 bytes.
oom01       0  TINFO  :  set overcommit_memory to 2
oom01       0  TINFO  :  expected victim is 31115.
oom01       0  TINFO  :  set overcommit_memory to 0
oom01       0  TINFO  :  expected victim is 31135.
oom01       1  TFAIL  :  the victim unexpectedly failed: 9
oom01       0  TINFO  :  set overcommit_memory to 1
oom01       0  TINFO  :  start normal OOM testing.
oom01       0  TINFO  :  expected victim is 31496.
oom01       0  TINFO  :  start OOM testing for mlocked pages.
oom01       0  TINFO  :  expected victim is 31514.
oom01       0  TINFO  :  start OOM testing for KSM pages.
oom01       0  TINFO  :  expected victim is 31525.
oom01       0  TINFO  :  set overcommit_memory to 0
<<<execution_status>>>


according to the console log, all of the oom01 process was killed, but
process 31115 was missing.

----[cut here ]----

[ 4611.722530] [11114]     0 11114    43018      587      87     5020
           0 beah-rhts-task
[ 4611.724547] [11144]     0 11144    28804        0      14       57
           0 runtest
[ 4611.726410] [11182]     0 11182    28867       95      14       34
           0 rhts-test-runne
[ 4611.728430] [11210]     0 11210    27045        0      12       89
           0 make
[ 4611.730235] [30217]     0 30217     2936        1      10       98
           0 runtest.sh
[ 4611.732183] [ 6237]     0  6237    70947        0      36      145
           0 rsyslogd
[ 4611.734079] [16197]     0 16197    31348        1      17       61
           0 anacron
[ 4611.735968] [  972]     0   972     3001        1      10      173
           0 runltp
[ 4611.737869] [ 1089]     0  1089     1852        4       9       29
           0 ltp-pan
[ 4611.739497] [31114]     0 31114     2152       38      10        1
           0 oom01
[ 4611.740944] [31135]     0 31135  3934312  1872550    7647  2037330
           0 oom01
[ 4611.742386] [31495]     0 31495    26973       19      11        0
           0 sleep
[ 4611.743800] Out of memory: Kill process 31135 (oom01) score 932 or
sacrifice child
[ 4611.745158] Killed process 31135 (oom01) total-vm:15737248kB,
anon-rss:7490200kB, file-rss:0kB
[ 4682.545284] oom01 invoked oom-killer: gfp_mask=3D0x280da, order=3D0,
oom_score_adj=3D0

--=20
Regards=EF=BC=8C
Levi Wang
Email: wangli5665@gmail.com

--047d7b4724a2f5a0dc04f3bf51f9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre>Hi guys,</pre><pre>LTP testing on RHEL-7.0 hit this i=
ssue. it&#39;s re-emerge not often.</pre><pre>Does anyone know this?</pre><=
pre><br></pre><pre>-----[cut here ]----</pre><pre>&lt;&lt;&lt;test_start&gt=
;&gt;&gt;
tag=3Doom01 stime=3D1392954542
cmdline=3D&quot;oom01&quot;
contacts=3D&quot;&quot;
analysis=3Dexit
&lt;&lt;&lt;test_output&gt;&gt;&gt;
oom01       0  TINFO  :  set overcommit_memory to 2
oom01       0  TINFO  :  allocating 3221225472 bytes.
oom01       0  TINFO  :  allocating 3221225472 bytes.
oom01       0  TINFO  :  allocating 3221225472 bytes.
oom01       0  TINFO  :  allocating 3221225472 bytes.
oom01       0  TINFO  :  set overcommit_memory to 2
oom01       0  TINFO  :  expected victim is 31115.
oom01       0  TINFO  :  set overcommit_memory to 0
oom01       0  TINFO  :  expected victim is 31135.
oom01       1  TFAIL  :  the victim unexpectedly failed: 9
oom01       0  TINFO  :  set overcommit_memory to 1
oom01       0  TINFO  :  start normal OOM testing.
oom01       0  TINFO  :  expected victim is 31496.
oom01       0  TINFO  :  start OOM testing for mlocked pages.
oom01       0  TINFO  :  expected victim is 31514.
oom01       0  TINFO  :  start OOM testing for KSM pages.
oom01       0  TINFO  :  expected victim is 31525.
oom01       0  TINFO  :  set overcommit_memory to 0
&lt;&lt;&lt;execution_status&gt;&gt;&gt;</pre><div><br></div><div>according=
 to the console log, all of the oom01 process was killed, but process 31115=
 was missing.</div><div><br></div><div>----[cut here ]----</div><div><pre>
[ 4611.722530] [11114]     0 11114    43018      587      87     5020      =
       0 beah-rhts-task=20
[ 4611.724547] [11144]     0 11144    28804        0      14       57      =
       0 runtest=20
[ 4611.726410] [11182]     0 11182    28867       95      14       34      =
       0 rhts-test-runne=20
[ 4611.728430] [11210]     0 11210    27045        0      12       89      =
       0 make=20
[ 4611.730235] [30217]     0 30217     2936        1      10       98      =
       0 runtest.sh=20
[ 4611.732183] [ 6237]     0  6237    70947        0      36      145      =
       0 rsyslogd=20
[ 4611.734079] [16197]     0 16197    31348        1      17       61      =
       0 anacron=20
[ 4611.735968] [  972]     0   972     3001        1      10      173      =
       0 runltp=20
[ 4611.737869] [ 1089]     0  1089     1852        4       9       29      =
       0 ltp-pan=20
[ 4611.739497] [31114]     0 31114     2152       38      10        1      =
       0 oom01=20
[ 4611.740944] [31135]     0 31135  3934312  1872550    7647  2037330      =
       0 oom01=20
[ 4611.742386] [31495]     0 31495    26973       19      11        0      =
       0 sleep=20
[ 4611.743800] Out of memory: Kill process 31135 (oom01) score 932 or sacri=
fice child=20
[ 4611.745158] Killed process 31135 (oom01) total-vm:15737248kB, anon-rss:7=
490200kB, file-rss:0kB=20
[ 4682.545284] oom01 invoked oom-killer: gfp_mask=3D0x280da, order=3D0, oom=
_score_adj=3D0 </pre></div>-- <br><div dir=3D"ltr">Regards=EF=BC=8C<div>Lev=
i Wang</div><div>Email: <a href=3D"mailto:wangli5665@gmail.com" target=3D"_=
blank">wangli5665@gmail.com</a></div>

</div>
</div>

--047d7b4724a2f5a0dc04f3bf51f9--


--===============1723287710916698196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
--===============1723287710916698196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1723287710916698196==--

