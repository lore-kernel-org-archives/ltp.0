Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AEFCCD1AB
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 08:10:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4831A3CF0A3
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 10:10:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55A463CA1FA
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 10:10:19 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3F185600B4F
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 10:10:18 +0200 (CEST)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b550a522a49so5379522a12.2
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 01:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761120617; x=1761725417; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ePywcST/UbYHzI66VBMJAjk1GlQaMlqfpX7Q31qmueU=;
 b=tMN+Lrt/2ZssFukIDwDpxwo2WPNR+KrD4M5ifpDb7evxgOZOn+/TVxodNIX5j8WvFL
 yojqgVingaCUCbZDIah5bdHZ7AMsWKdHfLa8BO0e/09vAm1MpRWk1UP6okmUSkFfq52O
 0T62v3aKXYj4/+Iaoua4e/5dduZvdPKv25CidQV1GqWlXdOKhyrzK06RSxmOdRuhjl6Q
 IxYK3tFrZf1OjC761OVymIDi8WQu2vGWAemYMp4BMdg20m7u2I2hqkm6U3B7Gb1u8HU1
 7XDWuZFKWXxz7zjR+f5f/67biOty8yOF1faCWhKZAXCf2KMoCizDPY3IPiyJwvslMOQP
 PalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761120617; x=1761725417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ePywcST/UbYHzI66VBMJAjk1GlQaMlqfpX7Q31qmueU=;
 b=iUD3SvaNM8aIeDXlsAuMJr4lPH9zzGC8XhazEgK4Dku8tCyOtI2i8m+Bvr/TuSrYhM
 1cScbnWUAM6vVQ/OqT3l4sfCHRrSFpinyoW9s4MgxfEuf+Roc5OA4266WV//t+C6nHXB
 LVpjRM7T8qN9yHp/FqpBzVQdGXpyLducq0GBp+FNXZjGq714U1cF5yd3aOM5RKUek9ZO
 Svs+e259TrhKXnKrVSQ9ALliLKLhIaqPgfLX/bp9m+Z1iMkIkFp/eJmowCboF1S+Ts3O
 QEs3UgRDetPtvWCy6crkI7VgIOE649o+IOU/S15axNdf8HgTgD3NCkcydLGZm72MTUSI
 GXPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJym9ayH4kvqTyn/REBs7cLIcWNQxNuD2EGH++Ahbokc1sbtXUQX2zgvqYMoPTJvJWvL0=@lists.linux.it
X-Gm-Message-State: AOJu0YwP7g+Yv2HVg7Ge46Im1SJJyJioZF+klDG1NeMqmrq/l8xB9N16
 hvAJlukd7dSP45NraxVE6up8DYnNYbf+wr2DpRRvOAznPgwB4jOm9dpgxPL78rhMiJTe7LAwFUZ
 O5zGL8RTGM/wompM2XjUUp/+LuPpHDbdin8W4RzzfCA==
X-Gm-Gg: ASbGncvj5LXH38f0o+jBvqIMFvmeZci/6SIU+EBGq4MDcK4iqZo6Om2+4j0Q/gkIPbL
 MxgUo1iorzWI6lWpEJf0WT/ie5byDpvVHkcA2y+ZIYLdUJpEVFTSWmm5fDLyCpFvYJyICt7chgS
 bVQqUSJh6NE77YRCZlVa0KnduRfnr8NrrxAepH7Vi1skI+XovS83MlUajq9zjpu+UwFt9ZVqlV8
 jbRjnijaffcAMqMBLrDCGmL7TlOfoDKjIOsDOfXwqmr7Lk/ZpKw4APLOgUV08EBzNEMfd+O62mq
 I8zz/Dx6wDAxaIg85zG8N+mGRk2WelYVHQwKls+oVHnENyuxh5q6pGHheARD
X-Google-Smtp-Source: AGHT+IGj17zEPCJE5k/7tAvGPZbSPIFM4H4/9dExqXywN2nx7iL9LUcnSdV7P7vvnmjFDZ5Y7okCulPyPhag9YqyYNA=
X-Received: by 2002:a17:903:46c8:b0:27e:e77f:57f3 with SMTP id
 d9443c01a7336-290c9cb613bmr254571115ad.14.1761120616580; Wed, 22 Oct 2025
 01:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
 <aPIPGeWo8gtxVxQX@yuki.lan>
 <qveta77u5ruaq4byjn32y3vj2s2nz6qvsgixg5w5ensxqsyjkj@nx4mgl7x7o6o>
 <20251021-wollust-biografie-c4d97486c587@brauner>
 <lguqncbotw2cu2nfaf6hwgip6wtrmeg2azvyeht7l56itlomy5@uccupuql3let>
 <20251022075134.GA463176@pevik>
