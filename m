Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E6C38A2D
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 09:16:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 438F93CA3B0
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 11:16:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C55733C4D65
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 11:16:03 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 353571A0092B
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 11:16:03 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id t15so559859edd.4
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oym61uOuT8q1PQ7OFWe0w5zcYjdIaRuuEemzohU6pfU=;
 b=oQvLYrizmJ7oxAqgWsBo6ts2rGt58flfMvcghdQLeNF3VJYC6gtU+WOYNXlLDBbWxg
 C89gzXMowWnXeFzFZ7gIjUOhEoyvuU7CULvzX4lSXJcua/IqtMG58u7tr3v+rOAQgNtq
 0S31h8NYTPiux8pclFyOiqDeKGFfMbTMc8P/8CDxfHP/GUv+25UtpgnB4W0EFUMroosn
 jynKquISyS8VBwZnM5tfghmsJYCl8EL9OXVIe/YEbVF7Uv8W4M5H5K9gmIi925oFXtcv
 D5WJMVlIBOZOPnZox5jy33gbtsq3L2L+pablDTgh0a69K2gGx346d3K9aFiusjSh8Wna
 K2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oym61uOuT8q1PQ7OFWe0w5zcYjdIaRuuEemzohU6pfU=;
 b=m1sTw7Y0/15KgtoDQhv84GKxVFyvIMzTDd6yON315sZanuxlnbOTih7B8eR5xvVjSB
 +wZ2WQzW2L9DYwX/EEqyThqPvjY0mzz3qo9T+u6q3cLzOjLMCa0rvIHjXGSdd8bgmIZ2
 oh5tmjlWvBhgHfOPs+whP6riBlUezcDBDXm0MvNA4QClCoZ9DqX0WtK+CuHw+e3eUO+I
 ThfPBkyJbAWP+4KG5jGOigqHlIyEX8q8pyjQclWed/VCWLnYbFBpehBUbnKp9go8Rg33
 MRTyAqaRowUn0w6trY601+FpJirHArOzPaxR0XyrZh3HxY1hhSKXlN5hipLTMDDDxXyo
 sqYQ==
X-Gm-Message-State: ACrzQf01X9HSVOluD0JjzdKdfgWlR2vSSSurkxi9AVnmorN00+aFKLap
 XvMMd1ybYDtvIihQJ5t/0PYmWQG+Yw4=
X-Google-Smtp-Source: AMsMyM7AIl+yua42Yh89OXxyuiiCb7DO/nZcqXkcb7yZlhs6JVo4WItRma5jBGR3fjeHuj4Osnas/w==
X-Received: by 2002:a05:6402:2073:b0:461:5462:9dc9 with SMTP id
 bd19-20020a056402207300b0046154629dc9mr19504792edb.52.1666689362570; 
 Tue, 25 Oct 2022 02:16:02 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a1709070b1400b0078d85934cf8sm1070987ejl.111.2022.10.25.02.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Oct 2022 02:16:01 -0700 (PDT)
Date: Tue, 25 Oct 2022 09:11:02 +0000
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y1eoJpgzrOWuX5Op@lab.hqhome163.com>
References: <Y0023HcAOlhfAcJw@lab.hqhome163.com>
 <87o7u1xpz1.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o7u1xpz1.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix tst_find_backing_dev when no initramfs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

mount_root() is the kernel function responsible for mounting the primary
rootfs.
A dynamic there, prevents the /dev/root device node in the not yet mounted
files system. For this reason, in the embedded system that starts without
an initramfs, or however a proper initscript, the /dev/root device appears
into the mount table in the / line.
The test ioctl_loop05 tries to open this /dev/root and fails with a warning.
This patch aims to fix this situation.

Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
---
 lib/tst_device.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 8419b80c3..c67328db3 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -526,6 +526,8 @@ void tst_find_backing_dev(const char *path, char *dev)
        unsigned int dev_major, dev_minor, line_mjr, line_mnr;
        unsigned int len, best_match_len = 1;
        char mnt_point[PATH_MAX];
