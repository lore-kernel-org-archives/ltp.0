Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C47FA3740
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 18:59:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDB983CA8A6
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 20:59:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC3A23C04BF
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 20:59:11 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5E87A60135B
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 20:59:10 +0200 (CEST)
Received: by mail-io1-xd35.google.com with SMTP id z3so2487111iof.3
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tZTDMFXG6tj5RKeLFPmJdErGaF4iLWn+KZY4qFkIgYE=;
 b=Jd7Ti6xVh7ZE3ogjS7qdLB0OG4vHDqTNyKAxp1yjwOfZFF5KKnsHOueXVqZ+rL0kU8
 hygDlT+POQM76HAWzCfBK4TTBGnOucfqElPt03PPf4LW+86jkYkoOSUlJdjafhewFbqQ
 qNDYwlByYbouzwp37qKcVJDi5k0hFHZG7f1SCrftsFM7IrOPiLZ/tYPh2DAymkoZ3IkF
 Y7u60wCmT+EkasSB+9oJ8zWDyclfZL5J0vfb2TLSpFi7L2B1VLyQwTPbuzthBA8yI4b7
 ogC2z2+iVLGdIn9TqYKPvsBmpEsoUoFHt8GClAYyZuuNmREJdxmocwTB+1YArwo/6xVk
 RTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tZTDMFXG6tj5RKeLFPmJdErGaF4iLWn+KZY4qFkIgYE=;
 b=OBACIl1t2hMGBeguggDvAwYcbwbFXtmxveDqCPiyW7a5xvo7pc0juFONeQPjdpcR/B
 3RY50hbc64o7b7YheVcoioyxiOZf4S9ri81Hp+nUgO2fR7+evhWgDUgWQ3cMTDKTj/Hd
 JGuUUyTmDis9VcfmrNv8XEIlNCuvSjxYcLDzrc7ewTQZtL7EkUTKE69MJbhZzU9RRZ4l
 JrBYeagUZ9s1usHs8TdFzh6d6dOknvDoY1XC8W0Q73DrXet+ULMQ5AbXKhqDeOkYT498
 HSO5En+tCxqmIkye/ay645+UN6ojSjegdE/CMq1Knxv94GA4KsWDxY9Vg8XZWLnv7nNj
 IBdQ==
X-Gm-Message-State: ACrzQf2RaITq5SxSU1cPlGQo465HqJZ6QNiPc8Xxha26uS44MirIDtwj
 yjm5z2QA0TRbMogCt6AQVbnXd9+o4AGKxnHTGfA=
X-Google-Smtp-Source: AMsMyM6bqou8WhVuSWA0MkpOLoASvHfdhGwu2k4j38kLUpmkous3fnQZKCXazOCWgBKGWAihFbtIXPnqDdkfRO9UuC4=
X-Received: by 2002:a02:a0ca:0:b0:363:4661:c7e0 with SMTP id
 i10-20020a02a0ca000000b003634661c7e0mr31622802jah.214.1666897148637; Thu, 27
 Oct 2022 11:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221026140408.471609-1-alessandro.carminati@gmail.com>
 <20221026140408.471609-2-alessandro.carminati@gmail.com>
 <87fsf9sk2e.fsf@suse.de>
