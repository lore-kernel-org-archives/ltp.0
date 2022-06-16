Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1C1C43334
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 06:11:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A4083C527F
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 08:11:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 123D83C215A
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 08:11:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC0B7200C00
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 08:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655359892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pPd8Dlm4WtUEVyOzUdEgj02EUG4wPwKrH1tSx52BtJc=;
 b=XVlvmvTtxpZ4iK/VhTFlVU1xIf13yZJFDWQV1lr47T9gZHJo6is1v8FupXOK3a2QxILwmV
 QPq7IdSXcgFs0xSek5aUPpbELqtas3Z5XZMWHB4DF0H2XOf7LVZMXvjGxMVamCX8p0q4sQ
 FwLtMv32GLjUTqLgkwZ4ZF+N9F21JMI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-u3iV2JACN3CiNKsNzAFsjg-1; Thu, 16 Jun 2022 02:11:28 -0400
X-MC-Unique: u3iV2JACN3CiNKsNzAFsjg-1
Received: by mail-yb1-f199.google.com with SMTP id
 z67-20020a254c46000000b0065cd3d2e67eso281092yba.7
 for <ltp@lists.linux.it>; Wed, 15 Jun 2022 23:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pPd8Dlm4WtUEVyOzUdEgj02EUG4wPwKrH1tSx52BtJc=;
 b=NSqCWJLtLuVBX+VcWJo9Ql3xbP0V3qVV+r9fxvK/M1MeWj0e4ohKRMbY8xU2ueTAS+
 p5dE6SiXe9CLbtXnq7sASyNdTOXnWPCDb5khrp5yPu6N2FftRFa9UdA+UO10XiKpFDqT
 UCkjx2MBMcjZFRcUBNuXaArwi/xSgboMzvU7bPJWyd65CpHzwlXINUndk6sIfvtKJ3D2
 sMOEgQ+ChW3Js1keTEUj9toWVBwWzGmjccVbd/Q2ipFhFXp+J2PbQe8X2zovmgHmJ4QM
 0jTAJUdt8huLWDRXxux1buCWGW37W/AW3TZGNqwQ+L7Vq7qS0aODFDWtgSilDvNxkZ+R
 PwUA==
X-Gm-Message-State: AJIora8UJjcp8OQon4UgdvuLrMt6iucAedFRYGxhuV3/7Job+2wbr8km
 pDiVC+ej2IDhCdcHRmQ9TAsplHQMFSb73djvCgiu0glMZoBnId3YZeS6xAPdk03r87RXfUJZRdX
 U1vlvpn+QXqjwwk3qtGOa0YdxbUs=
X-Received: by 2002:a81:2f84:0:b0:314:2bfd:bf1f with SMTP id
 v126-20020a812f84000000b003142bfdbf1fmr3805824ywv.320.1655359887457; 
 Wed, 15 Jun 2022 23:11:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vwheG01gNK7aqC7CgxUQrhsdttgqbFzupDbx+R9nJtReGs0IS6yt+y/xllp6oefqtBZlO7KFPxWv11ngP9T7Q=
X-Received: by 2002:a81:2f84:0:b0:314:2bfd:bf1f with SMTP id
 v126-20020a812f84000000b003142bfdbf1fmr3805815ywv.320.1655359887227; Wed, 15
 Jun 2022 23:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-10-pvorel@suse.cz>
In-Reply-To: <20220609214223.4608-10-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Jun 2022 14:11:16 +0800
Message-ID: <CAEemH2dViRNFsreFRyyTtPECdVEyaAEE0CuYBmZrwor=rgi=mQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH v2 9/9] nfs: Use TST_ALL_FILESYSTEMS=1
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
Cc: linux-nfs@vger.kernel.org, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0875992507=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0875992507==
Content-Type: multipart/alternative; boundary="0000000000000dd69905e18a82d1"