In-Reply-To: <20251022075134.GA463176@pevik>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 22 Oct 2025 13:40:04 +0530
X-Gm-Features: AS18NWBdzsxWz_QgzGvsSbF_tbzntKvd82uq9r2HYtjdHCUwx0XlbeuUCqIBmDg
Message-ID: <CA+G9fYssAU52bWwMiQ4GiRjroWJYgA+CvEFekq6mnkd+9Z-Vng@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL:
 ioctl(pidfd, PIDFD_GET_INFO_SHORT,
 info_invalid) expected EINVAL: ENOTTY (25)
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ben Copeland <benjamin.copeland@linaro.org>, linux-fsdevel@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 22 Oct 2025 at 13:21, Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Tue 21-10-25 15:21:08, Christian Brauner wrote:
> > > On Fri, Oct 17, 2025 at 02:43:14PM +0200, Jan Kara wrote:
> > > > On Fri 17-10-25 11:40:41, Cyril Hrubis wrote:
> > > > > Hi!
> > > > > > > ## Test error log
> > > > > > > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > > > > > > tst_test.c:2021: TINFO: LTP version: 20250930
> > > > > > > tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> > > > > > > @1760657272 aarch64
> > > > > > > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > > > > > > tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> > > > > > > which might slow the execution
> > > > > > > tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> > > > > > > ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> > > > > > > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> > > > > > > info_invalid) expected EINVAL: ENOTTY (25)
>
> > > > > Looking closely this is a different problem.
>
> > > > > What we do in the test is that we pass PIDFD_IOCTL_INFO whith invalid
> > > > > size with:
>
> > > > > struct pidfd_info_invalid {
> > > > >         uint32_t dummy;
> > > > > };
>
> > > > > #define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)
>
>
> > > > > And we expect to hit:
>
> > > > >         if (usize < PIDFD_INFO_SIZE_VER0)
> > > > >                 return -EINVAL; /* First version, no smaller struct possible */
>
> > > > > in fs/pidfs.c
>
>
> > > > > And apparently the return value was changed in:
>
> > > > > commit 3c17001b21b9f168c957ced9384abe969019b609
> > > > > Author: Christian Brauner <brauner@kernel.org>
> > > > > Date:   Fri Sep 12 13:52:24 2025 +0200
>
> > > > >     pidfs: validate extensible ioctls
>
> > > > >     Validate extensible ioctls stricter than we do now.
>
> > > > >     Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > >     Reviewed-by: Jan Kara <jack@suse.cz>
> > > > >     Signed-off-by: Christian Brauner <brauner@kernel.org>
>
> > > > > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > > > > index edc35522d75c..0a5083b9cce5 100644
> > > > > --- a/fs/pidfs.c
> > > > > +++ b/fs/pidfs.c
> > > > > @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
> > > > >                  * erronously mistook the file descriptor for a pidfd.
> > > > >                  * This is not perfect but will catch most cases.
> > > > >                  */
> > > > > -               return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> > > > > +               return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
> > > > >         }
>
> > > > >         return false;
>
>
> > > > > So kernel has changed error it returns, if this is a regression or not
> > > > > is for kernel developers to decide.
>
> > > > Yes, it's mostly a question to Christian whether if passed size for
> > > > extensible ioctl is smaller than minimal, we should be returning
> > > > ENOIOCTLCMD or EINVAL. I think EINVAL would make more sense but Christian
> > > > is our "extensible ioctl expert" :).
>
> > > You're asking difficult questions actually. :D
> > > I think it would be completely fine to return EINVAL in this case.
> > > But traditionally ENOTTY has been taken to mean that this is not a
> > > supported ioctl. This translation is done by the VFS layer itself iirc.
>
> > Now the translation is done by VFS, I agree. But in the past (when the LTP
> > test was written) extensible ioctl with too small structure passed the
> > initial checks, only later we found out the data is too short and returned
> > EINVAL for that case. I *think* we are fine with just adjusting the test to
> > accept the new world order but wanted your opinion what are the chances of
> > some real userspace finding the old behavior useful or otherwise depending
> > on it.
>
> +1, thanks! Is it ok just expect any of these two regardless kernel version?
>
> @Naresh Kamboju will you send a patch to LTP ML?

Sure.
I love to send patches to LTP mailing list.

>
> Kind regards,
> Petr
>
> >                                                               Honza

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
