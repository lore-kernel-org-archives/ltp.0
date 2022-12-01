Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A8CC43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 06:01:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E66A3CC47C
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 07:01:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83F923CC455
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 07:01:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3847D1A00CD8
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 07:00:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669874458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6bBQ+ihPDvGVLZWPfQo7EU07aUrK/F6o34+LA9u4TTs=;
 b=gbUh8b3tXJwor2XEkrqMvYzY+3bfujcZOfzXwcqJwXELOk6MIrT9ZH7Zh90m85mPgxrsDc
 6OAdxDPosaNwoemimHwtj48UwgKhofzHAL1/RCGsYel/8rb49w8LfO9go7mjpHPk+PKFCK
 EQNkq/pnkp0lcgS2WQBEGrLXe9MBF2s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-343-63BRbGUrOVWnlLunSyYWqA-1; Thu, 01 Dec 2022 01:00:56 -0500
X-MC-Unique: 63BRbGUrOVWnlLunSyYWqA-1
Received: by mail-wm1-f72.google.com with SMTP id
 l42-20020a05600c1d2a00b003cf8e70c1ecso2055953wms.4
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 22:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bBQ+ihPDvGVLZWPfQo7EU07aUrK/F6o34+LA9u4TTs=;
 b=ZyPbmYu3wYf8arwlE8ewWgUyUb59lZh4hG9+XOmXrdXMSbvpDOP3QztzXWUJ6mCIPd
 AhxxSC2cxUEzOY1THv77JTqjQS1S/vqV7UdP0qGe99IgzqrOmDSop5nwUlZjNm6L6yge
 XTYVomTv9rtYtmhz3GW7XeowlUcJTa98GMABKDnWUU0CmoTcIXXuI/Gt9VYUk8HTBkKK
 /xaCPvfwiSCROQ1bD5WfVlydg7obEpwWuiPM85m07Y/kxeURpcAP+LAz+UoWMoxbf6et
 Nf28zSVMfdVeEmuJSJbCOSdyFxKiDT37j/3dxWjBRgM4HDV7GtV+E1crO19xExWuv9lQ
 3/hQ==
X-Gm-Message-State: ANoB5pneteEGVPnKdbIOHJkqj/yYS3Lb/LkIO9QaGAEyRfRgC6lq78Aj
 rouZt3KYEBB43ZWkMa6+VkSt2tUJ1of6lfm7N004Q987qVJ7i5XG7lzNa5HsZFzp4TOSU74Sjf8
 aQ08GzjZ/s9pm7CqZT+oOsZEstzU=
X-Received: by 2002:adf:fa12:0:b0:242:1c:7507 with SMTP id
 m18-20020adffa12000000b00242001c7507mr20664235wrr.42.1669874454700; 
 Wed, 30 Nov 2022 22:00:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5lOtvkH3UbnnV5uLabQCUNM3qsoM1Ql8k8+bCtpH1BdMPpp6wQ2XoImsv5eK2hwcp+ldkvtXvViIEyrjM1f3w=
X-Received: by 2002:adf:fa12:0:b0:242:1c:7507 with SMTP id
 m18-20020adffa12000000b00242001c7507mr20664227wrr.42.1669874454487; 
 Wed, 30 Nov 2022 22:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20221124114204.990-1-akumar@suse.de>
 <CAEemH2eVctJWX8AehwFDa0aorAyM_c+yabnB8zbwDoTUaVQLyg@mail.gmail.com>
 <87r0xmt3ts.fsf@suse.de>
 <CAEemH2dErC+9-UawDMdYq=rCnHOE7ciU7dZ4Ma0A542wdrg+eA@mail.gmail.com>
In-Reply-To: <CAEemH2dErC+9-UawDMdYq=rCnHOE7ciU7dZ4Ma0A542wdrg+eA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 1 Dec 2022 14:00:42 +0800
Message-ID: <CAEemH2eQ5EKwjoUaz52hPxdCHgdJEG90cCMWDgKq-P1RGJQXvw@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statvfs01: Convert to new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1018574739=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1018574739==
Content-Type: multipart/alternative; boundary="000000000000adfe7805eebdf17c"

--000000000000adfe7805eebdf17c
Content-Type: text/plain; charset="UTF-8"

Li Wang <liwang@redhat.com> wrote:


