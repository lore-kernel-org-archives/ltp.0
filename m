Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526B0C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:04:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C57173C8A7D
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 09:04:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 920FE3C1841
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 09:04:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 87DE72009D0
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 09:04:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639382646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=7MjVbBLMCq7RKS9rR7x87Aw+XTDvHcYV1JGFFu4egp4=;
 b=XdclBpDH18lg/f1PQrqsBFYZxuL4Avfw8o7Jtq4ZQbcp7LotWZIRr8gE3ZupKZrNEhPiok
 cLRz3h4r/sdhCPopDGTWb3424RFt3Y5VWFejAogEchTVMJH/GSzt0GZMzctjA1DG1boPGG
 bXRgvCs3KU4f82+/IqV0A78qZU4Jq88=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-9Joo8YFsN4mCq2MJCpO62Q-1; Mon, 13 Dec 2021 03:04:04 -0500
X-MC-Unique: 9Joo8YFsN4mCq2MJCpO62Q-1
Received: by mail-yb1-f199.google.com with SMTP id
 y17-20020a2586d1000000b005f6596e8760so28896685ybm.17
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 00:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=7MjVbBLMCq7RKS9rR7x87Aw+XTDvHcYV1JGFFu4egp4=;
 b=Gbnofatkg/ZVkouvAUQvtipXsY6oUo8NbGAn5PwcYa2evnIwWPg0Dtja7L0eodkHsz
 q9Te7zwr5Olz0s6ELjwb2ThDAI5R2vSrDMOG2uZxAzdNKk2h1/WsfEVBg8s3A3mC888f
 4VNGxHsH/nZEvfsEXafBFgrncWLZJU8Trh17HP8GsU8ac/bYVQ1WlAEvdCU7U0WlX3b/
 Wqp12vjcLYFqG35MjQ9HLZDeNJEWccSheKNoM+ZdV9jKC5rcimwZuy80vqsF/blLhNxB
 tK8LmhGEVjh2Z97AMHGJUNk4eoSRSr45hUAcXiY933BYSgoELKgmmVUQvepZYbjGfhkO
 9hHA==
X-Gm-Message-State: AOAM532PKXhgNd8PkWKqG4HtJxlxCp+Rn2rGOjc96wHWSKFEyXbJlCyq
 xmMHKjZmxPEcP552iZvRhhhF8GjsZJacGrXqrKP3UL+3AAjNm4ktZVeoFBNd7ItLY50BYdB1EId
 u8hP2pbeufYHbQdf92vDNprtgdGA=
X-Received: by 2002:a25:808c:: with SMTP id n12mr32807214ybk.71.1639382643342; 
 Mon, 13 Dec 2021 00:04:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTA1rvMNRgScTAHJ1L/2KCdQ3fVh44fbwlvEmhVQaBT7E6NTTPX+WZun1sanIxXKgbuziIHaoWTN0ex6ckH+U=
X-Received: by 2002:a25:808c:: with SMTP id n12mr32807175ybk.71.1639382642896; 
 Mon, 13 Dec 2021 00:04:02 -0800 (PST)
MIME-Version: 1.0
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Dec 2021 16:03:50 +0800
Message-ID: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] enable OOM protection for the library and test process?
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0338649904=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0338649904==
Content-Type: multipart/alternative; boundary="00000000000014ce6a05d302847d"

--00000000000014ce6a05d302847d
Content-Type: text/plain; charset="UTF-8"

Hi All,

As we observed that oom tests occasionally ended with TBROK (Test killed)
on small
RAM system, the reason seems test process(test_pid) get killed early than
the expected
victim process so that can't report the status correctly.

I'm thinking maybe we can purposely make the OOM ignore test
process(test_pid)
and the main process? (achieve this only in mem library for OOM test)

e.g.

set oom_score_adj to -1000 for pid-305071 and main-process

oom03:
main ---> tst_run_tcases --> ... --> fork_testrun
   (pid 305071)    testrun  --> run_tests --> ... --> testoom --> oom()
            (pid 305072)    child_alloc --> child_alloc_thread --> alloc_mem


=============

3 cmdline="oom03"
...
10 mem.c:218: TINFO: start normal OOM testing.
11 mem.c:140: TINFO: expected victim is 305072.

12 mem.c:39: TINFO: thread (7fe173d1a700), allocating 3221225472 bytes.
13 mem.c:39: TINFO: thread (7fe173d1a700), allocating 3221225472 bytes.

14 tst_test.c:1410: TINFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
15 tst_test.c:1411: TBROK: Test killed! (timeout?)

==========

[ 1117.558867] Tasks state (memory values in pages):
[ 1117.559373] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
swapents oom_score_adj name
[ 1117.560167] [ 305071]     0 305071     2215       31    61440        4
          0 oom03
[ 1117.560889] [ 305072]     0 305072 1577128 259389 10326016 1019452 0
oom03
...

[ 1117.596510]
oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/ltp/test-305071,task_memcg=/ltp/test-305071,task=oom03,pid=305071,uid=0

[ 1117.597963] Memory cgroup out of memory: Killed process 305071 (oom03)
total-vm:8860kB, anon-rss:124kB, file-rss:0kB, shmem-rss:0kB, UID:0
pgtables:60kB oom_score_adj:0

=============

# free -h
              total        used        free      shared  buff/cache
available
Mem:          3.6Gi       270Mi       2.3Gi        18Mi       1.1Gi
3.3Gi
Swap:         4.0Gi          0B       4.0Gi

# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              2
On-line CPU(s) list: 0,1
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           2
NUMA node(s):        1


