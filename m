From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Jun 2018 07:27:09 -0400 (EDT)
Subject: [LTP] [PATCH] readahead02: create loop device if TMPDIR is tmpfs
In-Reply-To: <20180622090512.ifzdwwgawbtcjxuw@dell5510>
References: <94d4c00514e5f57d488199e0aa146e342f5b4403.1528887039.git.jstancek@redhat.com>
 <20180622090512.ifzdwwgawbtcjxuw@dell5510>
Message-ID: <1826068168.29009700.1530012429946.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> > readahead doesn't work on tmpfs. Detect it and create loop
> > device if necessary.
> 
> > After patch (4.16.0, /tmp if tmpfs):
> >   readahead02    0  TINFO  :  TMPFS detected, creating loop device
> >   readahead02    0  TINFO  :  Found free device '/dev/loop1'
> >   readahead02    0  TINFO  :  Formatting /dev/loop1 with ext2 opts='' extra
> >   opts='' mke2fs 1.43.6 (29-Aug-2017)
> >   readahead02    0  TINFO  :  creating test file of size: 67108864
> >   readahead02    0  TINFO  :  read_testfile(0)
> >   readahead02    0  TINFO  :  read_testfile(1)
> >   readahead02    0  TINFO  :  max ra estimate: 1118208
> >   readahead02    0  TINFO  :  readahead calls made: 61
> >   readahead02    1  TPASS  :  offset is still at 0 as expected
> >   readahead02    0  TINFO  :  read_testfile(0) took: 25650 usec
> >   readahead02    0  TINFO  :  read_testfile(1) took: 17931 usec
> >   readahead02    0  TINFO  :  read_testfile(0) read: 67108864 bytes
> >   readahead02    0  TINFO  :  read_testfile(1) read: 0 bytes
> >   readahead02    2  TPASS  :  readahead saved some I/O
> >   readahead02    0  TINFO  :  cache can hold at least: 66516 kB
> >   readahead02    0  TINFO  :  read_testfile(0) used cache: 65156 kB
> >   readahead02    0  TINFO  :  read_testfile(1) used cache: 65156 kB
> >   readahead02    3  TPASS  :  using cache as expected
> 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks, pushed.
Jan
