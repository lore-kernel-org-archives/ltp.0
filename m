From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Dec 2020 22:14:47 +0100
Subject: [LTP] [PATCH 1/1] Docparse: Escape | in table content
In-Reply-To: <X9ooMiuT3DKHwHjJ@yuki.lan>
References: <20201216143244.8180-1-pvorel@suse.cz> <X9oc1p0Z7LbBhKr0@yuki.lan>
 <X9ojaYZkNuwOOsyk@pevik> <X9ooMiuT3DKHwHjJ@yuki.lan>
Message-ID: <X9p4x3rnqr7t+0BR@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> > Also many arrays should be anonymous, e.g. exe_options (for .options) and
> > resource_files (for .resource_files) in testcases/kernel/syscalls/execve/execve05.c.
> > I wonder if there can be smarter solution before we fix it.

> Well either we teach the C parser about variables, or we move all the
> definitions inline. I would just move them since that's easier to do.
I've fixed most of .options and .save_restore.
There are still some (e.g. CORE_PATTERN in madvise08 - use macro).

> > But using inline for .options (and other two dimensional array needs to be fixed
> > again in the parser: it now prints array reference: ARRAY(0x563186f58048)
> > (for testcases/kernel/syscalls/ioctl/ioctl01.c).

> That's a bug in the perl that produces the asciidoc, it's parsed just
> fine in the json:

>   "ioctl01": {
>    "needs_root": "1",
>    "needs_tmpdir": "1",
>    "options": [
>      [
>       "D:",
>       "device",
>       "-D <tty device> : for example, /dev/tty[0-9]"
>      ]
>     ],
>    "fname": "testcases/kernel/syscalls/ioctl/ioctl01.c"
>   },

I've fixed this in dca56c567.

Kind regards,
Petr
