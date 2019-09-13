From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Sep 2019 18:07:13 +0200
Subject: [LTP] acct02 failure [was: Re:  LTP Release]
In-Reply-To: <20190910130549.GC18210@rei.lan>
References: <20190906130707.GA7515@rei.lan>
 <CAEemH2frzqyUmgm2mXTG3dusUtggwX4Y3oRBr34p+NCUJFW7_g@mail.gmail.com>
 <20190910130549.GC18210@rei.lan>
Message-ID: <20190913160713.GA25195@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > acct02 (s390x):
> > acct02.c:174: INFO: Verifying using 'struct acct_v3'
> > acct02.c:140: INFO: Number of accounting file entries tested: 2
> > acct02.c:145: FAIL: acct() wrote incorrect file contents!

> I can reproduce it here as well, no idea what is wrong there. I guess
> that modifying the test to be more verbose, i.e. to print if we haven't
> matched the pid or if the contents of the structure were wrong would be
> a good start.

I discovered failure on x86_64 on kernel 5.3.0-rc6-3.g8b30bf3-default (openSUSE)
and 5.2.9 (Debian), which or might not be related.

Kind regards,
Petr
