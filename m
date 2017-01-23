From: Jan Kara <jack@suse.cz>
Date: Mon, 23 Jan 2017 12:07:26 +0100
Subject: [LTP] [PATCH] fanotify: Add test for permission event
	destruction
In-Reply-To: <CAOQ4uxhjP7gpC7gzWJPRsKQO1b2SsspPa5TprqLc9+6fvvxh1Q@mail.gmail.com>
References: <20170120132951.10312-1-jack@suse.cz>
 <CAOQ4uxhjP7gpC7gzWJPRsKQO1b2SsspPa5TprqLc9+6fvvxh1Q@mail.gmail.com>
Message-ID: <20170123110726.GA5421@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat 21-01-17 17:47:21, Amir Goldstein wrote:
> On Fri, Jan 20, 2017 at 3:29 PM, Jan Kara <jack@suse.cz> wrote:
> > Test whether kernel's notification subsystem gets stuck when some
> > fanotify permission events are not responded to. Also test destruction
> > of fanotify instance while there are outstanding permission events. This
> > can result in hanging of processes indefinitely in kernel or in kernel
> > crashes.
> >
> 
> Looks good to me, but I wonder about your phrasing "can result" and
> "This may hang" below.

The hang happens always, it is just too lax wording of the changelog...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
