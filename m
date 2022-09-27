Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075DAC6FA86
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 07:44:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 077F33CAE10
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 09:44:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 613513CAB07
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 09:44:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1CFB0600082
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 09:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664264667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/C7W0HfgyfaIDH9vpnzVo7QgYSA9yQ/JOjcdbFe+fSM=;
 b=F0GJdG1mSChxuWw9eSGsep5VdTABriqJzP8WH0rMcBrzN5HvirRIqPqzMiW2WLd5S4daZO
 99nE8HwDZ8AsGww1MK6mc9EHflJi3uGTYdsfgMAZkNCiRIdcrMOAIn2GLHklpo/ZBRtS9p
 4C6qdh9DkJsww55yqw82sNMPK40txO0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-92-fGKI6-NQNoWcxky3-MCnpQ-1; Tue, 27 Sep 2022 03:44:26 -0400
X-MC-Unique: fGKI6-NQNoWcxky3-MCnpQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 h22-20020adfa4d6000000b0022cbee47920so272397wrb.6
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 00:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=aeaZ/lbl6L2nJ4IS11rHe4iODxsJbYtyKtZZOis+O1A=;
 b=Grls2zO13+tuO4Q/OywdpwwMfSoft7rkFTOD4ma6haF+JeI0IBW/EkYmM45D+tmi7v
 kHlH7/fMuKLbl5ofgd+R3PIy7n+1ChEV5+kHlURTcSbLYGbXIQpquGkaOHTJyLPjWiio
 TIq8tVI6oy0+goYOuZ7fhkN7p+/SE5LHYcg9Ae1OUR5aWb57QMfejIP7DvoTw1auOaqF
 F1BVKA5PgxkkNGPCO9PQBMNMFFBxcmunNs7umXJ5iNrEQ7ebIqSyIEGGOV7TZaBeIddh
 eAauqSUO6S67KrF0JbIrF2mGLxN7GukIurY19Si3vwEALIcCKHzdSOOwx7y9Kz8ajJkz
 aA6Q==
X-Gm-Message-State: ACrzQf20leEuyEq4tVhgOH3o9B9K8MMG3R09G1hcshEymzRROQ145yyX
 LbCTHq7Ncfq3Vw1UGfU/QjVQ5cj0Xy/cqZY0HpBf+ca9wmVuyaXIqNDBz64CNe8GeQYG5EX+J7S
 qVuuE74wubFcnMaUhHOJBDJZ+WBk=
X-Received: by 2002:adf:d22f:0:b0:22c:c151:45d9 with SMTP id
 k15-20020adfd22f000000b0022cc15145d9mr533974wrh.316.1664264663665; 
 Tue, 27 Sep 2022 00:44:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7m907eoxTypudJfYohKrkZ/ISSFL2QfFioWGqJOsTqIzm5yfOMv1zYuGyockRGKoPok1EznbvBwCnXjER6/io=
X-Received: by 2002:adf:d22f:0:b0:22c:c151:45d9 with SMTP id
 k15-20020adfd22f000000b0022cc15145d9mr533963wrh.316.1664264663390; Tue, 27
 Sep 2022 00:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <Yxr+EpKTnKQbKXTb@yuki>
 <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
 <YxsfGUpRLAx6uIU7@yuki> <YxtPfXA6I64lS2oK@pevik>
 <CAEemH2eNjP++fxhP5ZSsX+fq5vAd6h0_qNX6Rx82AdpzN9fyGQ@mail.gmail.com>
 <YzF3wLk9cMTdU1z7@yuki>
 <CAEemH2feEgX1oiTPD=_ub0Dc-5RTyKqVhSX0QrMAJPTo-0Gdhg@mail.gmail.com>
