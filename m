From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Jun 2019 10:50:39 +0200
Subject: [LTP] [PATCH v3 3/3] syscalls/ioctl_ns0[156]: align stack and
 wait for child
In-Reply-To: <151498464.28356667.1560670442630.JavaMail.zimbra@redhat.com>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
 <1b6ddab9cd8e3620da9e37b1132e911280c22e32.1560410182.git.jstancek@redhat.com>
 <CAEemH2frt_zGSdSRL3d_J+km74p8ruQTNF6bVhEpaiTdMLCC6A@mail.gmail.com>
 <1320546599.27920597.1560420988025.JavaMail.zimbra@redhat.com>
 <20190613141714.GC29926@rei.lan>
 <1211798607.28016198.1560437855198.JavaMail.zimbra@redhat.com>
 <20190613151419.GE29926@rei.lan>
 <151498464.28356667.1560670442630.JavaMail.zimbra@redhat.com>
Message-ID: <20190617085039.GA1629@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > I recall I started with that position (free all), and I thought you
> > > turned me around after this many years :-).
> > 
> > Well I didn't care that much, but I guess that I lean slightly to free
> > the memory :-).
> 
> OK, so should I repost or is this good to go with free added to cleanup?

Let's do that.

And I will write an RFC patch for the test-writing-guidelines.

-- 
Cyril Hrubis
chrubis@suse.cz
