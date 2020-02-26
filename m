From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 Feb 2020 13:48:26 +0100
Subject: [LTP] [PATCH 1/1] request_key04: Use TFAIL instead of TBROK
In-Reply-To: <20200226113757.GA24342@dell5510>
References: <20200226084249.29561-1-pvorel@suse.cz>
 <CAEemH2cMBtVV-1_RZb_UHN9rQF3sD2w-H2gS11BD2WHPTPzvgQ@mail.gmail.com>
 <20200226091824.GA2215@dell5510>
 <CAEemH2cXGOh=MX28kYvhFaHspHGXiVdGuNZeyN97+O3+bt1jGg@mail.gmail.com>
 <20200226113757.GA24342@dell5510>
Message-ID: <20200226124826.GA24080@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > In personally, I'd let tst_res() only accept 'TPASS, TFAIL, TINFO, TCONF,
> > TWARN'.
> +1. Cyril, Jan?

I guess that it does not make much sense to report TBROK and then
continue the test. But that all depends on how exactly are these states
defined. Have we ever wrote them down?

I guess that TPASS and TFAIL are obvious.

TINFO is just additional information.

TCONF is test skipped.

TWARN something went wrong but we decided to continue?

TBROK something went wrong and we decided to exit?

-- 
Cyril Hrubis
chrubis@suse.cz