In-Reply-To: <CAEemH2feEgX1oiTPD=_ub0Dc-5RTyKqVhSX0QrMAJPTo-0Gdhg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Sep 2022 15:44:11 +0800
Message-ID: <CAEemH2e6Dzm1ydZt1VZvoxZN4xXyrSZua5jmfxeci8SyXNc2tw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1075123942=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1075123942==
Content-Type: multipart/alternative; boundary="00000000000012f52205e9a3d0ea"

--00000000000012f52205e9a3d0ea
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 26, 2022 at 6:13 PM Li Wang <liwang@redhat.com> wrote:


> > 1. Collecting the patch list for a new release, like this email does
>> (Cyril)
>> >
>> > 2. Reviewing and merging the patch list of step1 (All maintainers,
>> > LTP-users)
>> >
>> > 3. Pre-release widely testing, we need to explicitly post results in
>> step1
>> > email (Petr, Li Wang)
>> >
>> > 4. Tiny fix according to pre-release testing result (All maintainers,
>> users)
>> >
>> > 5. Writing release note (Cyril)
>> >
>> > 6. Uploading tarballs (Petr)
>> >
>> > 7. Announcement email of LTP release (Cyril)
>>
>> Lets move on with the plannig, I would say that we are done with step 2.
>> and we should move to step 3.
>
>
Pre-release testing briefly summary:

RHEL8 and RHEL9:
The latest LTP test is pretty good (only reports three kernel known issues).

Upstream kernel-v6.0-rc5:
1. readahead02 still occasionally timed out with a slower IO machine
(ppc64le)

    ...
    37	readahead02.c:295: TPASS: readahead saved some I/O
    38	readahead02.c:303: TINFO: cache can hold at least: 264320 kB
    39	readahead02.c:304: TINFO: read_testfile(0) used cache: 131968 kB
    40	readahead02.c:305: TINFO: read_testfile(1) used cache: 62400 kB
    41	readahead02.c:313: TPASS: using cache as expected
    42	readahead02.c:223: TINFO: Test #2: POSIX_FADV_WILLNEED on file
    43	readahead02.c:128: TINFO: creating test file of size: 67108864
    44	readahead02.c:242: TINFO: read_testfile(0)
    45	readahead02.c:253: TINFO: read_testfile(1)
    46	readahead02.c:177: TINFO: readahead calls made: 32
    47	readahead02.c:183: TPASS: offset is still at 0 as expected
    48	Test timeouted, sending SIGKILL!
    49	tst_test.c:1577: TINFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
    50	tst_test.c:1579: TBROK: Test killed! (timeout?)


2. df01 got strange failures on XFS (I was unable to reproduce it manually)

    71 df01 37 TINFO: === Testing on xfs ===
    72 df01 37 TINFO: Formatting xfs with opts='/dev/loop0'
    73 df01 37 TINFO: Mounting device: mount -t xfs /dev/loop0
/mnt/testarea/ltp-pgxzTJRwdG/LTP_df01.IFAhWHNrYb/mntpoint
    74 df01 37 TINFO: timeout per run is 0h 10m 0s
    75 df01 37 TPASS: 'df -P' passed.
    76 total: 301728, used: 17736
    77 df saved output:
   ...
   135 df01 38 TFAIL: 'df -a -P' failed, not expected.
   136 df01 39 TPASS: 'df -i -P' passed.
   ...
   160 df01 40 TFAIL: 'df -k -P' failed, not expected.
   161 df01 41 TPASS: 'df -t xfs -P' passed.
   ...
   185 df01 42 TFAIL: 'df -T -P' failed, not expected.
   186 df01 43 TPASS: 'df -v /dev/loop0 -P' passed.
   187 df01 44 TPASS: 'df -h' passed.
   188 df01 45 TPASS: 'df -H' passed.
   189 df01 46 TPASS: 'df -m' passed.
   190 df01 47 TPASS: 'df --version' passed.
   191 df01 48 TPASS: 'df -x xfs -P' passed.

