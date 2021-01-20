From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Jan 2021 13:11:35 +0100
Subject: [LTP] [PATCH v2 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <a60fb78b-4441-4f17-d0c2-db50292cfde6@jv-coder.de>
References: <20210118161308.30771-1-pvorel@suse.cz> <YAaNR0PzZt5A1Fjm@pevik>
 <a60fb78b-4441-4f17-d0c2-db50292cfde6@jv-coder.de>
Message-ID: <YAgd95cI0527bXa8@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi J?rg,

> Hi,

> On 1/19/2021 8:41 AM, Petr Vorel wrote:
> > Hi,

> > > diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
> > ...
> > > -int tst_check_driver(const char *name)
> > > +#ifndef __ANDROID__
> > > +# define MODULES_DIR "/lib/modules"
> > > +#else
> > > +# define MODULES_DIR "/system/lib/modules"
> > > +#endif
> > OK, MODULES_DIR is not needed now as I kept Android skipped (unless somebody
> > contributes code or share algorithm for Android).
> I don't get this comment. MODULES_DIR is used in both code paths in
> tst_search_driver.
Please have look at v3, where I removed MODULES_DIR
https://patchwork.ozlabs.org/project/ltp/patch/20210119160316.4776-2-pvorel@suse.cz/

> But you don't call it from tst_check_driver only if it is not android.
> If tst_search_driver is supposed to be a new public interface, it should be
> added to the header,
> otherwise it should be marked static.
+1 I'll make it static.

Kind regards,
Petr

> J?rg
