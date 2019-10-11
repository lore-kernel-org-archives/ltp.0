From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 14:54:14 +0200
Subject: [LTP] [PATCH v5 3/5] shell: Add timeout shell API tests
In-Reply-To: <1570797394.4238.7.camel@suse.de>
References: <20191011095442.10541-1-pvorel@suse.cz>
 <20191011095442.10541-4-pvorel@suse.cz>
 <1570797394.4238.7.camel@suse.de>
Message-ID: <20191011125413.GA30000@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clements,

thanks for your notes.

> > +DATA="
> > +timeout01.sh||0

> We only check if the lib doesn't produce any error, but we do not 
> check if timeout is really unlimited. But I think we can do so when 
> the shell-test-framework will be introduced and we can check for 
> "TINFO: Timeout per run is disabled" output.
Yes, I'd prefer to do more enhancements after shell-test-framework being
merged.

I plan to add also $(dirname $0) to PATH, so it can be run

-PATH="$(dirname $0)/../../../testcases/lib/:$PATH"
+PATH="$(dirname $0):$(dirname $0)/../../../testcases/lib/:$PATH"
...
-	LTP_TIMEOUT_MUL=$timeout ./$file
+	LTP_TIMEOUT_MUL=$timeout $file

And expect that shell-test-framework will handle this better.

> > +timeout02.sh||0
> > +timeout02.sh|foo|32
> > +timeout02.sh|2|0
> > +timeout02.sh|1.1|0
> > +timeout02.sh|-10|32

> I think it is worth to add these tests as well:

> timeout01.sh|2|0
> timeout02.sh|-1.1|32
> timeout02.sh|-10.1|32
> timeout02.sh|-0.1|0
OK, no problem to add them.

timeout02 1 TCONF: LTP_TIMEOUT_MUL must be number >= 1! (0)
BTW I wonder if TBROK shouldn't be used instead of TCONF.
Anybody strong opinion?

Kind regards,
Petr
