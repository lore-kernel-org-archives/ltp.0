From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 08:56:52 +0200
Subject: [LTP] [PATCH 1/2] syscalls/inotify06: Terminate child process
 on test error
In-Reply-To: <20210505164857.GD9615@quack2.suse.cz>
References: <20210505153847.6106-1-mdoucha@suse.cz>
 <20210505164857.GD9615@quack2.suse.cz>
Message-ID: <YJOTNL5MXvibBbBN@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin, Jan,

> On Wed 05-05-21 17:38:46, Martin Doucha wrote:
> > If the main test process exits early, the child would keep running and
> > interfere with tmpdir cleanup.

> > Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> > ---
> >  testcases/kernel/syscalls/inotify/inotify06.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)

> Thanks for the patch. It looks good to me. You can add:

> Reviewed-by: Jan Kara <jack@suse.cz>

Merged, thanks!

Kind regards,
Petr