> We (probably) know that maximum filename should be less than 255 chars
>> (for e.g.), but I think there is a good chance that trying to validate
>> this will result in false positives and stuff we might want to revert.
>>
>
> Maybe we can create a concrete size of the device and mount
> it with a designated FS (e.g. ext4), then extracting the known FS
> data into `struct statvfs` and validating them.
>

As some of the data are determined by the FS attribute and
device size. (e.g. block size, total block, fragment size, and
total inodes). We can check them directly by known values.

For those easy change data, e.g. FS free blocks, which
determined by the real system status, maybe just check
that is no large than the total block number.

Based on that I draft something below to validate the fields.
what do you think?


#include <sys/statvfs.h>
#include "tst_test.h"

#define MNT_POINT "mntpoint"
#define TEST_PATH MNT_POINT"/testfile"

static void run(void)
{
        int type;
        struct statfs buf;
        struct statvfs vbuf;

        TST_EXP_PASS_SILENT(statfs(TEST_PATH, &buf));
        TST_EXP_PASS(statvfs(TEST_PATH, &vbuf));

        tst_res(TINFO, "Extracting FS info from the '%s' file", MNT_POINT);
        tst_res(TINFO, "vbuf.f_fsid == %lu", vbuf.f_fsid);

        long fs_type = tst_fs_type(TEST_PATH);

        switch (fs_type) {
        case TST_EXT2_OLD_MAGIC:
        case TST_EXT234_MAGIC:
                TST_EXP_EQ_LI(vbuf.f_bsize, 1024);
                TST_EXP_EQ_LI(vbuf.f_frsize, 1024);
                ttype = (vbuf.f_bfree <= buf.f_blocks) ? TPASS : TFAIL;
                tst_res(ttype, "vbuf.f_bfree == %ju", (uintmax_t)
vbuf.f_bfree);
                TST_EXP_EQ_LI(vbuf.f_files, 76912);
                ttype = (vbuf.f_ffree <= vbuf.f_files) ? TPASS : TFAIL;
                tst_res(ttype, "vbuf.f_ffree == %ju", (uintmax_t)
vbuf.f_ffree);
                TST_EXP_EQ_LI(vbuf.f_flag, 4096);
                TST_EXP_EQ_LI(vbuf.f_namemax, 255);
                break;
        case TST_XFS_MAGIC:
                TST_EXP_EQ_LI(vbuf.f_bsize, 4096);
                TST_EXP_EQ_LI(vbuf.f_frsize, 4096);
                ttype = (vbuf.f_bfree <= buf.f_blocks) ? TPASS : TFAIL;
                tst_res(ttype, "vbuf.f_bfree == %ju", (uintmax_t)
vbuf.f_bfree);
                TST_EXP_EQ_LI(vbuf.f_files, 153600);
                ttype = (vbuf.f_ffree <= vbuf.f_files) ? TPASS : TFAIL;
                tst_res(ttype, "vbuf.f_ffree == %ju", (uintmax_t)
vbuf.f_ffree);
                TST_EXP_EQ_LI(vbuf.f_flag, 4096);
                TST_EXP_EQ_LI(vbuf.f_namemax, 255);
                break;
        case TST_BTRFS_MAGIC:
                TST_EXP_EQ_LI(vbuf.f_bsize, 4096);
                TST_EXP_EQ_LI(vbuf.f_frsize, 4096);
                ttype = (vbuf.f_bfree <= buf.f_blocks) ? TPASS : TFAIL;
                tst_res(ttype, "vbuf.f_bfree == %ju", (uintmax_t)
vbuf.f_bfree);
                TST_EXP_EQ_LI(vbuf.f_files, 0);
                ttype = (vbuf.f_ffree <= vbuf.f_files) ? TPASS : TFAIL;
                tst_res(ttype, "vbuf.f_ffree == %ju", (uintmax_t)
vbuf.f_ffree);
                TST_EXP_EQ_LI(vbuf.f_flag, 4096);
                TST_EXP_EQ_LI(vbuf.f_namemax, 255);
                break;
        default:
                tst_res(TINFO, "vbuf.f_bsize == %lu bytes", vbuf.f_bsize);
                tst_res(TINFO, "vbuf.f_frsize == %lu bytes", vbuf.f_frsize);
                tst_res(TINFO, "vbuf.f_bfree == %ju", (uintmax_t)
vbuf.f_bfree);
                tst_res(TINFO, "vbuf.f_files == %ju", (uintmax_t)
vbuf.f_files);
                tst_res(TINFO, "vbuf.f_ffree == %ju", (uintmax_t)
vbuf.f_ffree);
                tst_res(TINFO, "vbuf.f_namemax == %lu", vbuf.f_namemax);
                break;
    }
}

