From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 21 Aug 2020 05:45:54 -0400 (EDT)
Subject: [LTP] Fwd: [bug] mkfs.ext[23] hangs on loop device (aarch64, 5.8+)
In-Reply-To: <1053136797.9144539.1597819054047.JavaMail.zimbra@redhat.com>
References: <94883604.6936811.1596720770623.JavaMail.zimbra@redhat.com>
 <1929570063.6965184.1596736053281.JavaMail.zimbra@redhat.com>
 <20200818022905.GB2507595@T590>
 <1382840777.8967687.1597731548544.JavaMail.zimbra@redhat.com>
 <1053136797.9144539.1597819054047.JavaMail.zimbra@redhat.com>
Message-ID: <277259633.9648166.1598003154755.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > ----- Original Message -----
> > > I saw this kind io hang in ltp/fs_fill test reliably and the loop is
> > > over image in tmpfs:
> > > 
> > > https://lkml.org/lkml/2020/7/26/77
> > > 
> > > And I have verified that the following patch can fix the issue:
> > > 
> > > https://lore.kernel.org/linux-block/bc5fa941-3b7c-f28e-dd46-1a1d6e5c40a8@kernel.dk/T/#t
> > 
> > Thanks, I'll test your patch with my setup.
> 
> I've seen no hangs over past ~24 hours with patch above.
> 
> Thanks,
> Jan

fyi, in case you see sporadic I/O hangs, usually while running LTP tests
that make use of loop device with recent upstream kernels:
  https://lore.kernel.org/linux-block/1929570063.6965184.1596736053281.JavaMail.zimbra@redhat.com/

