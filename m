From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Jan 2021 14:39:31 +0100
Subject: [LTP] [PATCH v2 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <YAbfKSZhZ35peObS@yuki.lan>
References: <20210118161308.30771-1-pvorel@suse.cz> <YAbfKSZhZ35peObS@yuki.lan>
Message-ID: <YAbhE9eB1AEM1BEk@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > +	char buf[PATH_MAX], module[PATH_MAX], search[PATH_MAX] = "/";
...
> > +	strcat(search, driver);
> > +	strcat(search, ".ko");

> Why not just snprintf() or SAFE_ASPRINTF() here as well?
+1

> > +	f = SAFE_FOPEN(NULL, path, "r");
> > +
> > +	while (fgets(buf, sizeof(buf), f)) {
> > +		if (sscanf(buf, "%s", module) != 1)
> > +			continue;
> > +
> > +		if (strstr(module, search) != NULL) {

> And I'm not sure that this is safe either, what about the case that one
> module name is a substring of another.

> E.g. if we look for "foo.ko" and the file contains "this_is_not_foo.ko"
> it will still match here.
char search[PATH_MAX] = "/"; => we search for "/foo.ko"
But that will be more obvious when I use SAFE_ASPRINTF() for search.

> Also this seems to be rather distruptive change, so I guess it would be
> safer to apply after the release.

I'll send v3, but no problem to postpone it.

But I'll revert 305a78e4c ("tst_net.sh: Require veth for netns") with
explanation that it wait for this fix, ok?

Kind regards,
Petr
