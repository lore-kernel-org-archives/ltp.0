From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 May 2017 17:37:38 +0200
Subject: [LTP] [PATCH] tst_test.c: set the test id automatically
In-Reply-To: <CAEemH2eXNxvG8nJqagABb6x+iinSOcTxTC9XUDHU+NzUcW=WJA@mail.gmail.com>
References: <20170522141611.19386-1-chrubis@suse.cz>
 <CAEemH2eXNxvG8nJqagABb6x+iinSOcTxTC9XUDHU+NzUcW=WJA@mail.gmail.com>
Message-ID: <20170523153738.GA3194@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static void get_tid(char *argv[])
> 
> Ah, forgot to mention that the return type should be "char *".

I've changed the patch to update test-writing-guidelines as well and
pushed.

-- 
Cyril Hrubis
chrubis@suse.cz
