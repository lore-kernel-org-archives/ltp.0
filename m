Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PzuUS-0004X2-Jf
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 17:26:32 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PzuUQ-0000r5-Bv
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 17:26:32 +0000
Received: by wyb40 with SMTP id 40so2131785wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Mar 2011 10:26:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1300290346-26901-1-git-send-email-czhang@redhat.com>
References: <1300290346-26901-1-git-send-email-czhang@redhat.com>
Date: Wed, 16 Mar 2011 10:26:24 -0700
Message-ID: <AANLkTi=FoS-qWsvxH0YegaLfywCrOqfvNOS1bpCMW+aY@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2 2/2] fs: fsstress: fix compile when -DNO_XFS
	disabled
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: czhang@redhat.com
Cc: ltp-list@lists.sourceforge.net

On Wed, Mar 16, 2011 at 8:45 AM,  <czhang@redhat.com> wrote:
> From: Caspar Zhang <czhang@redhat.com>
>
> When -DNO_XFS disabled in Makefile, the compilation couldn't pass and
> many errors and warnings outputed. This patch fixes this issue.
>
> v2: modify CPPFLAGS to LDLIBS

    Once upon a time I assume this worked for someone when compiling
on legacy systems. Please add any and all necessary autoconf tests for
these headers.
Thanks,
-Garrett

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
