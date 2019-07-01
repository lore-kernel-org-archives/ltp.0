From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 1 Jul 2019 03:23:26 -0400 (EDT)
Subject: [LTP] [PATCH v4 2/2] pkey: add test for memory protection keys
In-Reply-To: <CAEemH2d-Hyhg5Xo+Q66C3MKvMv3pOnXDKtFYkuZpi6ZUEgC2DA@mail.gmail.com>
References: <20190626071538.29486-1-liwang@redhat.com>
 <20190626071538.29486-2-liwang@redhat.com>
 <285629943.30156546.1561537194409.JavaMail.zimbra@redhat.com>
 <CAEemH2d_7fq2RxEwZEMSUgErM7XG26RTsV1ogLTiLvALc810Gw@mail.gmail.com>
 <1695359151.30173908.1561543177520.JavaMail.zimbra@redhat.com>
 <CAEemH2d-Hyhg5Xo+Q66C3MKvMv3pOnXDKtFYkuZpi6ZUEgC2DA@mail.gmail.com>
Message-ID: <553049750.30838144.1561965806395.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Wed, Jun 26, 2019 at 5:59 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> >
> > ...
> > >
> > > If a system(e.g PowerKVM guest) configured with NO huge page support,
> > then
> > > the file '/proc/sys/vm/nr_hugepages' exist but EOPNOTSUPP to read/write.
> > In
> > > this key01, perhaps I shouldn't use the "/proc/.../nr_hugepages" to
> > detect
> > > that at the beginning.
> > >
> > > Seems the correct way is to use "/sys/kernel/mm/hugepages/" for huge page
> > > detecting and leave the SAFE_FILE_* still in setup(). Because we need to
> > > catch the "/proc/.../nr_hugepages" open/close or read/write issue in
> > > testing.
> >
> > That should work, I see we used that in some tests already.
> >
> 
> Thanks, should I format new patch v5? or any more comments?

Yes, please send v5.
