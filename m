From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Aug 2017 17:09:03 +0200
Subject: [LTP] [PATCH] android: access02: fix the executable shell path
In-Reply-To: <20170829150446.gramj52fr3vn7cgw@dell5510>
References: <20170828223100.66766-1-sspatil@google.com>
 <20170829120853.GF31839@rei.lan>
 <20170829150446.gramj52fr3vn7cgw@dell5510>
Message-ID: <20170829150902.exez45likikktnk3@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > BTW: There is _PATH_TMP defined in that header as well, is that one present
> >      on android as well? If so and if it's pointing to something
> >      sensible we could have used that one in the getcwd test...

> _PATH_TMP is defined in all API versions, so possible to use it.
Sorry, it is defined, but has the same value ("/tmp/"), so not much useful for us.
This should be fixed in Android.

Kind regards,
Petr
