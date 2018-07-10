From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Jul 2018 09:48:51 -0400 (EDT)
Subject: [LTP] [PATCH v3] open08: rewrite to newlib
In-Reply-To: <CAE1O6mhchrDEe10RcquhZnw0vYR1yfDEsvON=zDUYHCX7Dgx7Q@mail.gmail.com>
References: <6da44d664c386d6d2d931768d460fbe7c0d94467.1530022835.git.jstancek@redhat.com>
 <CAE1O6mhchrDEe10RcquhZnw0vYR1yfDEsvON=zDUYHCX7Dgx7Q@mail.gmail.com>
Message-ID: <1172015060.31607439.1531230531048.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On 26 June 2018 at 22:22, Jan Stancek <jstancek@redhat.com> wrote:
> > Fixes: https://github.com/linux-test-project/ltp/issues/330
> >
> > EACCES testcase changed:
> > Test now creates file (0600) in tmpdir, that is owned by privileged user,
> > and unprivileged user tries to open it for writing.
> >
> > EFAULT testcase changed:
> > Comments say the intent is to use address outside of process mapped space.
> > So, test is changed to map/unmap rather than map as PROT_NONE.
> >
> > uclinux ifdefs dropped.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks Li, pushed.

Regards,
Jan