In-Reply-To: <87fsf9sk2e.fsf@suse.de>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Thu, 27 Oct 2022 20:58:31 +0200
Message-ID: <CAPp5cGQ++39EMSV3MrMTTKrTyn5WWRou=yP7f4jbBQ7p-F+cyA@mail.gmail.com>
To: rpalethorpe@suse.de
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_find_backing_dev: Get dev name from
 /sys/dev/block/*/uevent
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
Cc: acarmina@redhat.com, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0188338312=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0188338312==
Content-Type: multipart/alternative; boundary="0000000000006bf99f05ec08bc5f"

--0000000000006bf99f05ec08bc5f
Content-Type: text/plain; charset="UTF-8"

Hello Richard,





Il giorno gio 27 ott 2022 alle ore 11:16 Richard Palethorpe <
rpalethorpe@suse.de> ha scritto:

> Hello,
>
> Alessandro Carminati <alessandro.carminati@gmail.com> writes:
>
> > In some minimal Linux the /dev/root can be missing. The consequence for
> this
> > is that mountinfo doesn't contain the correct information.
> >
> > The unevent file in sysfs is another method to retrieve device info
> given
> > a major/minor.
> >
> > btrfs subvolumes can be an exception to this rule, but they are not
> expected
> > to be used in the current usecase.
>
> Unfortunately this is not true. If you mount /tmp on BTRFS (or set
> TMPDIR to some BTRFS mount), then we hit this issue.
>

This is also true if you use the mountinfo strategy.
I ran a few tests on my test environment, and I could see that the
ioctl_loop05
on btrfs filesystem doesn't work either with the mountinfo strategy.

Here is a sample running the original (with a few additional debug output)
test
using the mountinfo strategy on ext3:

VFS: Mounted root (ext2 filesystem) on device 8:0.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 956K
Write protecting the kernel read-only data: 14336k
Freeing unused kernel image (text/rodata gap) memory: 2044K
Freeing unused kernel image (rodata/data gap) memory: 48K
Run /sbin/init as init process
random: fast init done
EXT4-fs (sda): re-mounted. Opts: (null). Quota mode: disabled.
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving random seed: random: dd: uninitialized urandom read (512 bytes read)
OK
Starting network: Waiting for interface eth0 to appear...............
timeout!
run-parts: /etc/network/if-pre-up.d/wait_iface: exit status 1
FAIL

Welcome to Buildroot
buildroot login: root
# /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05
tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
tst_test.c:1115: TINFO: ext2/ext3/ext4 is supported by the test
tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
loop0: detected capacity change from 0 to 2048
tst_device.c:522: TINFO: Debug: Device numbers: 8/0
tst_device.c:527: TINFO: Debug: 14 1 8:0 / / rw,relatime - ext2 /dev/root rw
tst_device.c:543: TINFO: Debug: devneme=/dev/root
tst_device.c:548: TWARN: stat(/dev/root) failed: ENOENT (2)

Summary:
passed   0
failed   0
broken   0
skipped  0
warnings 1
# ln -s /dev/sda /dev/root
# /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05
tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
tst_test.c:1115: TINFO: ext2/ext3/ext4 is supported by the test
tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
loop0: detected capacity change from 0 to 2048
tst_device.c:522: TINFO: Debug: Device numbers: 8/0
tst_device.c:527: TINFO: Debug: 14 1 8:0 / / rw,relatime - ext2 /dev/root rw
tst_device.c:543: TINFO: Debug: devneme=/dev/root
ioctl_loop05.c:126: TINFO: backing dev(/dev/root) logical_block_size is 512
ioctl_loop05.c:62: TINFO: Without setting lo_offset or sizelimit
ioctl_loop05.c:45: TINFO: In dio mode
ioctl_loop05.c:48: TPASS: lo_flags has LO_FLAGS_DIRECT_IO flag
ioctl_loop05.c:52: TPASS: /sys/block/loop0/loop/dio = 1
ioctl_loop05.c:45: TINFO: In non dio mode
ioctl_loop05.c:50: TPASS: lo_flags doesn't have LO_FLAGS_DIRECT_IO flag
ioctl_loop05.c:52: TPASS: /sys/block/loop0/loop/dio = 0
ioctl_loop05.c:69: TINFO: With offset equal to logical_block_size
loop0: detected capacity change from 2048 to 2047
ioctl_loop05.c:74: TPASS: LOOP_SET_DIRECT_IO succeeded
ioctl_loop05.c:45: TINFO: In dio mode
ioctl_loop05.c:48: TPASS: lo_flags has LO_FLAGS_DIRECT_IO flag
ioctl_loop05.c:52: TPASS: /sys/block/loop0/loop/dio = 1
ioctl_loop05.c:81: TINFO: With nonzero offset less than logical_block_size
ioctl_loop05.c:92: TPASS: LOOP_SET_DIRECT_IO failed as expected: EINVAL (22)

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0

here the same system on a btrfs

VFS: Mounted root (btrfs filesystem) on device 0:13.
random: fast init done
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 956K
Write protecting the kernel read-only data: 14336k
Freeing unused kernel image (text/rodata gap) memory: 2044K
Freeing unused kernel image (rodata/data gap) memory: 48K
Run /sbin/init as init process
BTRFS info (device sda): disk space caching is enabled
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving random seed: random: dd: uninitialized urandom read (512 bytes read)
OK
Starting network: Waiting for interface eth0 to appear...............
timeout!
run-parts: /etc/network/if-pre-up.d/wait_iface: exit status 1
FAIL

Welcome to Buildroot
buildroot login: root
# kill 71
# umount /tmp
# umount /run
# /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05
tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
tst_test.c:1115: TINFO: btrfs is supported by the test
tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
loop0: detected capacity change from 0 to 2048
tst_device.c:522: TINFO: Debug: Device numbers: 0/14
tst_device.c:527: TINFO: Debug: 15 1 0:13 / / rw,relatime - btrfs /dev/root
rw,space_cache,subvolid=5,subvol=/
tst_device.c:527: TINFO: Debug: 16 15 0:5 / /dev rw,relatime - devtmpfs
devtmpfs rw,size=505416k,nr_inodes=126354,mode=755
tst_device.c:527: TINFO: Debug: 14 15 0:15 / /proc rw,relatime - proc proc
rw
tst_device.c:527: TINFO: Debug: 17 16 0:16 / /dev/pts rw,relatime - devpts
devpts rw,gid=5,mode=620,ptmxmode=666
tst_device.c:527: TINFO: Debug: 18 16 0:17 / /dev/shm rw,relatime - tmpfs
tmpfs rw,mode=777
tst_device.c:527: TINFO: Debug: 21 15 0:20 / /sys rw,relatime - sysfs sysfs
rw
tst_device.c:543: TINFO: Debug: devneme=
tst_device.c:545: TBROK: Cannot find block device for
/tmp/iocz4RUVG/test.img

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
# ln -s /dev/sda /dev/root
# /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05
tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
tst_test.c:1115: TINFO: btrfs is supported by the test
tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
loop0: detected capacity change from 0 to 2048
tst_device.c:522: TINFO: Debug: Device numbers: 0/14
tst_device.c:527: TINFO: Debug: 15 1 0:13 / / rw,relatime - btrfs /dev/root
rw,space_cache,subvolid=5,subvol=/
tst_device.c:527: TINFO: Debug: 16 15 0:5 / /dev rw,relatime - devtmpfs
devtmpfs rw,size=505416k,nr_inodes=126354,mode=755
tst_device.c:527: TINFO: Debug: 14 15 0:15 / /proc rw,relatime - proc proc
rw
tst_device.c:527: TINFO: Debug: 17 16 0:16 / /dev/pts rw,relatime - devpts
devpts rw,gid=5,mode=620,ptmxmode=666
tst_device.c:527: TINFO: Debug: 18 16 0:17 / /dev/shm rw,relatime - tmpfs
tmpfs rw,mode=777
tst_device.c:527: TINFO: Debug: 21 15 0:20 / /sys rw,relatime - sysfs sysfs
rw
tst_device.c:543: TINFO: Debug: devneme=
tst_device.c:545: TBROK: Cannot find block device for
/tmp/ioctVo52r/test.img

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
#

a stat on the /, results in a couple of minor/major that is different from
the
couple listed in the mountinfo. This leads, as a result, a test failure.


> >
> > This solution requires sysfs to be mounted in /sys, but considering many
> > tests depends on the same, including the ioctl_loop05 that triggered
> this
> > patch, this requirement is not too restricted, and the old mountinfo can
> be
> > dropped altogether.
>
> The mountinfo method is not such a maintenance issue that it needs to be
> removed IMO. Possibly it could be replaced by tst_stat_mount_dev
> instead, but we're cautious about touching this function.
>

tst_find_backing_dev(), the function that is the target of this patch,
seems to
be referenced in only a couple of points in all the LTP test suite.
One place is in the ioctl_loop05 test, the other reference I found is in
the
lib/tst_device.c - tst_dev_block_size().  tst_dev_block_size() is a
function
that seems not to be referenced by any test.


>
> To be clear, I'm not sure anyone compiles Linux without /sys then tries
> to run LTP on it. However the fact that it is possible to remove /sys is
> another signal (in addition to BTRFS) that the situation is complicated.
>

Indeed, if we want to have a test that works in all the possible scenarios,
it needs additional work.
But IMHO, keeping the mountinfo strategy gives no advantage over not
having it.


> >
> > $ sudo /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05
> > tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
> > tst_test.c:1115: TINFO: ext2/ext3/ext4 is supported by the test
> > tst_device.c:91: TINFO: Found free device 0 '/dev/loop0'
> > loop0: detected capacity change from 0 to 2048
> > tst_device.c:570: TINFO: Device name retrived through mountinfo
> > ioctl_loop05.c:126: TINFO: backing dev(/dev/root) logical_block_size is
> 512
> > ioctl_loop05.c:62: TINFO: Without setting lo_offset or sizelimit
> > ioctl_loop05.c:45: TINFO: In dio mode
> > ioctl_loop05.c:48: TPASS: lo_flags has LO_FLAGS_DIRECT_IO flag
> > ioctl_loop05.c:52: TBROK: Failed to open FILE
> '/sys/block/loop0/loop/dio' for reading: ENOENT (2)
> >
> > Summary:
> > passed   1
> > failed   0
> > broken   1
> > skipped  0
> > warnings 0
> >
> > The example here shows what happen if sysfs is not mounted and the
> > mountinfo method is used: the tests that depends on sysfs fail with
> > broken and not just warn.
> >
> > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> > Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> > ---
> >  lib/tst_device.c | 41 ++++++++++-------------------------------
> >  1 file changed, 10 insertions(+), 31 deletions(-)
> >
> > diff --git a/lib/tst_device.c b/lib/tst_device.c
> > index 8419b80c3..4ccb71ac8 100644
> > --- a/lib/tst_device.c
> > +++ b/lib/tst_device.c
> > @@ -520,48 +520,27 @@ void tst_find_backing_dev(const char *path, char
> *dev)
> >  {
> >       struct stat buf;
> >       FILE *file;
> > -     char line[PATH_MAX];
> > -     char *pre = NULL;
> > -     char *next = NULL;
> > -     unsigned int dev_major, dev_minor, line_mjr, line_mnr;
> > -     unsigned int len, best_match_len = 1;
> > -     char mnt_point[PATH_MAX];
> > +     unsigned int dev_major, dev_minor;
> > +     char uevent_path[PATH_MAX];
> > +     char dev_name[NAME_MAX];
> >
> >       if (stat(path, &buf) < 0)
> >               tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
> >
> > +     *dev = '\0';
> >       dev_major = major(buf.st_dev);
> >       dev_minor = minor(buf.st_dev);
> > -     file = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
> > -     *dev = '\0';
> > -
> > -     while (fgets(line, sizeof(line), file)) {
> > -             if (sscanf(line, "%*d %*d %d:%d %*s %s",
> > -                     &line_mjr, &line_mnr, mnt_point) != 3)
> > -                     continue;
> >
> > -             pre = strstr(line, " - ");
> > -             pre = strtok_r(pre, " ", &next);
> > -             pre = strtok_r(NULL, " ", &next);
> > -             pre = strtok_r(NULL, " ", &next);
> > +     sprintf(uevent_path,
> > +             "/sys/dev/block/%d:%d/uevent", dev_major, dev_minor);
> >
> > -             if (line_mjr == dev_major && line_mnr == dev_minor) {
> > -                     strcpy(dev, pre);
> > -                     break;
> > -             }
> > +     if (!access(uevent_path, R_OK)) {
> > +             FILE_LINES_SCANF(NULL, uevent_path, "DEVNAME=%s",
> dev_name);
> >
> > -             len = count_match_len(path, mnt_point);
> > -             if (len > best_match_len) {
> > -                     strcpy(dev, pre);
> > -                     best_match_len = len;
> > -             }
> > +             if (dev_name[0])
> > +                     sprintf(dev, "/dev/%s", dev_name);
> >       }
> >
> > -     SAFE_FCLOSE(NULL, file);
> > -
> > -     if (!*dev)
> > -             tst_brkm(TBROK, NULL, "Cannot find block device for %s",
> path);
> > -
> >       if (stat(dev, &buf) < 0)
> >               tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
>
>
> --
> Thank you,
> Richard.
>

Thank you for your time.
Alessandro

--0000000000006bf99f05ec08bc5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Richard,<div><br clear=3D"all"><div=
><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><br><br><div style=3D"display:inline"></div>=
</div></div></div></div></div></div></div><br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il giorno gio 27 ott 20=
22 alle ore 11:16 Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse=
.de">rpalethorpe@suse.de</a>&gt; ha scritto:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Hello,<br>
<br>
Alessandro Carminati &lt;<a href=3D"mailto:alessandro.carminati@gmail.com" =
target=3D"_blank">alessandro.carminati@gmail.com</a>&gt; writes:<br>
<br>
&gt; In some minimal Linux the /dev/root can be missing. The consequence fo=
r this<br>
&gt; is that mountinfo doesn&#39;t contain the correct information.<br>
&gt;<br>
&gt; The unevent file in sysfs is another method to retrieve device info gi=
ven=C2=A0<br>
&gt; a major/minor.<br>
&gt;<br>
&gt; btrfs subvolumes can be an exception to this rule, but they are not ex=
pected<br>
&gt; to be used in the current usecase.<br>
<br>
Unfortunately this is not true. If you mount /tmp on BTRFS (or set<br>
TMPDIR to some BTRFS mount), then we hit this issue.<br></blockquote><div><=
br></div><div>This is also true if you use the mountinfo strategy.</div>I r=
an a few tests on my test environment, and I could=C2=A0see that the ioctl_=
loop05=C2=A0</div><div class=3D"gmail_quote">on btrfs filesystem doesn&#39;=
t work either with the mountinfo strategy.<br><br>Here is a sample running =
the original (with a few additional debug output) test</div><div class=3D"g=
mail_quote">using the mountinfo strategy on ext3:</div><div class=3D"gmail_=
quote"><br>VFS: Mounted root (ext2 filesystem) on device 8:0.<br>devtmpfs: =
mounted<br>Freeing unused kernel image (initmem) memory: 956K<br>Write prot=
ecting the kernel read-only data: 14336k<br>Freeing unused kernel image (te=
xt/rodata gap) memory: 2044K<br>Freeing unused kernel image (rodata/data ga=
p) memory: 48K<br>Run /sbin/init as init process<br>random: fast init done<=
br>EXT4-fs (sda): re-mounted. Opts: (null). Quota mode: disabled.<br>Starti=
ng syslogd: OK<br>Starting klogd: OK<br>Running sysctl: OK<br>Saving random=
 seed: random: dd: uninitialized urandom read (512 bytes read)<br>OK<br>Sta=
rting network: Waiting for interface eth0 to appear............... timeout!=
<br>run-parts: /etc/network/if-pre-up.d/wait_iface: exit status 1<br>FAIL<b=
r><br>Welcome to Buildroot<br>buildroot login: root<br># /usr/lib/ltp-tests=
uite/testcases/bin/ioctl_loop05<br>tst_test.c:1363: TINFO: Timeout per run =
is 0h 05m 00s<br>tst_test.c:1115: TINFO: ext2/ext3/ext4 is supported by the=
 test<br>tst_device.c:88: TINFO: Found free device 0 &#39;/dev/loop0&#39;<b=
r>loop0: detected capacity change from 0 to 2048<br>tst_device.c:522: TINFO=
: Debug: Device numbers: 8/0</div><div class=3D"gmail_quote">tst_device.c:5=
27: TINFO: Debug: 14 1 8:0 / / rw,relatime - ext2 /dev/root rw<br>tst_devic=
e.c:543: TINFO: Debug: devneme=3D/dev/root<br>tst_device.c:548: TWARN: stat=
(/dev/root) failed: ENOENT (2)<br><br>Summary:<br>passed =C2=A0 0<br>failed=
 =C2=A0 0<br>broken =C2=A0 0<br>skipped =C2=A00<br>warnings 1<br># ln -s /d=
ev/sda /dev/root<br># /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05<br>=
tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s<br>tst_test.c:1115: T=
INFO: ext2/ext3/ext4 is supported by the test<br>tst_device.c:88: TINFO: Fo=
und free device 0 &#39;/dev/loop0&#39;<br>loop0: detected capacity change f=
rom 0 to 2048<br>tst_device.c:522: TINFO: Debug: Device numbers: 8/0</div><=
div class=3D"gmail_quote">tst_device.c:527: TINFO: Debug: 14 1 8:0 / / rw,r=
elatime - ext2 /dev/root rw<br>tst_device.c:543: TINFO: Debug: devneme=3D/d=
ev/root<br>ioctl_loop05.c:126: TINFO: backing dev(/dev/root) logical_block_=
size is 512<br>ioctl_loop05.c:62: TINFO: Without setting lo_offset or sizel=
imit<br>ioctl_loop05.c:45: TINFO: In dio mode<br>ioctl_loop05.c:48: TPASS: =
lo_flags has LO_FLAGS_DIRECT_IO flag<br>ioctl_loop05.c:52: TPASS: /sys/bloc=
k/loop0/loop/dio =3D 1<br>ioctl_loop05.c:45: TINFO: In non dio mode<br>ioct=
l_loop05.c:50: TPASS: lo_flags doesn&#39;t have LO_FLAGS_DIRECT_IO flag<br>=
ioctl_loop05.c:52: TPASS: /sys/block/loop0/loop/dio =3D 0<br>ioctl_loop05.c=
:69: TINFO: With offset equal to logical_block_size<br>loop0: detected capa=
city change from 2048 to 2047<br>ioctl_loop05.c:74: TPASS: LOOP_SET_DIRECT_=
IO succeeded<br>ioctl_loop05.c:45: TINFO: In dio mode<br>ioctl_loop05.c:48:=
 TPASS: lo_flags has LO_FLAGS_DIRECT_IO flag<br>ioctl_loop05.c:52: TPASS: /=
sys/block/loop0/loop/dio =3D 1<br>ioctl_loop05.c:81: TINFO: With nonzero of=
fset less than logical_block_size<br>ioctl_loop05.c:92: TPASS: LOOP_SET_DIR=
ECT_IO failed as expected: EINVAL (22)<br><br>Summary:<br>passed =C2=A0 8<b=
r>failed =C2=A0 0<br>broken =C2=A0 0<br>skipped =C2=A00<br>warnings 0<br><b=
r>here the same system on a btrfs<br><br>VFS: Mounted root (btrfs filesyste=
m) on device 0:13.<br>random: fast init done<br>devtmpfs: mounted<br>Freein=
g unused kernel image (initmem) memory: 956K<br>Write protecting the kernel=
 read-only data: 14336k<br>Freeing unused kernel image (text/rodata gap) me=
mory: 2044K<br>Freeing unused kernel image (rodata/data gap) memory: 48K<br=
>Run /sbin/init as init process<br>BTRFS info (device sda): disk space cach=
ing is enabled<br>Starting syslogd: OK<br>Starting klogd: OK<br>Running sys=
ctl: OK<br>Saving random seed: random: dd: uninitialized urandom read (512 =
bytes read)<br>OK<br>Starting network: Waiting for interface eth0 to appear=
............... timeout!<br>run-parts: /etc/network/if-pre-up.d/wait_iface:=
 exit status 1<br>FAIL<br><br>Welcome to Buildroot<br>buildroot login: root=
<br># kill 71<br># umount /tmp<br># umount /run<br># /usr/lib/ltp-testsuite=
/testcases/bin/ioctl_loop05<br>tst_test.c:1363: TINFO: Timeout per run is 0=
h 05m 00s<br>tst_test.c:1115: TINFO: btrfs is supported by the test<br>tst_=
device.c:88: TINFO: Found free device 0 &#39;/dev/loop0&#39;<br>loop0: dete=
cted capacity change from 0 to 2048<br>tst_device.c:522: TINFO: Debug: Devi=
ce numbers: 0/14</div><div class=3D"gmail_quote">tst_device.c:527: TINFO: D=
ebug: 15 1 0:13 / / rw,relatime - btrfs /dev/root rw,space_cache,subvolid=
=3D5,subvol=3D/<br>tst_device.c:527: TINFO: Debug: 16 15 0:5 / /dev rw,rela=
time - devtmpfs devtmpfs rw,size=3D505416k,nr_inodes=3D126354,mode=3D755<br=
>tst_device.c:527: TINFO: Debug: 14 15 0:15 / /proc rw,relatime - proc proc=
 rw<br>tst_device.c:527: TINFO: Debug: 17 16 0:16 / /dev/pts rw,relatime - =
devpts devpts rw,gid=3D5,mode=3D620,ptmxmode=3D666<br>tst_device.c:527: TIN=
FO: Debug: 18 16 0:17 / /dev/shm rw,relatime - tmpfs tmpfs rw,mode=3D777<br=
>tst_device.c:527: TINFO: Debug: 21 15 0:20 / /sys rw,relatime - sysfs sysf=
s rw<br>tst_device.c:543: TINFO: Debug: devneme=3D<br>tst_device.c:545: TBR=
OK: Cannot find block device for /tmp/iocz4RUVG/test.img<br><br>Summary:<br=
>passed =C2=A0 0<br>failed =C2=A0 0<br>broken =C2=A0 1<br>skipped =C2=A00<b=
r>warnings 0<br># ln -s /dev/sda /dev/root<br># /usr/lib/ltp-testsuite/test=
cases/bin/ioctl_loop05<br>tst_test.c:1363: TINFO: Timeout per run is 0h 05m=
 00s<br>tst_test.c:1115: TINFO: btrfs is supported by the test<br>tst_devic=
e.c:88: TINFO: Found free device 0 &#39;/dev/loop0&#39;<br>loop0: detected =
capacity change from 0 to 2048<br>tst_device.c:522: TINFO: Debug: Device nu=
mbers: 0/14</div><div class=3D"gmail_quote">tst_device.c:527: TINFO: Debug:=
 15 1 0:13 / / rw,relatime - btrfs /dev/root rw,space_cache,subvolid=3D5,su=
bvol=3D/<br>tst_device.c:527: TINFO: Debug: 16 15 0:5 / /dev rw,relatime - =
devtmpfs devtmpfs rw,size=3D505416k,nr_inodes=3D126354,mode=3D755<br>tst_de=
vice.c:527: TINFO: Debug: 14 15 0:15 / /proc rw,relatime - proc proc rw<br>=
tst_device.c:527: TINFO: Debug: 17 16 0:16 / /dev/pts rw,relatime - devpts =
devpts rw,gid=3D5,mode=3D620,ptmxmode=3D666<br>tst_device.c:527: TINFO: Deb=
ug: 18 16 0:17 / /dev/shm rw,relatime - tmpfs tmpfs rw,mode=3D777<br>tst_de=
vice.c:527: TINFO: Debug: 21 15 0:20 / /sys rw,relatime - sysfs sysfs rw<br=
>tst_device.c:543: TINFO: Debug: devneme=3D<br>tst_device.c:545: TBROK: Can=
not find block device for /tmp/ioctVo52r/test.img<br><br>Summary:<br>passed=
 =C2=A0 0<br>failed =C2=A0 0<br>broken =C2=A0 1<br>skipped =C2=A00<br>warni=
ngs 0<br>#</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_qu=
ote">a stat on the /, results in a couple of minor/major that is different =
from the=C2=A0</div><div class=3D"gmail_quote">couple listed in the mountin=
fo. This leads, as a result, a test failure.</div><div class=3D"gmail_quote=
"><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; This solution requires sysfs to be mounted in /sys, but considering ma=
ny=C2=A0<br>
&gt; tests depends on the same, including the ioctl_loop05 that triggered t=
his=C2=A0<br>
&gt; patch, this requirement is not too restricted, and the old mountinfo c=
an be=C2=A0<br>
&gt; dropped altogether.<br>
<br>
The mountinfo method is not such a maintenance issue that it needs to be<br=
>
removed IMO. Possibly it could be replaced by tst_stat_mount_dev<br>
instead, but we&#39;re cautious about touching this function.<br></blockquo=
te><div><br></div><div>tst_find_backing_dev(), the function that is the tar=
get of this patch, seems to=C2=A0</div><div>be referenced in only a couple =
of points in all the LTP test suite.<br>One place is in the ioctl_loop05 te=
st, the other reference I found is in the=C2=A0</div><div>lib/tst_device.c =
- tst_dev_block_size().=C2=A0 tst_dev_block_size() is a function=C2=A0<br><=
/div><div>that seems not to be referenced by any test.</div><div>=C2=A0<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
To be clear, I&#39;m not sure anyone compiles Linux without /sys then tries=
<br>
to run LTP on it. However the fact that it is possible to remove /sys is<br=
>
another signal (in addition to BTRFS) that the situation is complicated.<br=
></blockquote><div><br></div><div>Indeed, if we want to have a test that wo=
rks in all the possible scenarios,=C2=A0</div><div>it needs additional work=
.=C2=A0</div><div>But IMHO, keeping the mountinfo strategy gives no advanta=
ge over not=C2=A0</div><div>having it.=C2=A0</div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; $ sudo /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05<br>
&gt; tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s<br>
&gt; tst_test.c:1115: TINFO: ext2/ext3/ext4 is supported by the test<br>
&gt; tst_device.c:91: TINFO: Found free device 0 &#39;/dev/loop0&#39;<br>
&gt; loop0: detected capacity change from 0 to 2048<br>
&gt; tst_device.c:570: TINFO: Device name retrived through mountinfo<br>
&gt; ioctl_loop05.c:126: TINFO: backing dev(/dev/root) logical_block_size i=
s 512<br>
&gt; ioctl_loop05.c:62: TINFO: Without setting lo_offset or sizelimit<br>
&gt; ioctl_loop05.c:45: TINFO: In dio mode<br>
&gt; ioctl_loop05.c:48: TPASS: lo_flags has LO_FLAGS_DIRECT_IO flag<br>
&gt; ioctl_loop05.c:52: TBROK: Failed to open FILE &#39;/sys/block/loop0/lo=
op/dio&#39; for reading: ENOENT (2)<br>
&gt;<br>
&gt; Summary:<br>
&gt; passed=C2=A0 =C2=A01<br>
&gt; failed=C2=A0 =C2=A00<br>
&gt; broken=C2=A0 =C2=A01<br>
&gt; skipped=C2=A0 0<br>
&gt; warnings 0<br>
&gt;<br>
&gt; The example here shows what happen if sysfs is not mounted and the<br>
&gt; mountinfo method is used: the tests that depends on sysfs fail with<br=
>
&gt; broken and not just warn.<br>
&gt;<br>
&gt; Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@su=
se.com" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br>
&gt; Signed-off-by: Alessandro Carminati &lt;<a href=3D"mailto:alessandro.c=
arminati@gmail.com" target=3D"_blank">alessandro.carminati@gmail.com</a>&gt=
;<br>
&gt; ---<br>
&gt;=C2=A0 lib/tst_device.c | 41 ++++++++++-------------------------------<=
br>
&gt;=C2=A0 1 file changed, 10 insertions(+), 31 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/tst_device.c b/lib/tst_device.c<br>
&gt; index 8419b80c3..4ccb71ac8 100644<br>
&gt; --- a/lib/tst_device.c<br>
&gt; +++ b/lib/tst_device.c<br>
&gt; @@ -520,48 +520,27 @@ void tst_find_backing_dev(const char *path, char=
 *dev)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct stat buf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0FILE *file;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0char line[PATH_MAX];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0char *pre =3D NULL;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0char *next =3D NULL;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned int dev_major, dev_minor, line_mjr, line=
_mnr;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned int len, best_match_len =3D 1;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0char mnt_point[PATH_MAX];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int dev_major, dev_minor;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char uevent_path[PATH_MAX];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char dev_name[NAME_MAX];<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (stat(path, &amp;buf) &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brkm(TWARN |=
 TERRNO, NULL, &quot;stat() failed&quot;);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0*dev =3D &#39;\0&#39;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_major =3D major(buf.st_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_minor =3D minor(buf.st_dev);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0file =3D SAFE_FOPEN(NULL, &quot;/proc/self/mounti=
nfo&quot;, &quot;r&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0*dev =3D &#39;\0&#39;;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0while (fgets(line, sizeof(line), file)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sscanf(line, &quo=
t;%*d %*d %d:%d %*s %s&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;line_mjr, &amp;line_mnr, mnt_point) !=3D 3)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0continue;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pre =3D strstr(line, =
&quot; - &quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pre =3D strtok_r(pre,=
 &quot; &quot;, &amp;next);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pre =3D strtok_r(NULL=
, &quot; &quot;, &amp;next);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pre =3D strtok_r(NULL=
, &quot; &quot;, &amp;next);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sprintf(uevent_path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;/sys/dev/block/=
%d:%d/uevent&quot;, dev_major, dev_minor);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (line_mjr =3D=3D d=
ev_major &amp;&amp; line_mnr =3D=3D dev_minor) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0strcpy(dev, pre);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!access(uevent_path, R_OK)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FILE_LINES_SCANF(NULL=
, uevent_path, &quot;DEVNAME=3D%s&quot;, dev_name);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D count_match_l=
en(path, mnt_point);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &gt; best_mat=
ch_len) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0strcpy(dev, pre);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0best_match_len =3D len;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev_name[0])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0sprintf(dev, &quot;/dev/%s&quot;, dev_name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0SAFE_FCLOSE(NULL, file);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!*dev)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brkm(TBROK, NULL,=
 &quot;Cannot find block device for %s&quot;, path);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (stat(dev, &amp;buf) &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brkm(TWARN |=
 TERRNO, NULL, &quot;stat(%s) failed&quot;, dev);<br>
<br>
<br>
-- <br>
Thank you,<br>
Richard.<br></blockquote><div><br>Thank you for your time.</div><div>Alessa=
ndro=C2=A0<br></div></div></div>

--0000000000006bf99f05ec08bc5f--

--===============0188338312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0188338312==--