3. two io_uring test hit memory permission denied issue (on all arches)

     7	tst_buffers.c:55: TINFO: Test is using guarded buffers
     8	tst_test.c:1526: TINFO: Timeout per run is 0h 01m 00s
     9	io_uring01.c:80: TPASS: io_uring_setup() passed
    10	io_uring01.c:89: TBROK: mmap((nil),388,3,32769,3,0) failed: EACCES (13)


     7	tst_test.c:1526: TINFO: Timeout per run is 0h 01m 00s
     8	io_uring02.c:213: TBROK: mmap((nil),19072,3,32769,5,0) failed:
EACCES (13)


-- 
Regards,
Li Wang

--00000000000012f52205e9a3d0ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 26, 2022 at 6:13 PM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt; w=
rote:<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
&gt; 1. Collecting the patch list for a new release, like this email does (=
Cyril)<br>
&gt; <br>
&gt; 2. Reviewing and merging the patch list of step1 (All maintainers,<br>
&gt; LTP-users)<br>
&gt; <br>
&gt; 3. Pre-release widely testing, we need to explicitly post results in s=
tep1<br>
&gt; email (Petr, Li Wang)<br>
&gt; <br>
&gt; 4. Tiny fix according to pre-release testing result (All maintainers, =
users)<br>
&gt; <br>
&gt; 5. Writing release note (Cyril)<br>
&gt; <br>
&gt; 6. Uploading tarballs (Petr)<br>
&gt; <br>
&gt; 7. Announcement email of LTP release (Cyril)<br>
<br>
Lets move on with the plannig, I would say that we are done with step 2.<br=
>
and we should move to step 3.</blockquote></div></div></blockquote><div><br=
></div><div class=3D"gmail_default" style=3D"font-size:small">Pre-release t=
esting briefly summary:</div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">R=
HEL8 and RHEL9:</div><div class=3D"gmail_default" style=3D"font-size:small"=
>The latest LTP test is pretty good (only reports three kernel known issues=
).</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:small">Upstream kernel-v6.0-r=
c5:</div><div class=3D"gmail_default" style=3D"font-size:small">1. readahea=
d02 still occasionally timed out=C2=A0with a slower IO machine (ppc64le)</d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><pre style=3D"col=
or:rgb(0,0,0);white-space:pre-wrap">    ...
    37=09readahead02.c:295: TPASS: readahead saved some I/O
    38=09readahead02.c:303: TINFO: cache can hold at least: 264320 kB
    39=09readahead02.c:304: TINFO: read_testfile(0) used cache: 131968 kB
    40=09readahead02.c:305: TINFO: read_testfile(1) used cache: 62400 kB
    41=09readahead02.c:313: TPASS: using cache as expected
    42=09readahead02.c:223: TINFO: Test #2: POSIX_FADV_WILLNEED on file
    43=09readahead02.c:128: TINFO: creating test file of size: 67108864
    44=09readahead02.c:242: TINFO: read_testfile(0)
    45=09readahead02.c:253: TINFO: read_testfile(1)
    46=09readahead02.c:177: TINFO: readahead calls made: 32
    47=09readahead02.c:183: TPASS: offset is still at 0 as expected
    48=09Test timeouted, sending SIGKILL!
    49=09tst_test.c:1577: TINFO: If you are running on slow machine, try ex=
porting LTP_TIMEOUT_MUL &gt; 1
    50=09tst_test.c:1579: TBROK: Test killed! (timeout?)</pre></div><div>=
=C2=A0</div><div><div class=3D"gmail_default" style=3D"font-size:small">2. =
df01 got strange failures on XFS (I was unable to reproduce it manually)</d=
iv></div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><=
div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 71=09df=
01 37 TINFO: =3D=3D=3D Testing on xfs =3D=3D=3D=C2=A0 =C2=A0 <br>=C2=A0 =C2=
=A0 72=09df01 37 TINFO: Formatting xfs with opts=3D&#39;/dev/loop0&#39;<br>=
=C2=A0 =C2=A0 73=09df01 37 TINFO: Mounting device: mount -t xfs /dev/loop0 =
/mnt/testarea/ltp-pgxzTJRwdG/LTP_df01.IFAhWHNrYb/mntpoint<br>=C2=A0 =C2=A0 =
74=09df01 37 TINFO: timeout per run is 0h 10m 0s<br>=C2=A0 =C2=A0 75=09df01=
 37 TPASS: &#39;df -P&#39; passed.<br>=C2=A0 =C2=A0 76=09total: 301728, use=
