From: Jan Kara <jack@suse.cz>
Date: Tue, 14 Mar 2017 13:35:42 +0100
Subject: [LTP] [PATCH v2] fanotify: Add test for permission event
	destruction
In-Reply-To: <20170314113633.GA4939@rei.lan>
References: <20170314094038.10412-1-jack@suse.cz>
 <20170314113633.GA4939@rei.lan>
Message-ID: <20170314123542.GA10831@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue 14-03-17 12:36:33, Cyril Hrubis wrote:
> Hi!
> > Test whether kernel's notification subsystem gets stuck when some
> > fanotify permission events are not responded to. Also test destruction
> > of fanotify instance while there are outstanding permission events. This
> > can result in hanging of processes indefinitely in kernel or in kernel
> > crashes.
> > 
> > Kernel crashes should be fixed by commit 96d41019e3ac "fanotify: fix
> > list corruption in fanotify_get_response()", kernel hangs by "fanotify:
> > Release SRCU lock when waiting for userspace response" (not yet landed
> > upstream).
> 
> Ideally the testcase should include both commit ids in the test
> description as well. So either we wait until the fix gets into mainline,
> or add it later.

OK, I've addressed all other remarks and will wait with the testcase until
the fix gets merged.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
