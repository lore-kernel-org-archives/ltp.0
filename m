From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 22 Apr 2020 07:33:43 -0400 (EDT)
Subject: [LTP] [PATCH] lib/tst_hugepage: TCONF when huge pages are not
 supported
In-Reply-To: <CAEemH2fWhXzLRV+g=hN9yJRcmqsj2iGMxxy14GGGKDpBAEX5HQ@mail.gmail.com>
References: <bc3c52ff5b97feefa4200c3d87002de5a61ee360.1587539566.git.jstancek@redhat.com>
 <CAEemH2fWhXzLRV+g=hN9yJRcmqsj2iGMxxy14GGGKDpBAEX5HQ@mail.gmail.com>
Message-ID: <431757761.9427972.1587555223323.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> >         if (access(PATH_HUGEPAGES, F_OK)) {
> >                 tst_hugepages = 0;
> > -               goto out;
> > +               tst_brk(TCONF, "Huge pages not supported.");
> >
> 
> We don't do that because hugetlb is not the hard requirement for some tests
> (i.e pkey01.c). If we exit with TCONF at an early phase on a non-hugetlb
> system the remaining test will be missed too. In a word, the goto out here
> is on purpose.

Then it's a bit strange it TBROKs if it can't reserve enough huge pages.

I'll send v2, that's checking tst_hugepages. Almost all tests appear to have the 
check already, it just needs to be moved up a little in setup().