d: 17736<br>=C2=A0 =C2=A0 77=09df saved output:<br>=C2=A0 =C2=A0... =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>=C2=A0 =C2=A0135=09df01 38 TFAIL: &#3=
9;df -a -P&#39; failed, not expected.<br>=C2=A0 =C2=A0136=09df01 39 TPASS: =
&#39;df -i -P&#39; passed.<br>=C2=A0 =C2=A0...<br>=C2=A0 =C2=A0160=09df01 4=
0 TFAIL: &#39;df -k -P&#39; failed, not expected.<br>=C2=A0 =C2=A0161=09df0=
1 41 TPASS: &#39;df -t xfs -P&#39; passed.<br>=C2=A0 =C2=A0...<br>=C2=A0 =
=C2=A0185=09df01 42 TFAIL: &#39;df -T -P&#39; failed, not expected.<br>=C2=
=A0 =C2=A0186=09df01 43 TPASS: &#39;df -v /dev/loop0 -P&#39; passed.<br>=C2=
=A0 =C2=A0187=09df01 44 TPASS: &#39;df -h&#39; passed.<br>=C2=A0 =C2=A0188=
=09df01 45 TPASS: &#39;df -H&#39; passed.<br>=C2=A0 =C2=A0189=09df01 46 TPA=
SS: &#39;df -m&#39; passed.<br>=C2=A0 =C2=A0190=09df01 47 TPASS: &#39;df --=
version&#39; passed.<br>=C2=A0 =C2=A0191=09df01 48 TPASS: &#39;df -x xfs -P=
&#39; passed.<br></div><div class=3D"gmail_default" style=3D"font-size:smal=
l"><br></div><div class=3D"gmail_default" style=3D"font-size:small">3. two =
io_uring test hit memory permission denied issue (on all arches)</div><div =
class=3D"gmail_default" style=3D"font-size:small"><pre style=3D"color:rgb(0=
,0,0);white-space:pre-wrap"><div class=3D"gmail_default" style=3D"color:rgb=
(34,34,34);font-family:Arial,Helvetica,sans-serif;white-space:normal"><pre =
style=3D"color:rgb(0,0,0);white-space:pre-wrap"><pre style=3D"white-space:p=
re-wrap">     7=09tst_buffers.c:55: TINFO: Test is using guarded buffers
     8=09tst_test.c:1526: TINFO: Timeout per run is 0h 01m 00s
     9=09io_uring01.c:80: TPASS: io_uring_setup() passed
    10=09io_uring01.c:89: TBROK: mmap((nil),388,3,32769,3,0) failed: EACCES=
 (13)</pre><pre style=3D"white-space:pre-wrap"><br></pre></pre></div><div c=
lass=3D"gmail_default" style=3D"color:rgb(34,34,34);font-family:Arial,Helve=
tica,sans-serif;white-space:normal"><pre style=3D"color:rgb(0,0,0);white-sp=
ace:pre-wrap"><pre style=3D"white-space:pre-wrap">     7=09tst_test.c:1526:=
 TINFO: Timeout per run is 0h 01m 00s
     8=09io_uring02.c:213: TBROK: mmap((nil),19072,3,32769,5,0) failed: EAC=
CES (13)</pre></pre></div></pre></div></div><div><br></div>-- <br><div dir=
=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></di=
v></div></div>

--00000000000012f52205e9a3d0ea--


--===============1075123942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1075123942==--

