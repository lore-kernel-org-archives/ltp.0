From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Mar 2019 11:26:20 -0400 (EDT)
Subject: [LTP] [PATCH v4] syscalls/readahead02: set readahead to min(bdi
 limit, 2M)
In-Reply-To: <CAEemH2eQ2wpVWDeH2jPoD7rMec7yU2RCnpTw4WkqozkhWovoNw@mail.gmail.com>
References: <CAOQ4uxj_4D6VYA+8PhzNi-mzwew+b6Wue=vxVYLEqX2xKM862w@mail.gmail.com>
 <96b24288ab39333b2df77980c0665c6949080f58.1552047315.git.jstancek@redhat.com>
 <CAEemH2eQ2wpVWDeH2jPoD7rMec7yU2RCnpTw4WkqozkhWovoNw@mail.gmail.com>
Message-ID: <675507642.7201880.1552404380160.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Fri, Mar 8, 2019 at 8:19 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> > Using system-wide "Cached" size is not accurate. The test is sporadically
> > failing with warning on ppc64le 4.18 and 5.0 kernels.
> >
> > Problem is that test over-estimates max readahead size, which then
> > leads to fewer readhead calls and kernel can silently trims length
> > in each of them:
> >   ...
> >   readahead02.c:244: INFO: Test #2: POSIX_FADV_WILLNEED on file
> >   readahead02.c:134: INFO: creating test file of size: 67108864
> >   readahead02.c:263: INFO: read_testfile(0)
> >   readahead02.c:274: INFO: read_testfile(1)
> >   readahead02.c:189: INFO: max ra estimate: 12320768
> >   readahead02.c:198: INFO: readahead calls made: 6
> >   readahead02.c:204: PASS: offset is still at 0 as expected
> >   readahead02.c:308: INFO: read_testfile(0) took: 492486 usec
> >   readahead02.c:309: INFO: read_testfile(1) took: 430627 usec
> >   readahead02.c:311: INFO: read_testfile(0) read: 67108864 bytes
> >   readahead02.c:313: INFO: read_testfile(1) read: 59244544 bytes
> >   readahead02.c:316: PASS: readahead saved some I/O
> >   readahead02.c:324: INFO: cache can hold at least: 264192 kB
> >   readahead02.c:325: INFO: read_testfile(0) used cache: 124992 kB
> >   readahead02.c:326: INFO: read_testfile(1) used cache: 12032 kB
> >   readahead02.c:338: WARN: using less cache than expected
> >
> > Try raising bdi readahead limit as much as we can. We write and read back
> > "read_ahead_kb" sysfs value, starting with filesize. If that fails, we try
> > again with lower value.
> >
> > readahead_length used in the test is then set to MIN(bdi limit, 2M),
> > so we respect also kernels prior to commit 600e19afc5f8 ("mm: use
> > only per-device readahead limit").
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> >
> 
> Tested-by: Li Wang <liwang@redhat.com>
> 
> I run this patch for more than 100 times on my ppc64le 4.18 platform, and
> confirmed the problem is no longer appear.

Thanks, my testing also looks good.

Pushed.

Regards,
Jan
