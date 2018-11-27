From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Nov 2018 16:01:20 +0100
Subject: [LTP] [PATCH] lib/tst_test.sh: don't call _tst_do_exit()
 recursively with tst_brk()
In-Reply-To: <f96d10e9-fb35-fe98-0ab0-3fd0c7891c42@oracle.com>
References: <1542729786-4097-1-git-send-email-alexey.kodanev@oracle.com>
 <20181127090439.GA23733@dell5510>
 <f96d10e9-fb35-fe98-0ab0-3fd0c7891c42@oracle.com>
Message-ID: <20181127150120.GA14077@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > +	[ "$safe" -eq 1 ] && ttype=TWARN
> > +

> ttype=TBROK?
Correct, I'm sorry.

> >  	if [ -z "$cmd" ]; then
> > -		[ "$safe" -eq 1 ] && \
> > -			tst_brk_ TBROK "tst_rhost_run: command not defined"
> > -		tst_res_ TWARN "tst_rhost_run: command not defined"
> > +		tst_brk_ $ttype "tst_rhost_run: command not defined"
> >  		return 1

> I think we should only remove tst_res_ TWARN here. Otherwise it will exit
> the test for non-safe option too.
I see, I wrongly I use tst_brk_ on non safe as well.

...
> > -		[ "$safe" -eq 1 ] && \
> > +		if [ "$safe" -eq 1 ]; then
> >  			tst_brk_ TBROK "'$cmd' failed on '$RHOST': '$output'"
> > +			return 1
> > +		fi


> It looks as if someone forgot that tst_brk_ terminates the test :)
And here I got confused by _tst_do_exit :)

I'd keep TWARN, so correct part to your commit could be something like 
patch bellow.


Kind regards,
Petr

@@ -161,9 +161,11 @@ tst_rhost_run()
 	OPTIND=0
 
 	if [ -z "$cmd" ]; then
-		[ "$safe" -eq 1 ] && \
+		if [ "$safe" -eq 1 ]; then
 			tst_brk_ TBROK "tst_rhost_run: command not defined"
-		tst_res_ TWARN "tst_rhost_run: command not defined"
+		else
+			tst_res_ TWARN "tst_rhost_run: command not defined"
+		fi
 		return 1
 	fi
