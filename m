From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 25 Feb 2021 09:00:02 +0100
Subject: [LTP] [PATCH 1/1] brk02: Add test for removing more than one VMA
In-Reply-To: <20210224213520.rfdk2hdslqua7a2c@revolver>
References: <20210209143702.2003038-1-Liam.Howlett@Oracle.com>
 <20210209143702.2003038-2-Liam.Howlett@Oracle.com>
 <YCZYB2w+Il5F0TlI@pevik> <20210224213520.rfdk2hdslqua7a2c@revolver>
Message-ID: <YDdZAu9KlOsVToML@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Liam,

> > > +	addr += page_size;
> > > +	if (brk(addr))
> > > +		return;
> > You need to add tst_ret(TFAIL, "failed due ..."); before each return otherwise
> > you get error:
> > tst_test.c:1080: TBROK: Test haven't reported results!

> I believe you mean tst_res().  I will fix it.
Yes, sorry for typo.

Thanks for your work!

Kind regards,
Petr
