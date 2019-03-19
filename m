From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Mar 2019 12:28:15 +0100
Subject: [LTP] [PATCH v2] setpriority01: Skip only PRIO_USER when unable
 to add test user
In-Reply-To: <20190319103140.GD6204@rei>
References: <20190307233154.12873-1-saravanak@google.com>
 <20190319083210.GB26794@dell5510> <20190319100348.GA6204@rei>
 <20190319102803.GA13634@dell5510> <20190319103140.GD6204@rei>
Message-ID: <20190319112815.GA19707@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > > > I still think v1 is the right approach. But if you want TCONF for only
> > > > > for cases like Android where useradd itself isn't present, then v2 would
> > > > > be the right patch.
> > > > Agree with it, but waiting for Cyril approval to merge it.

> > > As far as I can tell this patch still removes the read-only rootfs check
> > > introduced in:
> > Good catch, eaccess check should stay in.
> > I'll put it back again and push, ok?

> Or we can check the return value 1 from useradd and map it to TCONF as
> suggested by Saravana.
Probably. According to useradd sources, exit 1 (E_PW_UPDATE) also happen when
problems to lock /etc/passwd, which could theoretically on different
circumstance than read-only /, but I guess we can ignore it.

Or we could use statvfs to detect read-only / ("can't update password file" does
can be for different purposes), but I wouldn't bother and user return value 1.

Kind regards,
Petr

[1] https://github.com/shadow-maint/shadow/blob/master/src/useradd.c#L1626
