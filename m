From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 3 May 2018 16:08:15 +0200
Subject: [LTP] [PATCH] setregid: use common user and group names.
In-Reply-To: <20180503133144.GB27716@rei>
References: <20180319200113.106692-1-sspatil@google.com>
 <20180503133144.GB27716@rei>
Message-ID: <20180503140815.uytpnrd7wjcm7tex@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> FIY this seems cause failures on Debian 9 where I do get failures:

> setregid03    1  TBROK  :  setregid03.c:198: nobody must be a valid group
> setregid03    2  TBROK  :  setregid03.c:198: Remaining cases broken

> setregid04    1  TBROK  :  setregid04.c:126: Couldn't find the `nobody' group
> setregid04    2  TBROK  :  setregid04.c:126: Remaining cases broken
Debian has nogroup as group for nobody. Sorry that I overlooked it in "1b7cf9474".

> I guess that we need a fallback if nobody group does not exist.
Check for "nogroup"?
Or allow to overwrite the group name with env. variable?

BTW I wonder why we need more users than just nobody/nobody or nobody/nogroup.
I'd be for having env. variable TST_USER and TST_GROUP, with helper, which would check for
them if they're not defined (similar we use in tst_net.sh), so user wouldn't have to care
for it.

BTW: code in IDcheck.sh expect difference in Debian, but that's useless (just to report
it):
if ! fe "nobody" "$passwd" || ! (fe "nogroup" "$group" || fe "nobody" "$group")
then
    MISSING_ENTRY=1
fi


Kind regards,
Petr