-- 
Regards,
Li Wang

--00000000000014ce6a05d302847d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Hi =
All,</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div>=
<div class=3D"gmail_default" style=3D"font-size:small">As we observed that =
oom tests occasionally ended with TBROK (Test killed) on small</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">RAM system, the reason seem=
s test process(test_pid)=C2=A0get killed early=C2=A0than the expected</div>=
<div class=3D"gmail_default" style=3D"font-size:small">victim process so th=
at can&#39;t report the status correctly.</div><div class=3D"gmail_default"=
 style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"=
font-size:small">I&#39;m thinking maybe we can purposely make the OOM ignor=
e test process(test_pid)</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">and the main process? (achieve this only in mem library for OOM t=
est)</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div>=
<div class=3D"gmail_default" style=3D"font-size:small">e.g.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">set oom_score_adj to -1000 for pid-30507=
1 and main-process</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll"><br></div><div class=3D"gmail_default" style=3D"font-size:small">oom03:=
</div><div class=3D"gmail_default" style=3D"font-size:small">main ---&gt; t=
st_run_tcases --&gt; ... --&gt; fork_testrun=C2=A0</div><div class=3D"gmail=
_default" style=3D"font-size:small">=C2=A0 =C2=A0(pid 305071)=C2=A0 =C2=A0 =
testrun=C2=A0 --&gt; run_tests --&gt; ... --&gt; testoom --&gt; oom()</div>=
<div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (pid 305072)=C2=A0 =C2=A0 child_alloc --&gt; child_al=
loc_thread --&gt; alloc_mem</div><div class=3D"gmail_default" style=3D"font=
-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0</div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"><=
/div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div><br>3 cmdline=
=3D&quot;oom03&quot;<br><span class=3D"gmail_default" style=3D"font-size:sm=
all"></span>...<br>10 mem.c:218: TINFO: start normal OOM testing. =C2=A0 =
=C2=A0<br>11 mem.c:140: TINFO: expected victim is 305072.<br><br>12 mem.c:3=
9: TINFO: thread (7fe173d1a700), allocating 3221225472 bytes.<br>13 mem.c:3=
9: TINFO: thread (7fe173d1a700), allocating 3221225472 bytes.<br><br>14 tst=
_test.c:1410: TINFO: If you are running on slow machine, try exporting LTP_=
TIMEOUT_MUL &gt; 1<br>15 tst_test.c:1411: TBROK: Test killed! (timeout?)<br=
><div><br></div><div class=3D"gmail_default" style=3D"font-size:small">=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><br>[ 1117.558867] Tasks state (memory val=
ues in pages):<br>[ 1117.559373] [ =C2=A0pid =C2=A0] =C2=A0 uid =C2=A0tgid =
total_vm =C2=A0 =C2=A0 =C2=A0rss pgtables_bytes swapents oom_score_adj name=
</div><div>[ 1117.560167] [ 305071] =C2=A0 =C2=A0 0 305071 =C2=A0 =C2=A0 22=
15 =C2=A0 =C2=A0 =C2=A0 31 =C2=A0 =C2=A061440 =C2=A0 =C2=A0 =C2=A0 =C2=A04 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 oom03 =C2=A0<br>[ 1117.560889] =
[ 305072] <span class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =
=C2=A0 </span>0 305072 1577128 259389 10326016 1019452 0 oom03<br>...</div>=
<div><br>[ 1117.596510] oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(=
null),cpuset=3D/,mems_allowed=3D0,oom_memcg=3D/ltp/test-305071,task_memcg=
=3D/ltp/test-305071,task=3Doom03,pid=3D305071,uid=3D0 =C2=A0<br>[ 1117.5979=
63] Memory cgroup out of memory: Killed process 305071 (oom03) total-vm:886=
0kB, anon-rss:124kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:60kB oom_s=
core_adj:0<div><br></div><div><div class=3D"gmail_default" style=3D"font-si=
ze:small">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div class=3D"gmail_=
default"><br></div><div class=3D"gmail_default"># free -h<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total =C2=A0 =C2=A0 =C2=A0 =C2=A0used =
=C2=A0 =C2=A0 =C2=A0 =C2=A0free =C2=A0 =C2=A0 =C2=A0shared =C2=A0buff/cache=
 =C2=A0 available<br>Mem: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.6Gi =C2=A0 =
=C2=A0 =C2=A0 270Mi =C2=A0 =C2=A0 =C2=A0 2.3Gi =C2=A0 =C2=A0 =C2=A0 =C2=A01=
8Mi =C2=A0 =C2=A0 =C2=A0 1.1Gi =C2=A0 =C2=A0 =C2=A0 3.3Gi<br>Swap: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 4.0Gi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00B =C2=A0 =C2=
=A0 =C2=A0 4.0Gi<br></div><div class=3D"gmail_default"><br></div><div class=
=3D"gmail_default"># lscpu <br>Architecture: =C2=A0 =C2=A0 =C2=A0 =C2=A0x86=
_64<br>CPU op-mode(s): =C2=A0 =C2=A0 =C2=A032-bit, 64-bit<br>Byte Order: =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Little Endian<br>CPU(s): =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>On-line CPU(s) list: 0,1<br>Thread(s=
) per core: =C2=A01<br>Core(s) per socket: =C2=A01<br>Socket(s): =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 2<br>NUMA node(s): =C2=A0 =C2=A0 =C2=A0 =C2=A01<br=
></div><br></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_sign=
ature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br=
></div><div>Li Wang<br></div></div></div></div></div>

--00000000000014ce6a05d302847d--


--===============0338649904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0338649904==--

