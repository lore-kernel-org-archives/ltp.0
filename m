From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 Apr 2019 22:38:55 +0200
Subject: [LTP]
 =?utf-8?b?5Zue5aSN77yaW1BBVENIIHYxXSBpbmNsdWRlL21rL2Vudl9w?=
 =?utf-8?q?ost=2Emk=3A_enable_=5F=5FANDROID=5F=5F_definition_for_Android_b?=
 =?utf-8?q?uild?=
In-Reply-To: <afb2deac-ba5a-ba2f-2481-5bc0ed6bc3c0@xiaopeng.com>
References: <5bad3463-5c4f-2b70-6500-70d715fd3181@xiaopeng.com>
 <20190412062814.GA18106@dell5510>
 <ee797e09-e650-4869-60b7-f6e8e32844bb@xiaopeng.com>
 <20190412194809.GE124555@google.com>
 <11cb4fc5-c37a-adfd-831c-257c815849db@xiaopeng.com>
 <20190417163923.GG124555@google.com> <20190417170651.GA26229@x230>
 <aafe58ce-e74d-b350-4e91-445683c120fc@xiaopeng.com>
 <20190421221030.GA11307@x230>
 <afb2deac-ba5a-ba2f-2481-5bc0ed6bc3c0@xiaopeng.com>
Message-ID: <20190423203855.GA28635@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Zhengwang,


> -------- Original Message --------
> From: Petr Vorel
> Sent: Mon, 22 Apr 2019 00:10:30 +0200
> To: Zhengwang Ruan
> Cc: Sandeep Patil, Ltp, Steve Muckle
> Subject: Re: [LTP] 回复：[PATCH v1] include/mk/env_post.mk : enable
> __ANDROID__ definition for Android build
> > Hi Sandeep, Zhengwang,

> > > > I don't know why autotools fails preadv and pwritev detection with AC_CHECK_FUNCS.
> > > > I considered it as problem of my setup, but maybe it's an autotools bug.
> > > I also encountered this issue, but I temporarily walked around it by
> > > applying the following patch.
> > > ==================
> > > $ git diff testcases/
> > > diff --git a/testcases/commands/ldd/datafiles/Makefile
> > > b/testcases/commands/ldd/datafiles/Makefile
> > > index d8bcf5c..74fbe50 100644
> > > --- a/testcases/commands/ldd/datafiles/Makefile
> > > +++ b/testcases/commands/ldd/datafiles/Makefile
> > > @@ -30,7 +30,7 @@ CLEAN_TARGETS         += *.obj $(LDD_SO_FILES)
> > >          $(CC) $(CFLAGS) -shared -o $@ $^
> > >   lddfile.out: main.o $(LDD_SO_FILES)
> > > -       $(CC) $(CFLAGS) -O -o $@ $?
> > > +       $(CC) $(CFLAGS) $(LDFLAGS) -O -o $@ $?
> > What is this change for?

> This is a really long story. In my build, I need to use '-nostdlib 
> /ndk/path/to/crtend_android.o /ndk/path/to/crtbegin_dynamic.o' as linker
> arguments to cross-compile, and I have to put these arguments into LDFLAGS
> since there were other errors occurred on linking *.o to executable if I put
> them into CFLAGS.

> Right here, lddfile.out is an executable and obviously needed to be linked,
> therefore LDFLAGS must be required in my case.

Thanks for info. Feel free to send a patch with a long description.

Back to the patch: I'm willing to merge it, just wait if any from Sandeep or
Steve (or any other android developer) will ack it.


Kind regards,
Petr
