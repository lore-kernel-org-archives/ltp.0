From: Li Wang <liwang@redhat.com>
Date: Thu, 7 Jun 2018 13:44:24 +0800
Subject: [LTP] [PATCH] [RFC] syscalls/ipc: Rename some msgctl tests
In-Reply-To: <20180606123735.15589-1-chrubis@suse.cz>
References: <20180606123735.15589-1-chrubis@suse.cz>
Message-ID: <CAEemH2fxCoLB7S42xZKnT=4wFvTS-875AhvksFD3atYmjfPMWg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Wed, Jun 6, 2018 at 8:37 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> The test from msgctl08 to msgctl11 are actually msg stress tests, these
> do not actually call msgctl() during the test but rather than that they
> fork large number of processes and send message around. Renaming them to
> msgstress seems to be more fitting.
>

Agreed. These tests fork too many times, and they often trigger OOM at
runtime. So I think this patch make sense.
=E2=80=8B
Another thought of mine is that to remove them from the ltplite and
syscalls runtest file. what about just putting them in stress.part3?

--=20
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180607/a6cefd8d/att=
achment.html>
