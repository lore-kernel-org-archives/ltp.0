From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Mar 2021 12:09:27 +0100
Subject: [LTP] [PATCH v2 2/2] doc: Add Maintainer Patch Review Checklist
In-Reply-To: <YFRvZ89AykS5ldJj@yuki.lan>
References: <20210318181641.2062-1-pvorel@suse.cz>
 <20210318181641.2062-3-pvorel@suse.cz>
 <60546E24.9010601@fujitsu.com> <YFRvZ89AykS5ldJj@yuki.lan>
Message-ID: <YFSGZ9YKo/JUHMtm@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Hi!
> > Should we add license or copyright check in this checklist? It maybe
> > removed when converting old case into new api.

Great point, thanks.

> Good point, we should state the default license for new tests and also
> state that the licence for tests should not change unless they are
> completely rewritten.


Maybe:

* license: the default license for new tests is GPL v2 or later, use
  GPL-2.0-or-later; the licence for test (e.g. GPL-2.0) should not change unless
  it's completely rewritten
* old copyrights should be kept unless test is completely rewritten

BTW this is important, specially for DMCA from Wipro. Cyril, can you point some
test from Wipro which could be considered as "completely rewritten"?

Kind regards,
Petr
