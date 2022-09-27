Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF86C6FA83
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 07:10:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BCD63CAE21
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 09:10:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C373A3CAB07
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 09:09:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E27F41000A3C
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 09:09:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 04B9B21A59;
 Tue, 27 Sep 2022 07:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664262589;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBO5Ll5T26ISj4+3SLV0T0Rq8FoxBBzyURYY3yG02SY=;
 b=hJ8XS4ifZeHsDQn4GcE4vvoyzKu/IjkTq2oCkUq+JWhnod1EQDXBvqtCUth11s3ZPgkoEj
 nt1eC8h6FYd1FfzH6SB3T2Fm191Ul3AVR9JWdvLUm1hEFKAgIODeUcJb7ycozv2NF6e/FQ
 eaHIuZeFW2+nyglodcJSw7H4NaKEHf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664262589;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBO5Ll5T26ISj4+3SLV0T0Rq8FoxBBzyURYY3yG02SY=;
 b=ptNf+6iOGkyibrjhbFsMkEqI2aNJuPxyT7xaAtxSnf7QsJgdFzcqzBAbWlFAI2uP/63gni
 BHpv8xDUbIFePPCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB2C2139BE;
 Tue, 27 Sep 2022 07:09:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MsapL7yhMmMZcQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 27 Sep 2022 07:09:48 +0000
Date: Tue, 27 Sep 2022 09:09:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Marcos Paulo de Souza <mpdesouza@suse.de>
Message-ID: <YzKhupSYwltx6P3N@pevik>
References: <20220926165949.23407-1-mpdesouza@suse.com>
 <YzH86TOjFZj3cUwq@pevik> <20220926221732.xj7mcxswq4dixzcd@daedalus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220926221732.xj7mcxswq4dixzcd@daedalus>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: Fix redefinition of mount_attr by
 checking sys/mount.h
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Marcos,

