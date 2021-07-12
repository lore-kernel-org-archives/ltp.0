From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 12 Jul 2021 07:49:50 +0200
Subject: [LTP] [PATCH 1/1] tst_net.sh: Declare prefix variable as empty
In-Reply-To: <CAEemH2fB5VakafKhTgcOsvwK6Q50AJ3WcpRY2fSLfhB86b03Nw@mail.gmail.com>
References: <20210709140143.9180-1-pvorel@suse.cz>
 <CAEemH2fB5VakafKhTgcOsvwK6Q50AJ3WcpRY2fSLfhB86b03Nw@mail.gmail.com>
Message-ID: <YOvX/tczl7Duu+6L@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,
> On Fri, Jul 9, 2021 at 10:01 PM Petr Vorel <pvorel@suse.cz> wrote:

> > From: Petr Vorel <petr.vorel@gmail.com>

> > in tst_ipaddr_un(). This is required to fix problem on dash, which
> > (unlike bash and busybox ash implementation) takes value of previously
> > defined variable, i.e.  guarding with local does not work:

> > $ foo=ee; bar() { local foo; echo "foo: '$foo'"; }; bar
> > foo: 'ee'


> I'm thinking maybe we should avoid defining the same name
> variables like that. But anyway, your fix should be worked.

> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks for a review!
It's a bit strange to add '=' only single variable, maybe I should have rename
the variable.

Paranoid approach would be to add '=' to any variable which is assigned only on
some circumstance or even any variable which is not assigned to any value.
But we probably don't want to do it.

Kind regards,
Petr
