From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 26 Feb 2020 08:23:42 -0500 (EST)
Subject: [LTP] [PATCH 1/1] request_key04: Use TFAIL instead of TBROK
In-Reply-To: <20200226124826.GA24080@rei>
References: <20200226084249.29561-1-pvorel@suse.cz>
 <CAEemH2cMBtVV-1_RZb_UHN9rQF3sD2w-H2gS11BD2WHPTPzvgQ@mail.gmail.com>
 <20200226091824.GA2215@dell5510>
 <CAEemH2cXGOh=MX28kYvhFaHspHGXiVdGuNZeyN97+O3+bt1jGg@mail.gmail.com>
 <20200226113757.GA24342@dell5510> <20200226124826.GA24080@rei>
Message-ID: <1576675558.9115231.1582723422538.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > In personally, I'd let tst_res() only accept 'TPASS, TFAIL, TINFO, TCONF,
> > > TWARN'.
> > +1. Cyril, Jan?
> 
> I guess that it does not make much sense to report TBROK and then
> continue the test. But that all depends on how exactly are these states
> defined. Have we ever wrote them down?
> 
> I guess that TPASS and TFAIL are obvious.
> 
> TINFO is just additional information.
> 
> TCONF is test skipped.
> 
> TWARN something went wrong but we decided to continue?

This appears to be mostly used in cleanup() when something goes wrong.
So a failure that's not critical, not related to goal of test,
but still something we want to draw attention to.

> 
> TBROK something went wrong and we decided to exit?

We do have following in style-guide.txt:

Use +TBROK+ when an unexpected failure unrelated to the goal of the testcase
occurred, and use +TFAIL+ when an unexpected failure related to the goal of
the testcase occurred.

I agree that tst_res with TBROK doesn't make much sense. I see TBROK as
something we can't recover from and need to end the test. Otherwise
if we want to skip part of test, then TCONF looks more fitting.

