From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Sep 2020 10:40:39 +0200
Subject: [LTP] TPASS in new test lib
In-Reply-To: <CY4PR13MB1175364547D2DA3A96262516FD210@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CY4PR13MB117565A7BA2A8371A3B94ED9FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200916071106.GB1433@dell5510> <20200916085405.GB4464@yuki.lan>
 <CY4PR13MB1175364547D2DA3A96262516FD210@CY4PR13MB1175.namprd13.prod.outlook.com>
Message-ID: <20200917084039.GA2352@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> That's fine.  But it's probably better to avoid differences in
> test output as much as possible, when the change is so trivial.  Petr seems to think
> there was a reason that the result string was changed between the old and new C library.
> If so, what is the reason?  If the change is only cosmetic, then I'd argue it's worth
> being consistent, and I'll submit the patch properly.  (Sorry the earlier version was
> inline in the message, rather than formatted correctly.)

I do not think that there was a strong reason for the difference apart
from an attempt to make the messages easier to read for a human reader
and to make it easier to figure out what exactly happened. The format of
the output messages was changed quite a bit in order to do that.

And as I said I do not have a strong opinion here, if you think that
this is important I'm okay with the changes.

-- 
Cyril Hrubis
chrubis@suse.cz
