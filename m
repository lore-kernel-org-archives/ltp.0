From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Nov 2020 16:15:03 +0100
Subject: [LTP] [PATCH v2] Add tst_secureboot_enabled() helper function
In-Reply-To: <9d91a462-9aa1-eb1f-6bfc-c2db28967840@suse.cz>
References: <20201109133245.10879-1-mdoucha@suse.cz>
 <20201109135627.GA18105@yuki.lan>
 <9d91a462-9aa1-eb1f-6bfc-c2db28967840@suse.cz>
Message-ID: <20201109151503.GA15566@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin, Cyril,

...
> >> diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
> >> index 427608a17..cffd11245 100644
> >> --- a/include/mk/config.mk.in
> >> +++ b/include/mk/config.mk.in
> >> @@ -56,8 +56,8 @@ libdir			:= @libdir@
> >>  mandir			:= @mandir@

> >>  CPPFLAGS		:= @CPPFLAGS@
> >> -CFLAGS			:= @CFLAGS@
> >> -LDLIBS			:= @LIBS@
> >> +CFLAGS			:= @CFLAGS@ @EFIVAR_CFLAGS@
> >> +LDLIBS			:= @LIBS@ @EFIVAR_LIBS@

> > Please do not do this.

> > This should be handled like any other library, i.e. we should define
> > EFIVAR_CFLAGS and EFIVAR_LIBS and use them in respective Makefile.
+1 (and sorry for overlooking this).

Kind regards,
Petr
