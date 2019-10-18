From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 18 Oct 2019 09:39:41 -0400 (EDT)
Subject: [LTP] [PATCH] mlock_8-1,
 munlock_10-1: don't use LONG_MAX as invalid pointer
In-Reply-To: <20191018133733.GA31681@dell5510>
References: <2e51e5453562001b5b6992ccc897d9177e6673ca.1571053661.git.jstancek@redhat.com>
 <20191018133733.GA31681@dell5510>
Message-ID: <1403291253.6979626.1571405981736.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi Jan,
> 
> > arm64 kernel with commit 057d3389108e ("mm: untag user pointers passed to
> > memory syscalls") will assume this is tagged user pointer and will
> > attempt to clear first byte. This leads to test hitting different error
> > (EINVAL instead of ENOMEM).
> 
> > Add a helper function which provides invalid/unused pointer from user
> > address space.
> 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks, discussion in:
  http://lists.linux.it/pipermail/ltp/2019-October/013993.html
is still going, so maybe this will be fixed on kernel side
after all.