--0000000000000dd69905e18a82d1
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 10, 2022 at 5:44 AM Petr Vorel <pvorel@suse.cz> wrote:

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi NFS developers,
>
> your comments are welcome. This is an effort how to support NFS tests on
> all filesystems available on SUT. Using $TST_MNTPOINT means test run in
> loop, each time different filesystem is used. It's implemented via
> formatted loop device (the same way as in LTP C API).
>
> Code is also at:
> https://github.com/pevik/ltp/tree/shell/all_filesystems.v2
>
> But this requires restarting NFS server (otherwise legacy
> testcases/lib/daemonlib.sh
> would have to be used), which is IMHO not optimal.
>
> Without that (or only run 'systemctl reload nfs-server' or exportfs -r
> on remote side) it cannot be umounted after testing - debugging with
> fuser, code at:
>
> https://github.com/pevik/ltp/commit/3656d035d43445a107154ef397ef1db2fad2c4f0
>
> The problem is that loop device is still referenced by nfs server and
> thus cannot be unmounted. Can this be somehow fixed? Is it even wanted
> to have tests on loop device (the only reasonable way to support more
> filesystems)? Also tests will run much longer (we could filter out some
> filesystems not supported, if there are any).
>
> # LTP_SINGLE_FS_TYPE=ext2 PATH="/opt/ltp/testcases/bin:$PATH" nfs07.sh -v
> 3 -t tcp -i3
> ## NOTE: testing itself is OK
> nfs07 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> nfs07 1 TINFO: add local addr 10.0.0.2/24
> nfs07 1 TINFO: add local addr fd00:1:1:1::2/64
> nfs07 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> nfs07 1 TINFO: add remote addr 10.0.0.1/24
> nfs07 1 TINFO: add remote addr fd00:1:1:1::1/64
> nfs07 1 TINFO: Network config (local -- remote):
> nfs07 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> nfs07 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> nfs07 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
> tst_supported_fs_types.c:148: TINFO: WARNING: testing only ext2
> tst_supported_fs_types.c:89: TINFO: Kernel supports ext2
> tst_supported_fs_types.c:51: TINFO: mkfs.ext2 does exist
> nfs07 1 TINFO: Testing on ext2
> nfs07 1 TINFO: Formatting ext2 with opts='/dev/loop0'
> nfs07 1 TINFO: timeout per run is 0h 5m 0s
> nfs07 1 TINFO: mount.nfs: (linux nfs-utils 2.6.1)
> nfs07 1 TINFO: setup NFSv3, socket type tcp
> nfs07 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfs07.A3PIB82iUv/mntpoint/3/tcp
> /tmp/LTP_nfs07.A3PIB82iUv/mntpoint/3/0
> nfs07 1 TPASS: All files and directories were correctly listed
> nfs07 2 TPASS: All files and directories were correctly listed
> nfs07 3 TPASS: All files and directories were correctly listed
> nfs07 4 TINFO: Cleaning up testcase
>
> ## DEBUGGING CODE in nfs_cleanup()
> nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w ($TST_TMPDIR)
>                      USER        PID ACCESS COMMAND
> /tmp/LTP_nfs07.P1XS9smc5w:
>                      root     kernel mount /tmp
>                      root       2125 ..c.. tst_timeout_kil
> nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w/mntpoint ($TST_MNTPOINT)
>                      USER        PID ACCESS COMMAND
> /tmp/LTP_nfs07.P1XS9smc5w/mntpoint:
>                      root     kernel mount
> /tmp/LTP_nfs07.P1XS9smc5w/mntpoint
> nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0
>                      USER        PID ACCESS COMMAND
> /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0:
>                      root     kernel mount
> /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0
>
> ## from nfs_cleanup()
> ## grep -q "$local_dir" /proc/mounts && umount $local_dir
> nfs07 4 TINFO: umount /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0
> umount: /tmp/LTP_nfs07.P1XS9smc5w/mntpoint: target is busy.
>

Maybe try with `umount -fl`?

unmount manual says:
   -f, --force    force unmount (in case of an unreachable NFS system)
   -l, --lazy      detach the filesystem now, clean up things later

-- 
Regards,
Li Wang

--0000000000000dd69905e18a82d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Jun 10, 2022 at 5:44 AM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Petr Vorel &lt;<=
a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt;<b=
r>
---<br>
Hi NFS developers,<br>
<br>
your comments are welcome. This is an effort how to support NFS tests on<br=
>
all filesystems available on SUT. Using $TST_MNTPOINT means test run in<br>
loop, each time different filesystem is used. It&#39;s implemented via<br>
formatted loop device (the same way as in LTP C API).<br>
<br>
Code is also at: <a href=3D"https://github.com/pevik/ltp/tree/shell/all_fil=
esystems.v2" rel=3D"noreferrer" target=3D"_blank">https://github.com/pevik/=
ltp/tree/shell/all_filesystems.v2</a><br>
<br>
But this requires restarting NFS server (otherwise legacy testcases/lib/dae=
monlib.sh<br>
would have to be used), which is IMHO not optimal.<br>
<br>
Without that (or only run &#39;systemctl reload nfs-server&#39; or exportfs=
 -r<br>
on remote side) it cannot be umounted after testing - debugging with<br>
fuser, code at:<br>
<a href=3D"https://github.com/pevik/ltp/commit/3656d035d43445a107154ef397ef=
1db2fad2c4f0" rel=3D"noreferrer" target=3D"_blank">https://github.com/pevik=
/ltp/commit/3656d035d43445a107154ef397ef1db2fad2c4f0</a><br>
<br>
The problem is that loop device is still referenced by nfs server and<br>
thus cannot be unmounted. Can this be somehow fixed? Is it even wanted<br>
to have tests on loop device (the only reasonable way to support more<br>
filesystems)? Also tests will run much longer (we could filter out some<br>
filesystems not supported, if there are any).<br>
<br>
# LTP_SINGLE_FS_TYPE=3Dext2 PATH=3D&quot;/opt/ltp/testcases/bin:$PATH&quot;=
 nfs07.sh -v 3 -t tcp -i3<br>
