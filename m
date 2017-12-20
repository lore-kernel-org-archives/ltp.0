From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Dec 2017 11:27:48 +0100
Subject: [LTP] [PATCH v2 2/2] ioctl: convert ioctl03 to new API
In-Reply-To: <CAEemH2eb8R8BAYV1_kw0KX=SH89HR5mevzHWK_nds+1m_zp0Fw@mail.gmail.com>
References: <20171214072432.15709-1-liwang@redhat.com>
 <20171214072432.15709-2-liwang@redhat.com>
 <20171219134138.GF28293@rei>
 <CAEemH2eb8R8BAYV1_kw0KX=SH89HR5mevzHWK_nds+1m_zp0Fw@mail.gmail.com>
Message-ID: <20171220102748.GA6688@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > After this change the test fails with TBROK instead of TCONF when the
> > ioctl() fails.
> >
> > I suppose that the tun driver can be compiled out of the kernel and that
> > we should still handle this situation as TCONF rather than TBROK. The
> > question is what kind of errno we get in that case, I suppose that it
> > may be ENOTTY but that should be tested.
> 
> Do you mean that ioctl(netfd, TUNGETFEATURES, &features) may be failed
> with erron==ENOTTY while testing on a kernel without TUN driver
> loaded?

That was my expectation, but with ioctl() you cannot be really sure.

> I tried that with kernel-4.15-rc4 but get "No Such Device" error when
> open "/dev/net/tun" file. And the worth to say, /dev/net/tun is still
> exist after removing TUN module.

Ok, then we need to handle ENODEV as TCONF there and anything else as
TBROK.

-- 
Cyril Hrubis
chrubis@suse.cz
