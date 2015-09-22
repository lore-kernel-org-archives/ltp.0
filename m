From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 22 Sep 2015 06:48:38 -0400 (EDT)
Subject: [LTP] [PATCH v2] avoid triggering config.mk/features.mk target
 in clean tree
In-Reply-To: <20150922104504.GB9955@rei.suse.cz>
References: <a10a17c27f9aa95c40f8852b9def41606ef95af0.1442843410.git.jstancek@redhat.com>
 <20150922104504.GB9955@rei.suse.cz>
Message-ID: <527059952.14929535.1442918918908.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, "yuriy kolerov" <yuriy.kolerov@synopsys.com>
> Sent: Tuesday, 22 September, 2015 12:45:04 PM
> Subject: Re: [PATCH v2] avoid triggering config.mk/features.mk target in clean tree
> 
> Hi!
> > diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
> > index 9c757e35e455..a7674141c83c 100644
> > --- a/include/mk/env_pre.mk
> > +++ b/include/mk/env_pre.mk
> > @@ -98,8 +98,12 @@ endif
> >  # which are filtered below (e.g. clean). However these config files may be
> >  # needed for those targets (eg. the open posix testsuite is not cleaned
> >  even if
> >  # it's enabled by configure) thus it would be wise to do silent inclusion.
> > --include $(abs_top_builddir)/include/mk/config.mk
> > --include $(abs_top_builddir)/include/mk/features.mk
> > +ifneq ($(wildcard $(abs_top_builddir)/include/mk/config.mk),)
> > +include $(abs_top_builddir)/include/mk/config.mk
> > +endif
> > +ifneq ($(wildcard $(abs_top_builddir)/include/mk/features.mk),)
> > +include $(abs_top_builddir)/include/mk/features.mk
> > +endif
> >  
> >  # autotools, *clean, and help don't require config.mk, features.mk, etc...
> >  ifeq ($(filter autotools %clean .gitignore gitignore.%
> >  help,$(MAKECMDGOALS)),)
> 
> Looks good to me (thanks for fixing this). Also notice that we have
> nearly identical patch from Yuriy Kolerov ([LTP] [PATCH] Fix including
> config.mk and features.mk in env_pre.mk) sent to the list.

My apologies, I missed his patch for some reason. I'll test/review his version.

Regards,
Jan


> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