static void setup(void)
{
        SAFE_TOUCH(TEST_PATH, 0666, NULL);
}

static struct tst_test test = {
        .test_all = run,
        .setup = setup,
        .needs_root = 1,
        .mount_device = 1,
        .mntpoint = MNT_POINT,
        .dev_min_size = 300,
        .all_filesystems = 1
};


-- 
Regards,
Li Wang

--000000000000adfe7805eebdf17c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redha=
t.com</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
We (probably) know that maximum filename should be less than 255 chars<br>
(for e.g.), but I think there is a good chance that trying to validate<br>
this will result in false positives and stuff we might want to revert.<br><=
/blockquote><div><br></div><div style=3D"font-size:small">Maybe we can crea=
te a concrete=C2=A0size of the device and mount</div><div style=3D"font-siz=
e:small">it with a designated FS (e.g. ext4), then extracting the known FS<=
/div><div style=3D"font-size:small">data into `struct statvfs` and validati=
ng them.</div></div></div></blockquote><div><br></div></div><div class=3D"g=
mail_default" style=3D"font-size:small">As some of the data are determined =
by the FS attribute and</div><div class=3D"gmail_default" style=3D"font-siz=
e:small">device size. (e.g. block size, total block, fragment size, and</di=
v><div class=3D"gmail_default" style=3D"font-size:small">total inodes). We =
can check them directly by known values.</div><div class=3D"gmail_default" =
style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">For those easy change data, e.g. FS free blocks, which</div=
><div class=3D"gmail_default" style=3D"font-size:small">determined by the r=
eal system status, maybe just check</div><div class=3D"gmail_default" style=
=3D"font-size:small">that is no=C2=A0large than the total block number.</di=
v><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">Based on that I draft someth=
ing below to validate the fields.</div><div class=3D"gmail_default" style=
=3D"font-size:small">what do you think?</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fo=
nt-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sm=
all">#include &lt;sys/statvfs.h&gt;<br>#include &quot;tst_test.h&quot;<br><=
br>#define MNT_POINT &quot;mntpoint&quot;<br>#define TEST_PATH MNT_POINT&qu=
ot;/testfile&quot;<br><br>static void run(void)<br>{<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0int type;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0struct statfs=
 buf;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0struct statvfs vbuf;<br><br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0TST_EXP_PASS_SILENT(statfs(TEST_PATH, &amp;bu=
f));<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0TST_EXP_PASS(statvfs(TEST_PATH, &a=
mp;vbuf));<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0tst_res(TINFO, &quot;Ext=
racting FS info from the &#39;%s&#39; file&quot;, MNT_POINT);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0tst_res(TINFO, &quot;vbuf.f_fsid =3D=3D %lu&quot;, v=
buf.f_fsid);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0long fs_type =3D tst_f=
s_type(TEST_PATH);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (fs_type) {<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0case TST_EXT2_OLD_MAGIC:<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0=C2=A0case TST_EXT234_MAGIC:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EQ_LI(vbuf.f_bsize, 1024);</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EQ_LI(vbuf.f_frsize, 1024);</div><div =
class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ttype =3D (vbuf.f_bfree &lt;=3D buf.f_block=
s) ? TPASS : TFAIL;</div><div class=3D"gmail_default" style=3D"font-size:sm=
all">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(ttype,=
 &quot;vbuf.f_bfree =3D=3D %ju&quot;, (uintmax_t) vbuf.f_bfree);</div><div =
class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EQ_LI(vbuf.f_files, 76912);</div><d=
iv class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ttype =3D (vbuf.f_ffree &lt;=3D vbuf.f_f=
iles) ? TPASS : TFAIL;</div><div class=3D"gmail_default" style=3D"font-size=
:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(tty=
pe, &quot;vbuf.f_ffree =3D=3D %ju&quot;, (uintmax_t) vbuf.f_ffree);</div><d=
iv class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EQ_LI(vbuf.f_flag, 4096);<br></d=
iv><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EQ_LI(vbuf.f_namemax, 255);<=
/div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TST_XFS_=
MAGIC:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_E=
Q_LI(vbuf.f_bsize, 4096);</div><div class=3D"gmail_default" style=3D"font-s=
ize:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_=
EQ_LI(vbuf.f_frsize, 4096);</div><div class=3D"gmail_default" style=3D"font=
-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ttype =
=3D (vbuf.f_bfree &lt;=3D buf.f_blocks) ? TPASS : TFAIL;</div><div class=3D=
"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(ttype, &quot;vbuf.f_bfree =3D=3D %ju&quot;=
, (uintmax_t) vbuf.f_bfree);</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_E=
XP_EQ_LI(vbuf.f_files, 153600);</div><div class=3D"gmail_default" style=3D"=
font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt=
ype =3D (vbuf.f_ffree &lt;=3D vbuf.f_files) ? TPASS : TFAIL;</div><div clas=
s=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(ttype, &quot;vbuf.f_ffree =3D=3D %ju&qu=
ot;, (uintmax_t) vbuf.f_ffree);</div><div class=3D"gmail_default" style=3D"=
font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TS=
T_EXP_EQ_LI(vbuf.f_flag, 4096);<br></div><div class=3D"gmail_default" style=
=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 TST_EXP_EQ_LI(vbuf.f_namemax, 255);</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;</div><div class=3D"gmail_default" style=3D"font-size:small">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TST_BTRFS_MAGIC:<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EQ_LI(vbuf.f_bsize, 4096);</div>=
<div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EQ_LI(vbuf.f_frsize, 4096);</di=
v><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ttype =3D (vbuf.f_bfree &lt;=3D buf.=
f_blocks) ? TPASS : TFAIL;</div><div class=3D"gmail_default" style=3D"font-=
size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res=
(ttype, &quot;vbuf.f_bfree =3D=3D %ju&quot;, (uintmax_t) vbuf.f_bfree);</di=
v><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EQ_LI(vbuf.f_files, 0);</div=
><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ttype =3D (vbuf.f_ffree &lt;=3D vbuf=
.f_files) ? TPASS : TFAIL;</div><div class=3D"gmail_default" style=3D"font-=
size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res=
(ttype, &quot;vbuf.f_ffree =3D=3D %ju&quot;, (uintmax_t) vbuf.f_ffree);</di=
v><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EQ_LI(vbuf.f_flag, 4096);<br=
></div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EQ_LI(vbuf.f_namemax, 25=
5);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;</div>=
<div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 default:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =
=C2=A0=C2=A0tst_res(TINFO, &quot;vbuf.f_bsize =3D=3D %lu bytes&quot;, vbuf.=
f_bsize);</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0tst_res(TINF=
O, &quot;vbuf.f_frsize =3D=3D %lu bytes&quot;, vbuf.f_frsize);</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0tst_res(TINFO, &quot;vbuf.f_bfree =
=3D=3D %ju&quot;, (uintmax_t) vbuf.f_bfree);</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0tst_res(TINFO, &quot;vbuf.f_files =3D=3D %ju&quot;, =
(uintmax_t) vbuf.f_files);</div><div class=3D"gmail_default" style=3D"font-=
size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0tst_res(TINFO, &quot;vbuf.f_ffree =3D=3D %ju&quot;, (uintmax_t) vbuf.f_f=
free);</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0tst_res(TINFO, &=
quot;vbuf.f_namemax =3D=3D %lu&quot;, vbuf.f_namemax);</div><div class=3D"g=
mail_default" style=3D"font-size:small">=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0break;</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">=C2=A0 =C2=A0 }<br>}<br><br>static void setup=
(void)<br>{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_TOUCH(TEST_PATH, 0666, NULL=
);<br>}<br><br>static struct tst_test test =3D {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .test_all =3D run,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_root =3D 1,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .mount_device =3D 1,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mntpoint =3D MN=
T_POINT,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .dev_min_size =3D 300,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 .all_filesystems =3D 1<br>};<br></div><br clear=3D"all=
"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000adfe7805eebdf17c--


--===============1018574739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1018574739==--

