Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Oh3T9-0003dM-Fl
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 16:38:59 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oh3T7-0005Po-BK
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 16:38:59 +0000
Received: by yxi11 with SMTP id 11so3297999yxi.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 05 Aug 2010 09:38:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201008051157.26183.vapier@gentoo.org>
References: <20100805100954.GB11402@saboteur.suse.cz>
	<20100805135324.GB18296@saboteur.suse.cz>
	<D150E027-5380-4B94-A64C-3FD7C8146334@gmail.com>
	<201008051157.26183.vapier@gentoo.org>
Date: Thu, 5 Aug 2010 09:38:51 -0700
Message-ID: <AANLkTikZrHrFS6NiS+JXyThPjti0JqaJ5kYSdkeQh1xH@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] just another make-3.80 bug
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Garrett Cooper <yaneurabeya@gmail.com>

On Thu, Aug 5, 2010 at 8:57 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Thursday, August 05, 2010 09:54:50 Garrett Cooper wrote:
>> On Aug 5, 2010, at 6:53 AM, Cyril Hrubis wrote:
>> >> BTW... calling 1make' bareword never worked with 3.80; all of the the
>> >> directions in INSTALL say use make all [...]; make install. The reason
>> >> being is that make 3.80 didn't have a functional .DEFAULT_GOAL
>> >> equivalent until sometime around midway between make 3.80 and make
>> >> 3.81; so assuming that `make' will function the same as `make all'
>> >> isn't a good assumption to make :).
>> >
>> > So ltp buildsystem is kind of a mine field ;). Anyway as make picks up
>> > first target and makes it default adding "default: all" to the beginning
>> > of env_pre.mk seems to fix that problem for me.
>>
>> Seems like a decent workaround for cases when env_pre.mk is used, but this
>> isn't possible with 3rd party Makefiles, so it might be kind of a moot
>> point.
>>
>> Just to be safe I'd stick with the directions unless you want to submit
>> patches to fix every issue in the source tree :)...
>
> tweaking the top level makefile so the standard `./configure && make` works
> without having to read directions would be nice

    Ok, fair enough :)... please try the attached patch, and if it
works for you I'll commit it. File bugs or send patches if you find
any issues beyond the top-level Makefile.
Thanks,
-Garrett

diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
index 4444124..17a91fa 100644
--- a/include/mk/env_pre.mk
+++ b/include/mk/env_pre.mk
@@ -124,8 +124,13 @@ BUILD_TREE_STATE           := $(BUILD_TREE_NONSRCDIR_INSTAL
 endif
 endif

-# make 3.80 called it .DEFAULT_TARGET.
+ifeq ($(MAKE_3_80_COMPAT),1
+# Trick make 3.80 into thinking that the default goal is all.
+.PHONY: default
+default: all
+else
 .DEFAULT_GOAL                  := all
+endif

 endif  # END autotools, *clean...

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
