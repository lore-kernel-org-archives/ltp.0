From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 18 Jul 2018 03:58:59 -0400 (EDT)
Subject: [LTP] Facing issue while running lcov on nitrogen6x
In-Reply-To: <CALYWmf9_2ofnGZM52AORb2iT5Lf4vjjWBxW4-8nrY62qUowfZA@mail.gmail.com>
References: <CALYWmf9_2ofnGZM52AORb2iT5Lf4vjjWBxW4-8nrY62qUowfZA@mail.gmail.com>
Message-ID: <903883871.33896767.1531900739285.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hii Team,
> 
> I am gettting following errors while running lcov with agl yocto environment
> on nitrogen6x

Hi,

lcov has its own mailing list: ltp-coverage@lists.sourceforge.net

> 
> {{{
> root@nitrogen6x:/sys/kernel/debug/gcov# lcov -c -b ~/ltp_agl/build/ -o
> /tmp/ kernel.info
> Auto-detecting gcov kernel support.
> Found upstream gcov kernel support at /sys/kernel/debug/gcov
> Copying data to temporary directory /tmp/IJWGHXodVA
> Capturing coverage data from /tmp/IJWGHXodVA
> Found gcov version: 6.3.0
> Scanning /tmp/IJWGHXodVA for .gcda files ...
> Found 1881 data files in /tmp/IJWGHXodVA
> Processing linux-boundary/4.1.15-r0/build/lib/fonts/fonts.gcda
> geninfo: ERROR: ~/ltp_agl/build/tmp/work/nitrogen6x-agl-linux-gnueabi
> /linux-boundary/4.1.15-r0/build/lib/fonts/.tmp_fonts.gcno: could not open
> file
> }}}
> 
> please provide your input regarding this.

Looks like some paths are wrong, I'm guessing .gcno symlinks
don't resolve correctly.

Regards,
Jan
