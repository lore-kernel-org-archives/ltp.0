From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 21 Apr 2021 06:46:41 -0400 (EDT)
Subject: [LTP] [PATCH] mkfs: print more info for debugging
In-Reply-To: <CAEemH2fcEjre5xd1KuXsAkYzZG6tGaCttE8x3zbjxamVHfUUng@mail.gmail.com>
References: <20210420075351.16059-1-liwang@redhat.com>
 <728318760.8908748.1618921049585.JavaMail.zimbra@redhat.com>
 <CAEemH2fcEjre5xd1KuXsAkYzZG6tGaCttE8x3zbjxamVHfUUng@mail.gmail.com>
Message-ID: <356706743.9191478.1619002001499.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Tue, Apr 20, 2021 at 8:17 PM Jan Stancek <jstancek@redhat.com> wrote:
> >
> >
> >
> > ----- Original Message -----
> > > We can NOT reproduce the problem by manual with both ppc64le and s390x,
> > > so let's print more useful info from test when getting fail.
> >
> > It's mkfs_verify_size, test expects to find 90% blocks (of device size),
> > but lately we miss that by ~1-2%:
> >
> > # mkfs.ext3 /dev/loop0 16000
> > mke2fs 1.46.2 (28-Feb-2021)
> 
> Thanks for the info.
> 
> How reproducible of this issue, and which arch/platform you used?
> Or, can you reproduce it with a downgrade e2fsprogs version?

It starts with this commit:
  https://github.com/tytso/e2fsprogs/commit/59037c5357d39c6d0f14a0aff70e67dc13eafc84

