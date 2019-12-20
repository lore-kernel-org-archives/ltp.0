From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Dec 2019 17:17:45 +0100
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add return value to
 _tst_expect_{fail, pass}
In-Reply-To: <391203935.17412269.1576762983583.JavaMail.zimbra@redhat.com>
References: <20191219095050.26106-1-pvorel@suse.cz>
 <391203935.17412269.1576762983583.JavaMail.zimbra@redhat.com>
Message-ID: <20191220161745.GA15920@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> ----- Original Message -----
> > +It's possible to detect whether expected value happened:
> > +[source,sh]
> > +-------------------------------------------------------------------------------
> > +if ! EXPECT_PASS command arg1 2\> /dev/null; then
> > +	continue
> > +fi
> > +-------------------------------------------------------------------------------
> > +

> Looks useful, ack.
Thank you for your review, merged with your ack.

Kind regards,
Petr
