From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Apr 2020 19:41:04 +0200
Subject: [LTP] [PATCH 2/2] net/sendfile01.sh: Rewrite into new API
In-Reply-To: <ec51559c-09e3-b518-f144-4246c68f1bd9@oracle.com>
References: <20200416104548.27897-1-pvorel@suse.cz>
 <20200416104548.27897-2-pvorel@suse.cz>
 <ec51559c-09e3-b518-f144-4246c68f1bd9@oracle.com>
Message-ID: <20200421174104.GA4344@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> > +	tst_res TINFO "wait for the server to start"
> > +	sleep 1

> It would be better to replace 'sleep' with a wait-loop and check that the
> port in the listen state there, e.g with ss -ltp | grep "$port.*testsf"

I'm sorry, I overlooked this. I'm sorry, merged without this.
I'll implement it separately.
Thanks for your review.

...
> > +		diff $file $lfile > /dev/null
> > +		ret=$?
> > +		if [ $ret -eq 0 ]; then
> > +			tst_res TPASS "coped file is the same as the original"
> > +		elif [ $ret -gt 1 ]; then
> > +			tst_brk TFAIL "cannot compare files"
> > +		else
> > +			tst_res TFAIL "the copied file differs from the original"


> EXPECT_PASS diff $lfile
Fixed.

Kind regards,
Petr
