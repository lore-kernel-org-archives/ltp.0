From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 8 Jun 2021 08:28:05 +0200
Subject: [LTP] [RFC PATCH 0/2] Remove floppy and CDROM stress tests
In-Reply-To: <20210607111016.20630-1-pvorel@suse.cz>
References: <20210607111016.20630-1-pvorel@suse.cz>
Message-ID: <CAASaF6x1+j+nF=-TpkfLwi9hYXWN5sDVff4oJAKX-eTyH11s8A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 7, 2021 at 1:10 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> does anybody use these tests? Does anybody need to test froppy or CDROM
> (even on VM)?
>


I'm not, and I don't recall seeing this in any reports or issues, so I
think they wouldn't be missed.

Acked-by: Jan Stancek <jstancek@redhat.com>


>
> Kind regards,
> Petr
>
> Petr Vorel (2):
>   io: Remove stress_floppy
>   io: Remove stress_cd
>
>  runtest/io_cd                                 |     1 -
>  runtest/io_floppy                             |     1 -
>  testcases/kernel/io/stress_cd/.gitignore      |     1 -
>  testcases/kernel/io/stress_cd/Makefile        |    25 -
>  testcases/kernel/io/stress_cd/stress_cd.c     |   244 -
>  testcases/kernel/io/stress_floppy/.gitignore  |     4 -
>  testcases/kernel/io/stress_floppy/Makefile    |    25 -
>  .../io/stress_floppy/datafiles/Makefile       |    31 -
>  .../kernel/io/stress_floppy/datafiles/dd_file | 21441 ----------------
>  .../datafiles/dumpdir/.gitignore              |     1 -
>  .../stress_floppy/datafiles/dumpdir/1K_file   |    19 -
>  .../stress_floppy/datafiles/dumpdir/Makefile  |    40 -
>  .../datafiles/dumpdir/generate.sh             |    22 -
>  .../kernel/io/stress_floppy/stress_floppy     |   264 -
>  testscripts/diskio.sh                         |    37 -
>  15 files changed, 22156 deletions(-)
>  delete mode 100644 runtest/io_cd
>  delete mode 100644 runtest/io_floppy
>  delete mode 100644 testcases/kernel/io/stress_cd/.gitignore
>  delete mode 100644 testcases/kernel/io/stress_cd/Makefile
>  delete mode 100644 testcases/kernel/io/stress_cd/stress_cd.c
>  delete mode 100644 testcases/kernel/io/stress_floppy/.gitignore
>  delete mode 100644 testcases/kernel/io/stress_floppy/Makefile
>  delete mode 100644 testcases/kernel/io/stress_floppy/datafiles/Makefile
>  delete mode 100644 testcases/kernel/io/stress_floppy/datafiles/dd_file
>  delete mode 100644
> testcases/kernel/io/stress_floppy/datafiles/dumpdir/.gitignore
>  delete mode 100644
> testcases/kernel/io/stress_floppy/datafiles/dumpdir/1K_file
>  delete mode 100644
> testcases/kernel/io/stress_floppy/datafiles/dumpdir/Makefile
>  delete mode 100755
> testcases/kernel/io/stress_floppy/datafiles/dumpdir/generate.sh
>  delete mode 100755 testcases/kernel/io/stress_floppy/stress_floppy
>  delete mode 100755 testscripts/diskio.sh
>
> --
> 2.31.1
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210608/46d4e7b6/attachment.htm>
