From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 6 Oct 2016 10:08:09 -0400 (EDT)
Subject: [LTP] [PATCH] lib: add tst_res_hexd for newlib
In-Reply-To: <20161006123528.GA10467@rei.lan>
References: <77e055a73816d095647ced78f9444932845f370c.1475754253.git.jstancek@redhat.com>
 <20161006123528.GA10467@rei.lan>
Message-ID: <618636125.838615.1475762889407.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 6 October, 2016 2:35:29 PM
> Subject: Re: [PATCH] lib: add tst_res_hexd for newlib
> 
> Hi!
> > Locking mutex isn't necessary for oldlib, because
> > we already lock at tst_res__ level.
> 
> Well, technically that would mean that the lines from hexdump may be
> interleaved with other messages but in reality I doubt that this would
> ever happen.
> 
> We should propably add a note to test-writing-guidelines, apart from
> that this looks OK. Acked.

Pushed.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