...
> > > +++ b/configure.ac
> > > @@ -71,6 +71,7 @@ AC_CHECK_HEADERS_ONCE([ \
> > >      sys/epoll.h \
> > >      sys/fanotify.h \
> > >      sys/inotify.h \
> > > +    sys/mount.h \

> > Well, we don't add check for this, as sys/mount.h has been here since "ever", so
> > it'd just make configure little bit slower for no gain.

> > But you'd have to use somewhere compiler macro #ifdef HAVE_SYS_MOUNT_H, as this
> > macro is generated by configure script. Adding header to the list does nothing.

> It wasn't needed in my case, let me explain better below.
Interesting, maybe I'm missing something.

> > You obviously wanted to fix something, could you post the problem you're trying
> > to solve + steps you did to ML?

> I was seeing redefinition problems:

> In file included from fsconfig01.c:9:
> ../../../../include/lapi/fsmount.h:55:8: error: redefinition of 'struct mount_attr'
>    55 | struct mount_attr {
>       |        ^~~~~~~~~~
> In file included from /usr/include/sys/mount.h:32,
>                  from ../../../../include/lapi/fsmount.h:14:
> /usr/include/linux/mount.h:129:8: note: originally defined here
>   129 | struct mount_attr {
>       |        ^~~~~~~~~~
> ../../../../include/lapi/fsmount.h:110:19: error: conflicting types for 'mount_setattr'; have 'int(int,  const char *, unsigned int,  struct mount_attr *, size_t)' {aka 'int(int,  const char *, unsigned int,  struct mount_attr *, long unsigned int)'}
>   110 | static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned int flags,
>       |                   ^~~~~~~~~~~~~
> In file included from fsconfig02.c:8:
> ../../../../include/lapi/fsmount.h:55:8: error: redefinition of 'struct mount_attr'
>    55 | struct mount_attr {
>       |        ^~~~~~~~~~
> /usr/include/sys/mount.h:316:12: note: previous declaration of 'mount_setattr' with type 'int(int,  const char *, unsigned int,  struct mount_attr *, size_t)' {aka 'int(int,  const char *, unsigned int,  struct mount_attr *, long unsigned int)'}
>   316 | extern int mount_setattr (int __dfd, const char *__path, unsigned int __flags,
>       |            ^~~~~~~~~~~~~
> In file included from /usr/include/sys/mount.h:32,
>                  from ../../../../include/lapi/fsmount.h:14:
> /usr/include/linux/mount.h:129:8: note: originally defined here
>   129 | struct mount_attr {
>       |        ^~~~~~~~~~
> ../../../../include/lapi/fsmount.h:110:19: error: conflicting types for 'mount_setattr'; have 'int(int,  const char *, unsigned int,  struct mount_attr *, size_t)' {aka 'int(int,  const char *, unsigned int,  struct mount_attr *, long unsigned int)'}
>   110 | static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned int flags,
>       |                   ^~~~~~~~~~~~~
> /usr/include/sys/mount.h:316:12: note: previous declaration of 'mount_setattr' with type 'int(int,  const char *, unsigned int,  struct mount_attr *, size_t)' {aka 'int(int,  const char *, unsigned int,  struct mount_attr *, long unsigned int)'}
>   316 | extern int mount_setattr (int __dfd, const char *__path, unsigned int __flags,
>       |            ^~~~~~~~~~~~~
> make[4]: *** [../../../../include/mk/rules.mk:45: fsconfig01] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[4]: *** [../../../../include/mk/rules.mk:45: fsconfig02] Error 1
> make[3]: *** [../../../include/mk/generic_trunk_target.inc:108: all] Error 2
> make[2]: *** [../../include/mk/generic_trunk_target.inc:108: all] Error 2
> make[1]: *** [../include/mk/generic_trunk_target.inc:108: all] Error 2
> make[1]: Leaving directory '/home/mpdesouza/git/ltp/testcases'
> make: *** [Makefile:106: testcases-all] Error 2

> In my TW system I found that the struct mount_attr was being defined in
> sys/mount.h. Checking include/lapi/fsmount.h I found some ifdefs:

> ...
> #ifndef HAVE_STRUCT_MOUNT_ATTR
> /*
>  * mount_setattr()
>  */
> struct mount_attr {
>         uint64_t attr_set;
>         uint64_t attr_clr;
>         uint64_t propagation;
>         uint64_t userns_fd;
> };
> #endif
> ...

> #ifndef HAVE_MOUNT_SETATTR
> static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned int flags,
>                                 struct mount_attr *attr, size_t size)
> {
>         return tst_syscall(__NR_mount_setattr, dirfd, from_pathname, flags,
>                            attr, size);
> }
> #endif /* HAVE_MOUNT_SETATTR */

> So, only adding the sys/mount.h entry to the headers list is enough to make
> autoconf to find that sys/mount.h defines the same struct and function, fixing
> the issue.
Hm, I'm likely missing something :).

$ rpm -q glibc
glibc-2.36-5.1.x86_64

$ grep -B2 '^struct mount_attr' /usr/include/sys/mount.h
#ifndef MOUNT_ATTR_SIZE_VER0
/* For mount_setattr.  */
struct mount_attr

=> I'm not sure who/where is supposed to define MOUNT_ATTR_SIZE_VER0.
Is it in your config?
Do you have different config than mine?

grep MOUNT include/config.h
#define HAVE_FSMOUNT 1
#define HAVE_LINUX_MOUNT_H 1
#define HAVE_MOUNT_SETATTR 1
#define HAVE_MOVE_MOUNT 1
#define HAVE_STRUCT_MOUNT_ATTR 1
(i.e. HAVE_STRUCT_MOUNT_ATTR found with code in current master)

I also tested fedora rawhide (glibc 2.36.9000), which we don't have in our CI:
https://github.com/pevik/ltp/actions/runs/3133529596
Works well.

> > BTW I have no problem to build locally on the latest Tumbleweed. Also LTP
> > package build for Tumbleweed is also fine:
> > https://build.opensuse.org/package/binaries/benchmark:ltp:devel/ltp/openSUSE_Factory
> > https://build.opensuse.org/package/binaries/benchmark:ltp:devel/ltp/openSUSE_Tumbleweed

> Interesting... so is there anything wrong with my setup? Am I missing something?

Hard to tell. Could you share your commands?
I suppose it's the usual: use gcc and in the root directory:
make autotools && ./configure && make -j`nproc`

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
