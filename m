From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Nov 2017 17:44:12 +0100
Subject: [LTP] [RFC PATCH] scripts: Dump /proc and /sys
In-Reply-To: <87bmjt9gw3.fsf@rpws.prws.suse.cz>
References: <20171107140219.5606-1-rpalethorpe@suse.com>
 <20171108134221.5ogyueuisylmmmci@x230>
 <87bmjt9gw3.fsf@rpws.prws.suse.cz>
Message-ID: <20171123164412.vv54gc2j4bgu5xc3@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> > IMHO this script should be run as root, or lots of sensitive info will be lost.
> > It's not also installed to SUT (but it's meant to be used on SUT).

> Well I won't force it to be run as root, but I can document that.
ok.

> >> +     proc_files=$(find -L /proc -maxdepth 4 -readable -not -regex '/proc/[0-9]+/.*' -not -type d 2> /dev/null)
> > This gets files in /proc/self and /proc/thread-self. I don't think we want it.
> > Also it gets symlinks (maybe not a problem),

> > and files not readable:
> > dd: error reading '/proc/sys/fs/binfmt_misc/register': Invalid argument
> > dd: error reading '/proc/sysrq-trigger': Input/output error
> > ls -l /proc/sys/fs/binfmt_misc/register /proc/sysrq-trigger
> > --w------- 1 root root 0 lis  8 07:45 /proc/sys/fs/binfmt_misc/register
> > --w------- 1 root root 0 lis  8 07:45 /proc/sysrq-trigger
> > Maybe using -perm instead of -readable (find(1) says that

> Says what ? :-)
Sorry for missing text. Says that -readable takes into account access control lists and other permissions artefacts which the -perm test ignores. But it's not relevant for us.

> I have changed it to use -perm, but it doesn't make any difference. I
> think the read bits are fairly useless in procfs and sysfs.
Sorry for confusing, find is really correct (I got is running with root).
Maybe it would be worth to not to copy empty files:
$ file /proc/sys/fs/binfmt_misc/register
/proc/sys/fs/binfmt_misc/register: empty
Even you don't care about it it would be avoid dumping at least /proc/self/* and
/proc/thread-self/* at least.

> > But I don't like the whole block being run in background.

> I'm still not sure how else to do a time out. Also it probably speeds up
> the process a lot because many of the files block on read.
I don't have better solution either.
In coreutils there is timeout command, but I guess we don't want to depend on coreutils.


Kind regards,
Petr