## NOTE: testing itself is OK<br>
nfs07 1 TINFO: initialize &#39;lhost&#39; &#39;ltp_ns_veth2&#39; interface<=
br>
nfs07 1 TINFO: add local addr <a href=3D"http://10.0.0.2/24" rel=3D"norefer=
rer" target=3D"_blank">10.0.0.2/24</a><br>
nfs07 1 TINFO: add local addr fd00:1:1:1::2/64<br>
nfs07 1 TINFO: initialize &#39;rhost&#39; &#39;ltp_ns_veth1&#39; interface<=
br>
nfs07 1 TINFO: add remote addr <a href=3D"http://10.0.0.1/24" rel=3D"norefe=
rrer" target=3D"_blank">10.0.0.1/24</a><br>
nfs07 1 TINFO: add remote addr fd00:1:1:1::1/64<br>
nfs07 1 TINFO: Network config (local -- remote):<br>
nfs07 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1<br>
nfs07 1 TINFO: <a href=3D"http://10.0.0.2/24" rel=3D"noreferrer" target=3D"=
_blank">10.0.0.2/24</a> -- <a href=3D"http://10.0.0.1/24" rel=3D"noreferrer=
" target=3D"_blank">10.0.0.1/24</a><br>
nfs07 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64<br>
tst_device.c:89: TINFO: Found free device 0 &#39;/dev/loop0&#39;<br>
tst_supported_fs_types.c:148: TINFO: WARNING: testing only ext2<br>
tst_supported_fs_types.c:89: TINFO: Kernel supports ext2<br>
tst_supported_fs_types.c:51: TINFO: mkfs.ext2 does exist<br>
nfs07 1 TINFO: Testing on ext2<br>
nfs07 1 TINFO: Formatting ext2 with opts=3D&#39;/dev/loop0&#39;<br>
nfs07 1 TINFO: timeout per run is 0h 5m 0s<br>
nfs07 1 TINFO: mount.nfs: (linux nfs-utils 2.6.1)<br>
nfs07 1 TINFO: setup NFSv3, socket type tcp<br>
nfs07 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=3Dtcp,vers=3D3 10.0.0=
.2:/tmp/LTP_nfs07.A3PIB82iUv/mntpoint/3/tcp /tmp/LTP_nfs07.A3PIB82iUv/mntpo=
int/3/0<br>
nfs07 1 TPASS: All files and directories were correctly listed<br>
nfs07 2 TPASS: All files and directories were correctly listed<br>
nfs07 3 TPASS: All files and directories were correctly listed<br>
nfs07 4 TINFO: Cleaning up testcase<br>
<br>
## DEBUGGING CODE in nfs_cleanup()<br>
nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w ($TST_TMPDIR)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0USER=C2=A0 =C2=A0 =C2=A0 =C2=A0 PID ACCESS COMMAND<br>
/tmp/LTP_nfs07.P1XS9smc5w:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0root=C2=A0 =C2=A0 =C2=A0kernel mount /tmp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0root=C2=A0 =C2=A0 =C2=A0 =C2=A02125 ..c.. tst_timeout_kil<br>
nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w/mntpoint ($TST_MNTPOINT)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0USER=C2=A0 =C2=A0 =C2=A0 =C2=A0 PID ACCESS COMMAND<br>
/tmp/LTP_nfs07.P1XS9smc5w/mntpoint:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0root=C2=A0 =C2=A0 =C2=A0kernel mount /tmp/LTP_nfs07.P1XS9smc5w/mntpoint<=
br>
nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0USER=C2=A0 =C2=A0 =C2=A0 =C2=A0 PID ACCESS COMMAND<br>
/tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0root=C2=A0 =C2=A0 =C2=A0kernel mount /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/=
3/0<br>
<br>
## from nfs_cleanup()<br>
## grep -q &quot;$local_dir&quot; /proc/mounts &amp;&amp; umount $local_dir=
<br>
nfs07 4 TINFO: umount /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0<br>
umount: /tmp/LTP_nfs07.P1XS9smc5w/mntpoint: target is busy.<br></blockquote=
><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small"=
><span class=3D"gmail_default"></span>Maybe try with `umount -fl`?</div></d=
iv><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:smal=
l">unmount manual says:</div></div><div><div class=3D"gmail_default" style=
=3D"font-size:small">=C2=A0 =C2=A0-f, --force=C2=A0 =C2=A0 force unmount (i=
n case of an unreachable NFS system)</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">=C2=A0 =C2=A0-l, --lazy=C2=A0 =C2=A0 =C2=A0 detach th=
e filesystem now, clean up things later<br></div><div class=3D"gmail_defaul=
t" style=3D"font-size:small"></div></div></div><div><br></div>-- <br><div d=
ir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></di=
v><div>Li Wang<br></div></div></div></div>

--0000000000000dd69905e18a82d1--


--===============0875992507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0875992507==--