+       char devnum_info_fn[PATH_MAX];
+       char new_dev_fn_buf[PATH_MAX];

        if (stat(path, &buf) < 0)
                tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
@@ -562,6 +564,20 @@ void tst_find_backing_dev(const char *path, char *dev)
        if (!*dev)
                tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);

+       if (stat(dev, &buf) < 0) && (strcmp("/dev/root", dev)==0) {
+               sprintf(devnum_info_fn, "/sys/dev/block/%d:%d/uevent", dev_major, dev_minor);
+               file = SAFE_FOPEN(NULL, devnum_info_fn, "r");
+               while (fgets(line, sizeof(line), file)) {
+                       if (sscanf(line, "%[^=]=%s", devnum_info_fn, new_dev_fn_buf) != 2)
+                               continue;
+                       if (strcmp("DEVNAME", devnum_info_fn) == 0) {
+                               sprintf(dev, "/dev/%s", new_dev_fn_buf);
+                               break;
+                       }
+               }
+               SAFE_FCLOSE(NULL, file);
+       }
+
        if (stat(dev, &buf) < 0)
                tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);

--
2.34.1

On Mon, Oct 24, 2022 at 02:49:32PM +0100, Richard Palethorpe wrote:
> Hello,
> 
> Alessandro Carminati <alessandro.carminati@gmail.com> writes:
> 
> > mount_root() is the kernel function responsible for mounting the primary
> > rootfs.
> > A dynamic there, prevents the /dev/root device node in the not yet mounted
> > files system. For this reason, in the embedded system that starts without
> > an initramfs, or however a proper initscript, the /dev/root device appears
> > into the mount table in the / line.
> > The test tries to open this /dev/root and fails with a warning.
> > This patch aims to fix this situation.
> 
> Thanks I probably would have hit this issue sooner or later.
> 
> >
> > Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> >
> > typo fixes
> > ---
> >  lib/tst_device.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/lib/tst_device.c b/lib/tst_device.c
> > index 8419b80c3..c3427eb31 100644
> > --- a/lib/tst_device.c
> > +++ b/lib/tst_device.c
> > @@ -526,6 +526,8 @@ void tst_find_backing_dev(const char *path, char *dev)
> >  	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
> >  	unsigned int len, best_match_len = 1;
> >  	char mnt_point[PATH_MAX];
> > +	char tmpbuf1[PATH_MAX];
> > +	char tmpbuf2[PATH_MAX];
> 
> It would be more readable to use three buffers and give them meaningful names.
> 
> >  
> >  	if (stat(path, &buf) < 0)
> >  		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
> > @@ -562,6 +564,24 @@ void tst_find_backing_dev(const char *path, char *dev)
> >  	if (!*dev)
> >  		tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
> >  
> > +	if (stat(dev, &buf) < 0) {
> 
> As there is no harm in calling stat twice; could just do
> 
> if (stat(dev, &buf) < 0) && strcmp("/dev/root", dev) == 0) {
> 
> Or even replace with strcmp with errno == ENOENT and use this as a
> general fallback.
> 
> > +		if (strcmp("/dev/root", dev) != 0) {
> > +			tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
> > +		} else {
> 
> Then remove this if statement
> 
> > +			sprintf(tmpbuf1, "/sys/dev/block/%d:%d/uevent",
> > dev_major, dev_minor);
> > +			file = SAFE_FOPEN(NULL, tmpbuf1, "r");
> > +			while (fgets(line, sizeof(line), file)) {
> > +				if (sscanf(line, "%[^=]=%s", tmpbuf1, tmpbuf2) != 2)
> > +					continue;
> > +				if (strcmp("DEVNAME", tmpbuf1) == 0) {
> > +					sprintf(dev, "/dev/%s", tmpbuf2);
> > +					break;
> > +				}
> > +			}
> > +			SAFE_FCLOSE(NULL, file);
> > +		}
> > +	}
> > +
> >  	if (stat(dev, &buf) < 0)
> >  		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
> >  
> > -- 
> > 2.34.1
> 
> 
> -- 
> Thank you,
> Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
