From: Li Wang <liwang@redhat.com>
Date: Mon, 1 Jul 2019 15:11:45 +0800
Subject: [LTP] [PATCH v4 2/2] pkey: add test for memory protection keys
In-Reply-To: <1695359151.30173908.1561543177520.JavaMail.zimbra@redhat.com>
References: <20190626071538.29486-1-liwang@redhat.com>
 <20190626071538.29486-2-liwang@redhat.com>
 <285629943.30156546.1561537194409.JavaMail.zimbra@redhat.com>
 <CAEemH2d_7fq2RxEwZEMSUgErM7XG26RTsV1ogLTiLvALc810Gw@mail.gmail.com>
 <1695359151.30173908.1561543177520.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2d-Hyhg5Xo+Q66C3MKvMv3pOnXDKtFYkuZpi6ZUEgC2DA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 26, 2019 at 5:59 PM Jan Stancek <jstancek@redhat.com> wrote:

>
> ...
> >
> > If a system(e.g PowerKVM guest) configured with NO huge page support,
> then
> > the file '/proc/sys/vm/nr_hugepages' exist but EOPNOTSUPP to read/write.
> In
> > this key01, perhaps I shouldn't use the "/proc/.../nr_hugepages" to
> detect
> > that at the beginning.
> >
> > Seems the correct way is to use "/sys/kernel/mm/hugepages/" for huge page
> > detecting and leave the SAFE_FILE_* still in setup(). Because we need to
> > catch the "/proc/.../nr_hugepages" open/close or read/write issue in
> > testing.
>
> That should work, I see we used that in some tests already.
>

Thanks, should I format new patch v5? or any more comments?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190701/c6f7a909/attachment.htm>
