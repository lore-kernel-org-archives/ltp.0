From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 May 2019 09:30:45 +0200
Subject: [LTP] [PATCH v2 1/2] OVL_MNT: add setup_overlay helper
In-Reply-To: <20190524044850.x6adkl6uen5tgeqw@XZHOUW.usersys.redhat.com>
References: <20190503210005.GA18171@x230>
 <20190515092129.26336-1-xzhou@redhat.com>
 <20190515133102.GA5429@dell5510> <20190515134245.GC5429@dell5510>
 <20190524044850.x6adkl6uen5tgeqw@XZHOUW.usersys.redhat.com>
Message-ID: <20190524073045.GA29592@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Murphy,

> > > +	SAFE_MKDIR(OVL_LOWER"/"DIR_NAME, 0755);
> > > +	SAFE_TOUCH(OVL_LOWER"/"DIR_NAME"/"FILE_NAME, 0644, NULL);
> > > +	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
> > > +		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
> > >  	if (ret < 0) {
> > >  		if (errno == ENODEV) {
> > >  			tst_brk(TCONF,
> > In here in inotify07.c and in inotify08.c you create dirs (0 parameter) for because you it's
> > needed to create more dirs. Than the rest (mount, TCONF on ENODEV, TBROK
> > otherwise) is still copy pasted. I wonder how to move everything into
> > setup_overlay() helper. Maybe struct with files or directories and permissions

> If we define a struct to put names amd modes in it then pass to helper, we
> still need to write all these OVL macros in the testcase to defile the struct.
> So we need to write all the _same_ macros in every testcase where needed.

> In this case, it's against my intention of this patch: dedupe duplicated lines.
Sure, DRY is intention :).

> Your struct idea is great when handling the different files that need to be
> created in different testcases. However I'd like to do it in a simpler way.
> Only make necessary dirs in the helper, let the testcases to create the other
> dirs they want themselves.
I agree with Amir [1] that my original approach [2]: to add
create_overlay_dirs() and mount_overlay() is better as it adds more flexibility
I'll recap my suggestions in v1.

> Thanks,
> Murphy

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2019-May/011983.html
[2] http://lists.linux.it/pipermail/ltp/2019-May/011979.html
