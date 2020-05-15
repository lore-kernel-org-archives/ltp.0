From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 14:26:53 +0200
Subject: [LTP] [PATCH v4 3/4] INSTALL: Remove uClinux and "What's in a
 Path?" sections
In-Reply-To: <20200515113131.GB2364@yuki.lan>
References: <20200515093216.829-1-pvorel@suse.cz>
 <20200515093216.829-4-pvorel@suse.cz>
 <20200515113131.GB2364@yuki.lan>
Message-ID: <20200515122653.GB23472@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > Note about reasonable PATH it's kind of obvious, we don't have to
> > point that out.

> Well that comment is there becuase of openSUSE build service that
> creates a directories with colon in the middle for home directories and
> LTP fails to build in such scenario, which wasn't that obvious, at least
> if I remmeber correctly. And I do not think that other GNU software
> fails to build in such scenario, I think it's really LTP fault because
> we operate on absolute paths because of the out-of-tree build support.
Interesting, thanks for info.

> Anyways the patchset looks fine, and changes to documentation are
> considered low risk, so let's get this into the release.
Thanks, merged.

You can merge pty04 fix and we can release :).

Kind regards,
Petr
