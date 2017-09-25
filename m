From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 25 Sep 2017 06:37:26 -0400 (EDT)
Subject: [LTP] io_submit test failed in latest kernel
In-Reply-To: <x49lgl6gb0x.fsf@segfault.boston.devel.redhat.com>
References: <20170915043644.GA27514@spreadtrum.com>
 <x49mv5w9nn9.fsf@segfault.boston.devel.redhat.com>
 <20170922093616.GB27514@spreadtrum.com>
 <x49lgl6gb0x.fsf@segfault.boston.devel.redhat.com>
Message-ID: <1801117143.21285578.1506335846927.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> > I use 4.13 final release and download ltp src code of stable release from
> > official website.
> 
> Thanks.  Basically, the test feeds in a garbage iocb, and expects one of
> the three errnos listed.

Patch [1] removed testing of uninitialized iocb and will be in next LTP release.
If you can please retry with latest git. Works for me on 4.14.0-rc1+.

[1] Drop uninitialized iocb test since that
    one invokes undefined behavior and may
    fail with pretty much any error
    https://github.com/linux-test-project/ltp/commit/89d1e69d5953eac71b121b8ec5ee31d769e17ee2#diff-1d2b3d5644576fc779af7d4ee419ea8d

Regards,
Jan
