From: Li Wang <liwang@redhat.com>
Date: Thu, 3 May 2018 15:54:18 +0800
Subject: [LTP] [RFC PATCH 1/1] tst_test.sh: TCONF on basename error when
 setting TST_ID
In-Reply-To: <20180502144542.4wmenub3p3c7kega@dell5510>
References: <20180502134553.5429-1-pvorel@suse.cz>
 <20180502144542.4wmenub3p3c7kega@dell5510>
Message-ID: <CAEemH2cGQt4SG4ec+-=ppSF6sywzZhhsK2aZ4fzMT8oObgC93Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Wed, May 2, 2018 at 10:45 PM, Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> ...
> >  if [ -z "$TST_ID" ]; then
> > -     filename=3D$(basename $0)
> > +     filename=3D$(basename $0) || \
> > +             tst_brk TBROK "Failed to set TST_ID from \$0 ('$0'), fix
> it with setting TST_ID before sourcing tst_test.sh"
>                 ^
> Here is going to be TCONF.
>

=E2=80=8BLooks good to me.


--=20
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180503/b5d560ac/att=
achment.html>
