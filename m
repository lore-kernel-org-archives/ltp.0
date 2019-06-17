From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 17 Jun 2019 10:38:08 -0400 (EDT)
Subject: [LTP] [PATCH v3 3/3] syscalls/ioctl_ns0[156]: align stack and
 wait for child
In-Reply-To: <20190617085039.GA1629@rei.lan>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
 <CAEemH2frt_zGSdSRL3d_J+km74p8ruQTNF6bVhEpaiTdMLCC6A@mail.gmail.com>
 <1320546599.27920597.1560420988025.JavaMail.zimbra@redhat.com>
 <20190613141714.GC29926@rei.lan>
 <1211798607.28016198.1560437855198.JavaMail.zimbra@redhat.com>
 <20190613151419.GE29926@rei.lan>
 <151498464.28356667.1560670442630.JavaMail.zimbra@redhat.com>
 <20190617085039.GA1629@rei.lan>
Message-ID: <894722811.28675645.1560782288619.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > > > I recall I started with that position (free all), and I thought you
> > > > turned me around after this many years :-).
> > > 
> > > Well I didn't care that much, but I guess that I lean slightly to free
> > > the memory :-).
> > 
> > OK, so should I repost or is this good to go with free added to cleanup?
> 
> Let's do that.

Pushed.
(Li, I added your Acked-by to it, since your comment has been addressed).

Regards,
Jan
