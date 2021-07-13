From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 13 Jul 2021 08:08:11 +0200
Subject: [LTP] tst_strstatus.c fails on Alpine
In-Reply-To: <YOx1pir0UuBNM+4w@pevik>
References: <YOx1pir0UuBNM+4w@pevik>
Message-ID: <CAASaF6zS0kPHk6vSvANA1KzuOCtJHskLmOE_DE1n4b5AhMUPkg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 12, 2021 at 7:02 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi all,
>
> I see failures of lib/newlib_tests/tst_strstatus on Alpine:
>
> tst_strstatus.c:31: TPASS: exited with 1
> tst_strstatus.c:31: TPASS: killed by SIGHUP
> tst_strstatus.c:31: TPASS: is stopped
> tst_strstatus.c:31: TPASS: is resumed
> tst_strstatus.c:29: TFAIL: killed by ??? != invalid status 0xff
>
> Any idea what could be wrong?
>

I'd start with definition of WIFSIGNALED on that system.

printf("%d\n", WIFSIGNALED(0xff));
should give you 0, but it does appear to return 1 in output above.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210713/af0b4658/attachment.htm>
