From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Apr 2020 14:11:16 +0200
Subject: [LTP] [PATCH 1/1] net/sendfile01.sh: Check with timeout
In-Reply-To: <20200423221245.GA1391884@x230>
References: <20200421180002.11351-1-pvorel@suse.cz>
 <dab04fc5-5d20-3dbc-c21f-535112ab222f@oracle.com>
 <20200423221245.GA1391884@x230>
Message-ID: <20200424121116.GA25613@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > > I guess nothing controversial here as failure of starting server is
> > > guarded by -s.
> > > I was thinking about using TST_RETRY_FUNC, but passing command to it
> > > leads to: tst_rhost_run: unknown option: l


> > Hi Petr,

> > eval might help in this case, take a look at tst_retry() in test.sh
> Good point.

> > old api, not sure why exactly it was removed in the new one...
> It was designed from scratch I guess.
> But this patch makes sense to me, I'll test it tomorrow.

Actually, I now consider a bit cleaner and safer solution to *not* use eval
and require test to specify function. E.g.:

+retry_fnc()
+{
+	tst_rhost_run -c 'ss -ltp' | grep -q "$port.*testsf"
+}
+
 do_setup()
 {
 
@@ -28,7 +33,7 @@ do_setup()
 	tst_rhost_run -s -b -c "$server $(tst_ipaddr rhost) $port"
 	server_started=1
 	tst_res TINFO "wait for the server to start"
-	sleep 1
+	TST_RETRY_FUNC retry_fnc 0
 }

Instead of simple:

 do_setup()
@@ -28,7 +28,7 @@ do_setup()
 	tst_rhost_run -s -b -c "$server $(tst_ipaddr rhost) $port"
 	server_started=1
 	tst_res TINFO "wait for the server to start"
-	sleep 1
+	TST_RETRY_FUNC "tst_rhost_run -c 'ss -ltp' | grep -q '$port.*testsf'" 0
 }

But I don't have strong opinion on it.
Cyril, Li, any preference?

Kind regards,
Petr

> > index 1d8a71d9f..e34edb26a 100644
> > --- a/testcases/lib/tst_test.sh
> > +++ b/testcases/lib/tst_test.sh
> > @@ -207,7 +207,7 @@ TST_RETRY_FN_EXP_BACKOFF()
> >         fi

> >         while true; do
> > -               $tst_fun
> > +               eval "$tst_fun"
> >                 if [ "$?" = "$tst_exp" ]; then
> >                         break
> >                 fi
...
