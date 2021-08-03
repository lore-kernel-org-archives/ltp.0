From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Aug 2021 18:46:46 +0200
Subject: [LTP] [PATCH v7 2/7] test/test_zero_hugepage.sh: Skip test on
 read-only file system
In-Reply-To: <YQkqY3Mdmv4cYsFx@yuki>
References: <20210802173536.19525-1-pvorel@suse.cz>
 <20210802173536.19525-3-pvorel@suse.cz> <YQkLmb3pUPY8cKP8@yuki>
 <YQkps5nZ8gHJSaUQ@pevik> <YQkqY3Mdmv4cYsFx@yuki>
Message-ID: <YQly9swcBhrmqgnB@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > > I wonder if we should rather check if proc is mounted readonly
> > > explicitly since this may hide all kinds of errors.
> > Sure, makes sense, I'll adapt it in v8. It's just not a fun to write tests which
> > you cannot debug on VM, but just pushing to git :(.

> Well I guess that you can remount proc RO on your testing machine with
> something as:

> mount -o remount,ro /proc
Indeed one (very old one) of many of my VMs didn't yell "mount: /proc: mount
point is busy." and actually allowed remount /proc to ro. Nice, thanks for a
tip!

Kind regards,
Petr

