From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 26 Apr 2020 10:05:26 +0200
Subject: [LTP] [PATCH 1/1] net/sendfile01.sh: Check with timeout
In-Reply-To: <CAEemH2f1_6BFuTfrGZ2qpbLidFXxB2EQEO43TjucaMTPM9ghuw@mail.gmail.com>
References: <20200421180002.11351-1-pvorel@suse.cz>
 <dab04fc5-5d20-3dbc-c21f-535112ab222f@oracle.com>
 <20200423221245.GA1391884@x230> <20200424121116.GA25613@dell5510>
 <CAEemH2f1_6BFuTfrGZ2qpbLidFXxB2EQEO43TjucaMTPM9ghuw@mail.gmail.com>
Message-ID: <20200426080526.GA203542@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > > > old api, not sure why exactly it was removed in the new one...
> > > It was designed from scratch I guess.
> > > But this patch makes sense to me, I'll test it tomorrow.

> > Actually, I now consider a bit cleaner and safer solution to *not* use eval
> > and require test to specify function. E.g.:


> Why not use eval for that? It helps us to perform more commands directly
> without wrap into function.


> > +retry_fnc()
> > +{
> > +       tst_rhost_run -c 'ss -ltp' | grep -q "$port.*testsf"
> > +}
> > +
> >  do_setup()
> >  {

> > @@ -28,7 +33,7 @@ do_setup()
> >         tst_rhost_run -s -b -c "$server $(tst_ipaddr rhost) $port"
> >         server_started=1
> >         tst_res TINFO "wait for the server to start"
> > -       sleep 1
> > +       TST_RETRY_FUNC retry_fnc 0
> >  }

> > Instead of simple:

> >  do_setup()
> > @@ -28,7 +28,7 @@ do_setup()
> >         tst_rhost_run -s -b -c "$server $(tst_ipaddr rhost) $port"
> >         server_started=1
> >         tst_res TINFO "wait for the server to start"
> > -       sleep 1
> > +       TST_RETRY_FUNC "tst_rhost_run -c 'ss -ltp' | grep -q
> > '$port.*testsf'" 0
> >  }

> > But I don't have strong opinion on it.
> > Cyril, Li, any preference?


> If no more strict reasons I prefer to go the simpler way. And there is no
> need to wrap a retry_fun() I think.

I'm a bit careful and try to avoid eval in scripts for security reasons.
But ok, LTP code is a bit different from running shell scripts on the server,
security does not matters on SUT, so I'm not against it. I just wanted to hear
more opinions on that, thanks for your comment.

Kind regards,
Petr
