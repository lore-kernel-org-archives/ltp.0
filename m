From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 19 Aug 2020 08:36:18 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/clone302: drop CLONE_CHILD_SETTID and
 CLONE_PARENT_SETTID
In-Reply-To: <20200819080204.a5iqoqvlwuizimje@wittgenstein>
References: <8eefb21d278f0846024a16281c5e19b0e3936979.1596797812.git.jstancek@redhat.com>
 <20200819080204.a5iqoqvlwuizimje@wittgenstein>
Message-ID: <1455329861.9212470.1597840578327.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Fri, Aug 07, 2020 at 12:58:44PM +0200, Jan Stancek wrote:
> > Per
> > https://lore.kernel.org/linux-m68k/20200627122332.ki2otaiw3v7wndbl@wittgenstein/T/#u
> > EFAULT isn't propagated back to userspace so these will always appear
> > to succeed. Also issue is that multiple flags are tested together
> > and some arguments persisted between calls, because they were set
> > only when argument != NULL.
> > 
> > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> 
> Thanks!
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Pushed.

