From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 12 Jul 2021 18:12:30 +0200
Subject: [LTP] [PATCH 1/1] tst_net.sh: Declare prefix variable as empty
In-Reply-To: <34959e10-45fc-f7ea-9e2d-ebe186a97859@jv-coder.de>
References: <20210709140143.9180-1-pvorel@suse.cz>
 <CAEemH2fB5VakafKhTgcOsvwK6Q50AJ3WcpRY2fSLfhB86b03Nw@mail.gmail.com>
 <YOvX/tczl7Duu+6L@pevik>
 <34959e10-45fc-f7ea-9e2d-ebe186a97859@jv-coder.de>
Message-ID: <YOxp7pwIQKDiT3bs@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> in tst_ipaddr_un(). This is required to fix problem on dash, which
> (unlike bash and busybox ash implementation) takes value of previously
> defined variable, i.e.  guarding with local does not work:
> 
> $ foo=ee; bar() { local foo; echo "foo: '$foo'"; }; bar
> foo: 'ee'
> 
> It requires declare it as empty:
> $ foo=ee; bar() { local foo=; echo "foo: '$foo'"; }; bar
> foo: ''
> 
> This problem seems to be on various dash versions from 0.5.8 to
> 0.5.11+git20200708+dd9ef66-5 (on Debian oldstable, stable, testing).
> It'd require to set all variables, but now fix just prefix, which is
> used in build.sh and it's quite common name.

FYI this behavior is expected on dash, quoting man dash(1):
"When a variable is made local, it inherits the initial value and exported and
readonly flags from the variable with the same name in the surrounding scope, if
there is one."

Kind regards,
Petr
