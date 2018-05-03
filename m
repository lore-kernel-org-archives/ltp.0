From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 May 2018 16:17:32 +0200
Subject: [LTP] [PATCH] setregid: use common user and group names.
In-Reply-To: <20180503140815.uytpnrd7wjcm7tex@dell5510>
References: <20180319200113.106692-1-sspatil@google.com>
 <20180503133144.GB27716@rei>
 <20180503140815.uytpnrd7wjcm7tex@dell5510>
Message-ID: <20180503141731.GC27716@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > FIY this seems cause failures on Debian 9 where I do get failures:
> 
> > setregid03    1  TBROK  :  setregid03.c:198: nobody must be a valid group
> > setregid03    2  TBROK  :  setregid03.c:198: Remaining cases broken
> 
> > setregid04    1  TBROK  :  setregid04.c:126: Couldn't find the `nobody' group
> > setregid04    2  TBROK  :  setregid04.c:126: Remaining cases broken
> Debian has nogroup as group for nobody. Sorry that I overlooked it in "1b7cf9474".
> 
> > I guess that we need a fallback if nobody group does not exist.
> Check for "nogroup"?

Let's just change the code to fallback to nogroup if group nobody does
not exist for the release and then we can think of an more elaborate
solution.

> Or allow to overwrite the group name with env. variable?
>
> BTW I wonder why we need more users than just nobody/nobody or nobody/nogroup.
> I'd be for having env. variable TST_USER and TST_GROUP, with helper, which would check for
> them if they're not defined (similar we use in tst_net.sh), so user wouldn't have to care
> for it.

I would rather go for adding some API to the test library that would
supply the test with useable user and group ids. Something as
.needs_user_id and .needs_group_id to the tst_test structure and then
put all the logic to the test library.

> BTW: code in IDcheck.sh expect difference in Debian, but that's useless (just to report
> it):
> if ! fe "nobody" "$passwd" || ! (fe "nogroup" "$group" || fe "nobody" "$group")
> then
>     MISSING_ENTRY=1
> fi

We should probably get rid of IDcheck.sh I doubt that it's up-to-date
enough to be useful.

-- 
Cyril Hrubis
chrubis@suse.cz
