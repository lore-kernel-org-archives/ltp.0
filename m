From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Sep 2015 12:45:04 +0200
Subject: [LTP] [PATCH v2] avoid triggering config.mk/features.mk target
 in clean tree
In-Reply-To: <a10a17c27f9aa95c40f8852b9def41606ef95af0.1442843410.git.jstancek@redhat.com>
References: <a10a17c27f9aa95c40f8852b9def41606ef95af0.1442843410.git.jstancek@redhat.com>
Message-ID: <20150922104504.GB9955@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
> index 9c757e35e455..a7674141c83c 100644
> --- a/include/mk/env_pre.mk
> +++ b/include/mk/env_pre.mk
> @@ -98,8 +98,12 @@ endif
>  # which are filtered below (e.g. clean). However these config files may be
>  # needed for those targets (eg. the open posix testsuite is not cleaned even if
>  # it's enabled by configure) thus it would be wise to do silent inclusion.
> --include $(abs_top_builddir)/include/mk/config.mk
> --include $(abs_top_builddir)/include/mk/features.mk
> +ifneq ($(wildcard $(abs_top_builddir)/include/mk/config.mk),)
> +include $(abs_top_builddir)/include/mk/config.mk
> +endif
> +ifneq ($(wildcard $(abs_top_builddir)/include/mk/features.mk),)
> +include $(abs_top_builddir)/include/mk/features.mk
> +endif
>  
>  # autotools, *clean, and help don't require config.mk, features.mk, etc...
>  ifeq ($(filter autotools %clean .gitignore gitignore.% help,$(MAKECMDGOALS)),)

Looks good to me (thanks for fixing this). Also notice that we have
nearly identical patch from Yuriy Kolerov ([LTP] [PATCH] Fix including
config.mk and features.mk in env_pre.mk) sent to the list.

-- 
Cyril Hrubis
chrubis@suse.cz
