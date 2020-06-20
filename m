From: Petr Vorel <petr.vorel@gmail.com>
Date: Sat, 20 Jun 2020 11:12:26 +0200
Subject: [LTP] [RFC PATCH 1/1] tst_test.sh: Print tst_{res,
 brk} into stdout
In-Reply-To: <104572215.16889120.1592632528302.JavaMail.zimbra@redhat.com>
References: <20200619192542.20113-1-pvorel@suse.cz>
 <104572215.16889120.1592632528302.JavaMail.zimbra@redhat.com>
Message-ID: <20200620091226.GA281578@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> ----- Original Message -----
> > This allows printing messages on functions which output is redirected
> > into variable or used in eval. Also this change unifies the behavior
> > with C new API, which printed into stderr from the beginning.

> Should the subject say "into stderr"?
Yes. Thanks for pointing out silly error.

> Other than that I'm OK with the change.
Thanks a lot for your review!

Kind regards,
Petr
