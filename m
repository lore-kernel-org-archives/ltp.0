From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Mar 2019 11:03:49 +0100
Subject: [LTP] [PATCH v2] setpriority01: Skip only PRIO_USER when unable
 to add test user
In-Reply-To: <20190319083210.GB26794@dell5510>
References: <20190307233154.12873-1-saravanak@google.com>
 <20190319083210.GB26794@dell5510>
Message-ID: <20190319100348.GA6204@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > v2:
> > - Skip only PRIO_USER test when useradd isn't present
> > - Fail entire test with TBROK for all other cases where user can't be added
> 
> > I still think v1 is the right approach. But if you want TCONF for only
> > for cases like Android where useradd itself isn't present, then v2 would
> > be the right patch.
> Agree with it, but waiting for Cyril approval to merge it.

As far as I can tell this patch still removes the read-only rootfs check
introduced in:

commit 8cab24427ec4584389cd0462eb87bd9d43261861
Author: the_hoang0709@yahoo.com <the_hoang0709@yahoo.com>
Date:   Sun Apr 9 15:38:05 2017 +0700

    setpriority01: Fix failure on read-only machine

    Return 32 if /etc/passwd is read-only.
    Fixes: #137
    See also: #88


-- 
Cyril Hrubis
chrubis@suse.cz
