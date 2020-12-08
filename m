From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 8 Dec 2020 07:44:58 +0100
Subject: [LTP] [PATCH 1/1] doc: Document .min_cpus
In-Reply-To: <CAEemH2eWAvsyveMm6kaJ=UwMcuPSWZif8yDXr4zBpc-V5MpOGg@mail.gmail.com>
References: <20201207145639.8424-1-pvorel@suse.cz>
 <CAEemH2eWAvsyveMm6kaJ=UwMcuPSWZif8yDXr4zBpc-V5MpOGg@mail.gmail.com>
Message-ID: <X88g6ptzTJowapTO@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Hi Petr,

> I didn't write down this since I thought it's easy to understand the
> .min_cpus.
> (sounds like an excuse to mask my lazy :)
I'm lazy to grep library sources, I look into docs :).

> But it's nice to have, thanks for writing this!

> Just a minor comment below.

> On Mon, Dec 7, 2020 at 10:56 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Recently added (in fa32a727d).

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Acked-by: Li Wang <liwang@redhat.com>
Thanks!

...
> > +2.2.37 Require minimum numbers of CPU for a testcase
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Some tests require more than single CPU. It can be defined with


> single --> specific number of

+1

Kind regards,
Petr
