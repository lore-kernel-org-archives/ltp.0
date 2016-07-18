From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Jul 2016 09:52:25 -0400 (EDT)
Subject: [LTP] [PATCH] lib: add [SAFE_]FILE_LINES_SCANF
In-Reply-To: <20160718113644.GA18221@rei.suse.cz>
References: <ae355058af800fd8fbc410b839ce25a128ab4339.1468492135.git.jstancek@redhat.com>
 <20160718113644.GA18221@rei.suse.cz>
Message-ID: <2011593494.6050854.1468849945006.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 18 July, 2016 1:36:44 PM
> Subject: Re: [LTP] [PATCH] lib: add [SAFE_]FILE_LINES_SCANF
> 
> Hi!
> >  lib/tests/tst_safe_fileops.c    | 40 +++++++++++++++++++++++++++++++++++
> 
> The last minor nitpick is that the lib/tests/ directory is full of
> oldlib tests and this is a newlib test. It may be better to add this
> file to the lib/newlib_tests/.

Moved and pushed.

Regards,
Jan

> 
> Anyway this version looks fine, acked.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
