From: Sandeep Patil <sspatil@google.com>
Date: Tue, 5 Sep 2017 14:49:40 -0700
Subject: [LTP] [PATCH] android: access02: fix the executable shell path
In-Reply-To: <20170829150902.exez45likikktnk3@dell5510>
References: <20170828223100.66766-1-sspatil@google.com>
 <20170829120853.GF31839@rei.lan>
 <20170829150446.gramj52fr3vn7cgw@dell5510>
 <20170829150902.exez45likikktnk3@dell5510>
Message-ID: <20170905214940.GS84377@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 29, 2017 at 05:09:03PM +0200, Petr Vorel wrote:
> Hi,
> 
> > > BTW: There is _PATH_TMP defined in that header as well, is that one present
> > >      on android as well? If so and if it's pointing to something
> > >      sensible we could have used that one in the getcwd test...
> 
> > _PATH_TMP is defined in all API versions, so possible to use it.
> Sorry, it is defined, but has the same value ("/tmp/"), so not much useful for us.
> This should be fixed in Android.

No _PATH_TMP isn't defined in bionic, *most* of the library code depends on
$TMPDIR which is set by Init.

(The only exception as far as I see is tempnam() implementation which also
uses _PATH_TMP as a failsafe to $TMPDIR environment variable being available.)

- ssp
