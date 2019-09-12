From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Thu, 12 Sep 2019 21:46:51 +0200
Subject: [LTP] [PATCH v2 1/3] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
In-Reply-To: <1568306963.3621.34.camel@suse.de>
References: <20190911085536.25546-1-cfamullaconrad@suse.de>
 <20190911165225.2122-1-cfamullaconrad@suse.de>
 <CAEemH2fy0hQc0yXJY0BXf8-9nnzkDW9LEsydyhtHC3Jboc_tFA@mail.gmail.com>
 <1568278363.3621.6.camel@suse.de> <20190912145539.GC22246@dell5510>
 <1568306963.3621.34.camel@suse.de>
Message-ID: <1568317611.3621.36.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2019-09-12 at 18:49 +0200, Clemens Famulla-Conrad wrote:
> On Thu, 2019-09-12 at 16:55 +0200, Petr Vorel wrote:
> > 
> > BTW: I haven't finish patchset doing the same [1]. Feel free to
> > include docs
> > from [2].
> 
> Thx for that hint, was aware of that patchset [1].
                        ^
                        not (important detail :)
